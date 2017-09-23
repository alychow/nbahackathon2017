library(BreakoutDetection)

# Input data as a .csv file of Play by Play Probability of Winning 
playbyplay <- read.csv("/Users/alisonchow/Downloads/PlayByPlayProbability.csv")

# Get the first game's play by plays 
playbyplay1 <- playbyplay[which(playbyplay$Game_id==21600001),c(1:2)]

playbyplay1 <- data.frame(playbyplay1$probability)

playbyplay1 <- as.numeric(unlist(playbyplay1))

breakout(playbyplay1, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

