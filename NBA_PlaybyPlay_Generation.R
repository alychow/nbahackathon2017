require(plyr)
require(sqldf)

play_by_play <- read.csv("/Users/ValarMorghulis/Desktop/Basketball Data-selected/Play_by_Play_New.csv")

#Find all plays where the clock time is 0
gametime <- play_by_play[play_by_play$Play_Clock_Time == 0,]

#Find all play by play pts differential in 2016 Season
game_2016 <- sqldf("SELECT Game_id,Season,Season_Type,Home_Tm,Away_Tm,(Home_PTS-Visitor_PTS) AS PT_Diff FROM play_by_play WHERE Season = 2016")
#Find play with the max period as it will be the end score
game_scores <- sqldf("SELECT Game_id,Season,Season_Type,Home_Tm,Away_Tm,case when Home - visit < 0 THEN 'Visit' ELSE 'Home' END AS Team_Win,(home-visit) as pt_diff FROM (SELECT Game_id,Season,Season_Type,Home_Tm,Away_Tm,max(Home_PTS) as home,max(Visitor_PTS) as visit,max(Period) FROM gametime GROUP BY 1,2,3,4,5) as A")
#Find all play by plays in 2016 Season
game_2016_raw <- sqldf("SELECT Game_id,Season,Season_Type,Home_Tm,Away_Tm,Home_PTS,Visitor_PTS FROM play_by_play WHERE Season = 2016")

#Write Dataframes to CSV
write.csv(game_scores,file="/Users/ValarMorghulis/Desktop/Basketball Data-selected/Game_Scores.csv")
write.csv(game_2016,file="/Users/ValarMorghulis/Desktop/Basketball Data-selected/Game_Scores_2016.csv")
write.csv(game_2016_raw,file="/Users/ValarMorghulis/Desktop/Basketball Data-selected/Game_Scores_2016_raw.csv")

