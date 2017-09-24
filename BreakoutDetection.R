library(BreakoutDetection)

# Input data as a .csv file of Play by Play Probability of Winning 
playbyplay <- read.csv("/Users/alisonchow/Downloads/PlayByPlayProbability.csv")

# Get each game's play by plays 
playbyplay1 <- playbyplay[which(playbyplay$Game_id==21600001),c(1:2)]

playbyplay1 <- data.frame(playbyplay1$probability)

playbyplay1 <- as.numeric(unlist(playbyplay1))

# Call the in-package breakout method to retrieve and plot the breakout points 

breakout(playbyplay1, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay2 <- playbyplay[which(playbyplay$Game_id==21600002),c(1:2)]

playbyplay2 <- data.frame(playbyplay2$probability)

playbyplay2 <- as.numeric(unlist(playbyplay2))

breakout(playbyplay2, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay3 <- playbyplay[which(playbyplay$Game_id==21600003),c(1:2)]

playbyplay3 <- data.frame(playbyplay3$probability)

playbyplay3 <- as.numeric(unlist(playbyplay3))

breakout(playbyplay3, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay4 <- playbyplay[which(playbyplay$Game_id==21600004),c(1:2)]

playbyplay4 <- data.frame(playbyplay4$probability)

playbyplay4 <- as.numeric(unlist(playbyplay4))

breakout(playbyplay4, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay5 <- playbyplay[which(playbyplay$Game_id==21600005),c(1:2)]

playbyplay5 <- data.frame(playbyplay5$probability)

playbyplay5 <- as.numeric(unlist(playbyplay5))

breakout(playbyplay5, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay6 <- playbyplay[which(playbyplay$Game_id==21600006),c(1:2)]

playbyplay6 <- data.frame(playbyplay6$probability)

playbyplay6 <- as.numeric(unlist(playbyplay6))

breakout(playbyplay6, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay7 <- playbyplay[which(playbyplay$Game_id==21600007),c(1:2)]

playbyplay7 <- data.frame(playbyplay7$probability)

playbyplay7 <- as.numeric(unlist(playbyplay7))

breakout(playbyplay7, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay8 <- playbyplay[which(playbyplay$Game_id==21600008),c(1:2)]

playbyplay8 <- data.frame(playbyplay8$probability)

playbyplay8 <- as.numeric(unlist(playbyplay8))

breakout(playbyplay8, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay9 <- playbyplay[which(playbyplay$Game_id==21600009),c(1:2)]

playbyplay9 <- data.frame(playbyplay9$probability)

playbyplay9 <- as.numeric(unlist(playbyplay9))

breakout(playbyplay9, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)

playbyplay10 <- playbyplay[which(playbyplay$Game_id==21601136),c(1:2)]

playbyplay10 <- data.frame(playbyplay10$probability)

playbyplay10 <- as.numeric(unlist(playbyplay10))

breakout(playbyplay10, min.size=10, method='multi', beta=.001, degree=1, plot=TRUE)
