library(caret)
set.seed(666)
setwd(" ")#Set the path

#logistic step
data <-read.table("data.txt",sep="\t",header=T,row.names=1,check.names=F)#input the 60 mRNAs
set.seed(666)
dataselect <-createDataPartition(y=data$recurrence,p=0.7,list=FALSE)
train <- data[dataselect, ] 
test <- data[-dataselect, ] 

LR_model <- glm(recurrence ~ ., data = train, binomial(link='logit'),control=list(maxit=100) )
logit.step <- step(LR_model,direction="both")
summary(logit.step)

glm.probs1 <- predict(logit.step,train[,-1],type="response")
plot(roc(glm.probs1,as.factor(train$recurrence)), col='red')
lr.auc <- auc(roc(glm.probs1,as.factor(train$recurrence)))
text(0.8, 0.2, labels=paste('AUC=', round(lr.auc, 4), sep=''), cex=1.2)

glm.probs2 <- predict(logit.step,test[,-1],type="response")                    
plot(roc(glm.probs2,as.factor(test$recurrence)), col='blue')
lr.auc <- auc(roc(glm.probs2,as.factor(test$recurrence)))
text(0.8, 0.2, labels=paste('AUC=', round(lr.auc, 4), sep=''), cex=1.2)


