### Required Libraries
library(rio)
library(dplyr)
library(plyr) 
library(tidyr)
library(ggplot2)
library(GGally)
library(boot)
library(neuralnet)

### LINEAR REGRESSION
#Initial Data Set
data <- read.csv(file='NBA_data.csv')

### Break up data into training and testing
index <- sample(1:nrow(data),round(0.75*nrow(data)))
train <- data[index,]
test <- data[-index,]

### Linear Fit using 10 fold cross validation (boot strapping)
set.seed(200)
lm.fit <- glm(WINPCTG~.,data=data)
# MSE calculation
lm.boot <- cv.glm(data,lm.fit,K=10)$delta[1]
# summary(lm.fit)
# prediction
pr.lm <- predict(lm.fit,test)
# prediction with play by play data set, data5
data5 <- read.csv(file='Game_Scores_2016.csv')
pr.lm <- predict(lm.fit,data5)

## Residual Plots for normality check
fit.res = resid(lm.fit)
plot(density(resid(lm.fit))) #A density plot
qqnorm(fit.res) # A quantile normal plot - good for checking normality
qqline(fit.res)

# Accuracy Calculation
accCalc <- 1 - sum(abs(pr.lm -test[18]) / test[18]) / dim(test)
acc <- accCalc[1]

### NEURAL NET - was deemed too complicated for the purpose of the application
# Read data, and split into test and train sets
data <- read.csv(file='NBA_data.csv')
index <- sample(1:nrow(data),round(0.75*nrow(data)))
train <- data[index,]
test <- data[-index,]

# Normalize data before running net
maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)

# Scaling formula
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))

# Distribute scaling to train and test
train_ <- scaled[index,]
test_ <- scaled[-index,]

# Running the net
n <- names(train_)
f <- as.formula(paste("WINPCTG ~", paste(n[!n %in% "WINPCTG"], collapse = " + ")))
nn <- neuralnet(f,data=train_,hidden=c(5,3),linear.output=T)

#Plot the net
plot(nn)

# prediction with play by play data set, data5
data5 <- read.csv(file='Game_Scores_2016.csv')
prediction <- compute(nn,data5)

### Bootstrap the net - optinal, however this removes any biases
# set up for 10 cross fold validation process
set.seed(450)
cv.error <- NULL
k <- 10

pbar <- create_progress_bar('text')
pbar$init(k)

# loop to generate neural nets based on 10 'folds'
for(i in 1:k){
  index <- sample(1:nrow(data),round(0.9*nrow(data)))
  train.cv <- scaled[index,]
  test.cv <- scaled[-index,]
  
  nn <- neuralnet(f,data=train.cv,hidden=c(5,2),linear.output=T)
  
  pr.nn <- compute(nn,test.cv[,1:17])
  pr.nn <- pr.nn$net.result*(max(data$WINPCTG)-min(data$WINPCTG))+min(data$WINPCTG)
  
  test.cv.r <- (test.cv$WINPCTG)*(max(data$WINPCTG)-min(data$WINPCTG))+min(data$WINPCTG)
  
  cv.error[i] <- sum((test.cv.r - pr.nn)^2)/nrow(test.cv)
  
  pbar$step()
}
mean(cv.error)

#compare linear model to neural network using mse
pr.nn <- compute(nn,test_[,1:17])
pr.nn_ <- pr.nn$net.result*(max(data$WINPCTG)-min(data$WINPCTG))+min(data$WINPCTG)
test.r <- (test_$WINPCTG)*(max(data$WINPCTG)-min(data$WINPCTG))+min(data$WINPCTG)
MSE.nn <- sum((test.r - pr.nn_)^2)/nrow(test_)

#compare mse's
print(paste(MSE.lm,MSE.nn))

#graph compare
plot(test$WINPCTG,pr.nn_,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
points(test$WINPCTG,pr.lm,col='blue',pch=18,cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend=c('NN','LM'),pch=18,col=c('red','blue'))

#boxplot
boxplot(cv.error,xlab='MSE CV',col='cyan',
        border='blue',names='CV error (MSE)',
        main='CV error (MSE) for NN',horizontal=TRUE)