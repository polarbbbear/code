# install.packages("randomForest")
# install.packages("ROCR")
# install.packages("Hmisc")
# source("http://bioconductor.org/biocLite.R")
# biocLite("genefilter")
library(randomForest)
library(ROCR)
library(genefilter)
library(Hmisc)
setwd(" ")#set the path
train <-read.table("data.txt",sep="\t",header=T,row.names=1,check.names=F)#input the 60 variables



#set.seed(350)
#model <- randomForest(factor(recurrence)~., train, ntree = 500)
#plot(model)#Select the number of trees to build

#set.seed(350)
rf <- randomForest(factor(recurrence)~., train, importance = TRUE)#calculate the importance of each variable to recurrence
importance <- importance(x=rf)
varImpPlot(rf)
write.csv(importance,file = "importance.csv",sep="/t")
