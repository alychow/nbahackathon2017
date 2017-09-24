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