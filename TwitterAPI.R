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
team1 <- ""
team2 <- ""

# Run Twitter Search. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until).
tweets <- searchTwitter("Lebron James", n=10000, lang="en", since=("2017-09-21"), until=("2017-09-22"))
tweets.df <- twListToDF(tweets)
tweets.df$created <- as.POSIXct(tweets.df$created)
final.tweets <- filter(tweets.df, created > as.POSIXct("2017-09-21 20:39:18", tz ="GMT"))
