#library(tidyverse)
#library(caret)
#library(ggplot2)
#library(glmnet)

set.seed(666)
setwd(" ")#Set the path
data <-read.table("data.txt",sep="\t",header=T,row.names=1,check.names=F)#input the 60 mRNAs

dataselect <-createDataPartition(y=data$recurrence,p=0.7,list=FALSE)
train <- data[dataselect, ]  
test <- data[-dataselect, ] 

x1 <- as.matrix(train[,2:61])
y1 <- as.matrix(train[,1])

x2 <- as.matrix(test[,2:61])
y2 <- as.matrix(test[,1])

library(glmnet)
set.seed(123)
cv.lasso <- cv.glmnet(x1, y1, alpha = 1, family = "binomial")
plot(cv.lasso)
cv.lasso$lambda.min
coef(cv.lasso, cv.lasso$lambda.min)

# model with lambda.min
lasso.model <- glmnet(x1, y1, alpha = 1, family = "binomial",
                      lambda = cv.lasso$lambda.min)

#train set ROC
glm.probs1 <- predict(lasso.model,x1,type="response")
plot(roc(glm.probs1,as.factor(train$recurrence)), col='red')
lr.auc <- auc(roc(glm.probs1,as.factor(train$recurrence)))
text(0.8, 0.2, labels=paste('AUC=', round(lr.auc, 4), sep=''), cex=1.2)

#test set ROC
glm.probs2 <- predict(lasso.model,x2,type="response")                    
plot(roc(glm.probs2,as.factor(test$recurrence)), col='blue')
lr.auc <- auc(roc(glm.probs2,as.factor(test$recurrence)))
text(0.8, 0.2, labels=paste('AUC=', round(lr.auc, 4), sep=''), cex=1.2)
