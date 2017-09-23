library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(streamR)
library(dplyr) 
library(sqldf)

# Declare Twitter API Credentials
api_key <- "bNcpnkZVRB8fXRqb7XVWdVMOA" # From dev.twitter.com
api_secret <- "OgIqQwfIExmDZm76nxlbffN2UYH2iDTopPbbTvBLdXI948j9F8" # From dev.twitter.com
token <- "1444647248-8fnJMQ8yEwvWj60wdGIw202S0xEmNgeAjwP0XoH" # From dev.twitter.com
token_secret <- "YvuucT2r8Y6jymMZWZRxSHtXEZhFAagXz0djwOtUFohaR" # From dev.twitter.com

# Create Twitter Connection
setup_twitter_oauth(api_key, api_secret, token, token_secret)

gametime <- read.csv(file = ("/Users/alisonchow/Downloads/NBA_Schedule2016.csv"), stringsAsFactors=FALSE)

# Column 1: Time, Column 2: NumberOfTweets
final.plot.tweets <- read.csv("/Users/alisonchow/Documents/finaldata.csv")

runTwitterSearch <- function(team1, team2, date, startTime) {
  
  # Run Twitter Search. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until).
  endDate <- toString(as.POSIXct(date)+86400)
  tweets <- searchTwitter(team1, n=100, lang="en", since=(date),until=(endDate))
  tweets.df <- twListToDF(tweets)
  
  tweets.df$created <- as.POSIXct(tweets.df$created)
  
  final.tweets <- filter(tweets.df, created > as.POSIXct(startTime, tz = "GMT")) 
  endTime <- startTime + 9000
  final.tweets <- filter(tweets.df, created <= as.POSIXct(endTime, tz = "GMT")) # Average length of games is 2.5 hours (150 mins)
  
  startTime <- as.POSIXct(startTime)
  endTime <- as.POSIXct(endTime) 
  currTime <- startTime 
  
  # Loop through for each minute of tweets for the entire duration of game and count number of tweets 
  initial <- 1
  while(currTime <= endTime) {
    final.tweets.minute <- filter(final.tweets, created > currTime)
    final.tweets.minute <- filter(final.tweets, created <= endTime)
    final.plot.tweets$NumberOfTweets[initial] <- nrow(final.tweets.minute)
    currTime <- currTime + 60 
    initial <- initial + 1
  }
}

i <- 1
while (i <= 2) {
  
# Set input variables to search through Twitter during game 
  
  team1 <- gametime$HOME[i]  # Home Team as a String for Search Term
  team2 <- gametime$AWAY[i] # Away Team as a String for Search Term
  date <- gametime$DATE[i] # Date of Game 
  startTime <- gametime$TIME..GMT.[i] # Start Time of Game as a String
  runTwitterSearch(team1, team2, date, startTime)
  i <- i + 1
}

