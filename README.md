# We The Hack @ NBA Hackathon 2017 in NYC
As a team of 3 engineering students from the University of Toronto, we created an ensemble model to predict the occurrence of "exciting" runs during an NBA game. In basketball, a run is when a team scores consecutive unanswered points to surpass the opponent. This creates excitement for fans cheering on the team behind the run, while the opponents are at the edge of their seats.

Together with machine learning tools and using the Twitter API, we'd like to walk you through our project methodology. Each of the .R files can be run on your machine; however, please change the filepath based on the location of your files to read them in. 

## Definining a Run 
We defined a run as 8 unanswered points based on a play-by-play estimation, validated with historical box score data.

* Runs_Identifier.go

## Predicting Win Percentage 
We performed exploratory data analysis on extracted and cleaned up play-by-play data. 

* NBA_PlaybyPlay_Generation.R

Through this, we developed win percentage during games through a linear regression model with a 92.9% accuracy and mean-squared error of 0.0014. To avoid over-fitting, we performed k=10 fold cross validation. 

* LinearRegressionModel.R

Point Differential was found to be the most significant feature. 

## Predicting Breakout Points
Then, we used a machine learning package called 'Breakout Point' in R on to detect change in a given time series of win percentage over the time of a game. By incorporating this method, our model can now highlight important and "exciting" runs in the ```{r}loc``` variable of the results ```{r}res``` for each game, running the package's ```{r}breakout``` method.

* BreakoutDetection.R

## Social Media Analysis with Twitter
In today’s age, social media is a barometer for fan sentiment. Since excitement is subjective, this can be a qualitative measure. As a result, we also analyzed Twitter data during games. 

We calculated the sentiment score for a sample of tweets at the "exciting" breakout points in win percentage data, which used a natural language processing package in R.

* TwitterSentimentAnalysis.R 

Our model also interacts with the Twitter API to monitor spikes in tweet traffic during games.

* TwitterAPI.R

We hope you've enjoyed learning more about run prediction in the NBA! #WeTheHack


