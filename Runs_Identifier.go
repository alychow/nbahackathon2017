//We are looking at the average length of unanswered points by one team
package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"

	"github.com/xlsx"
)

// ConnectToTxt Connects to Text File
func ConnectToTxt(filedir string) (*os.File, bool) {
	file, err := os.OpenFile(filedir, os.O_RDWR|os.O_CREATE, 0755)
	if err != nil {
		fmt.Printf("Unable to Open Text File: %s\n", filedir)
		fmt.Println(err)
		return file, false
	}
	return file, true
}

//CreateErrorLog gets the path and creates the error file
func CreateErrorLog(path string) *os.File {
	CreateFile(path)
	errFile, err := ConnectToTxt(path)
	if !err {
		log.Fatal("Did not connect\n")
	}
	return errFile
}

//CreateFile creates a file
func CreateFile(path string) bool {
	var f, err = os.Create(path)
	if err != nil {
		log.Fatal(err)
		return false
	}
	f.Close()
	return true
}

func main() {
	// Create Error Log
	errFile := CreateErrorLog("error.log")
	log.SetOutput(errFile)
	defer errFile.Close()

	xFile, err := xlsx.OpenFile("Game_Scores_2016_raw.xlsx")
	if err != nil {
		fmt.Println(err)
	}

	for _, sheet := range xFile.Sheets {
		fmt.Println(sheet.Name)
		if sheet.Name == "Game_Scores_2016_raw" {
			//Map Column Information
			colNamesSlice := make(map[string]int)
			for i := 0; i < sheet.MaxCol; i++ {
				cellValue := sheet.Cell(0, i).Value
				colNamesSlice[cellValue] = i
			}
			//Track Column Index for each column
			home_index := colNamesSlice["Home_PTS"]
			visit_index := colNamesSlice["Visitor_PTS"]
			game_index := colNamesSlice["Game_id"]
			//Initialize trackers
			home_pts := 0.0
			visit_pts := 0.0
			unanswered_pts := 0.0
			current_game := 0.0
			num_unanswered_runs := 0.0
			//Keep track of max rows
			max_rows := sheet.MaxRow
			for i := 1; i < max_rows; i++ {
				//Get information from excel cells
				temp_pts, _ := strconv.ParseFloat(sheet.Cell(i, home_index).Value, 64)
				home_pts += temp_pts
				temp_pts, _ = strconv.ParseFloat(sheet.Cell(i, visit_index).Value, 64)
				visit_pts += temp_pts
				temp_val, _ := strconv.ParseFloat(sheet.Cell(i, game_index).Value, 64)
				current_game = temp_val
				//Keep track of which game the program is on
				fmt.Println(current_game)
				//If both teams have more than 0 points then the run has ended, reset team scores and calculate run length
				if home_pts != 0 && visit_pts != 0 {
					unanswered_pts += math.Abs(home_pts - visit_pts)
					home_pts = 0.0
					visit_pts = 0.0
					num_unanswered_runs++

				}
				//Check if the next row is a new game, if so reset all trackers
				next_game, _ := strconv.ParseFloat(sheet.Cell(i+1, game_index).Value, 64)
				if current_game != next_game {
					home_pts = 0.0
					visit_pts = 0.0
					current_game = 0.0
				}
			}
			fmt.Println(unanswered_pts / num_unanswered_runs)
		}
	}
}
