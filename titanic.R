# Loading essential libraries
library(ggplot2) # Visual...
library(caTools) # Splitting 
library(dplyr)
library(e1071) 
library(randomForest)

train = read.csv('train.csv', stringsAsFactors = F)
train = train[, c(2, 3, 5, 6, 10)] # Getting only a few variables
X_train = train[-1]
y_train = train[, 1]
# Encoding the target feature as factor
y_train = factor(y_train, levels = c(0, 1))

test = read.csv('test.csv', stringsAsFactors = F)
test = test[, c(1, 2, 4, 5, 9)]

# Taking care of missing data 
# Getting age collum dollar sign, is.na return if the value is missing
X_train$Age = ifelse(is.na(X_train$Age),
                     ave(X_train$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     X_train$Age)
test$Age = ifelse(is.na(test$Age),
                     ave(test$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     test$Age)
test$Fare = ifelse(is.na(test$Fare),
                  ave(test$Fare, FUN = function(x) mean(x, na.rm = TRUE)),
                  test$Fare)

# Encoding categorical data Sex, male = 1 and female = 0
X_train$Sex = factor(X_train$Sex,
                           levels = c('male', 'female'),
                           labels = c(1,0)) #Labels of the new encoding
test$Sex = factor(test$Sex,
                     levels = c('male', 'female'),
                     labels = c(1,0)) #Labels of the new encoding

# Creating the classifier basis model random forest
classifier = randomForest(x = X_train,
                          y = y_train,
                          ntree = 5)

y_pred = predict(classifier, newdata = test[-1])

library(data.table)    
submission = data.table(PassengerId = test[, 1], Survived = y_pred)

write.csv(submission, file = 'submission.csv')
