library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(streamR)
library(dplyr) 

# Declare Twitter API Credentials
api_key <- "bNcpnkZVRB8fXRqb7XVWdVMOA" # From dev.twitter.com
api_secret <- "OgIqQwfIExmDZm76nxlbffN2UYH2iDTopPbbTvBLdXI948j9F8" # From dev.twitter.com
token <- "1444647248-8fnJMQ8yEwvWj60wdGIw202S0xEmNgeAjwP0XoH" # From dev.twitter.com
token_secret <- "YvuucT2r8Y6jymMZWZRxSHtXEZhFAagXz0djwOtUFohaR" # From dev.twitter.com

# Create Twitter Connection
setup_twitter_oauth(api_key, api_secret, token, token_secret)

# Set input variables to search through Twitter during game 
team1 <- "" # Home Team as a String for Search Term
team2 <- "" # Away Team as a String for Search Term
date <- "" # Date of Game 
startTime <- "" # Start Time of Game as a String
endTime <- "" # Start Time of Game as a String 
timezone <- "" # Timezone of Game as a String

# Column 1: Time, Column 2: NumberOfTweets
final.plot.tweets <- 

runTwitterSearch <- function(team1, team2, date, startTime, timezone) {

  # Run Twitter Search. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until).
  tweets <- searchTwitter("Lebron James", n=10000, lang="en", since=(date), until=(date))
  
  tweets.df <- twListToDF(tweets)
  
  tweets.df$created <- as.POSIXct(tweets.df$created)
  
  final.tweets <- filter(tweets.df, created > as.POSIXct(startTime, tz = timezone)) 
  endTime <- startTime + 150
  final.tweets <- filter(tweets.df, created <= as.POSIXct(endTime, tz = timezone)) # Average length of games is 2.5 hours (150 mins)
  
  startTime <- as.POSIXct(startTime)
  endTime <- as.POSIXct(endTime) 
  currTime <- startTime 
  
  # Loop through for each minute of tweets for the entire duration of game and count number of tweets 
  while(currTime <= endTime) {
    final.tweets.minute <- filter(final.tweets, created > currTime)
    final.tweets.minute <- filter(final.tweets, created <= endTime)
    final.plot.tweets$NumberOfTweets <- nrow(final.tweets.minute)
    currTime <- currTime + 60 
  }
}
