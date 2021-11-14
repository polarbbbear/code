install.packages("estimate", repos="http://R-Forge.R-project.org")
library(estimate)
setwd(" ")#Set the path


rt <-read.table("mRNAexp.txt",sep="\t",header=T,row.names=1,check.names=F)
View(rt)

estimateScore(input.ds = "mRNAexp.txt", #输入文件
              output.ds="estimateScore.gct", #输出文件
              platform="illumina") #注意平台，如果为TCGA或者测序数据则选择illumina

