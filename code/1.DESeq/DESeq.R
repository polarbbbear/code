
#source("https://bioconductor.org/biocLite.R")
#biocLite("DESeq")
#biocLite("limma")
#install.packages("gplots")

foldChange=1
padj=0.05


setwd(" ")#Set the path              
library("DESeq")
library("limma")

rt=read.table("mRNAexp.txt",sep="\t",header=T,check.names=F)  
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>1,] 
data=round(data,0)

group=c(rep("non-recurrence",158),rep("recurrence",148))   
design = factor(group)
newTab = newCountDataSet( data, design )
newTab = estimateSizeFactors(newTab)
newData=counts(newTab, normalized=TRUE )

#have replicates
newTab = estimateDispersions( newTab, fitType = "local")
diff = nbinomTest( newTab, "non-recurrence", "recurrence")
diff = diff[is.na(diff$padj)==FALSE,]
diff = diff[order(diff$pval),]
write.table( diff, file="DESeqOut.xls",sep="\t",quote=F,row.names=F)
diffSig = diff[(diff$padj < padj & (diff$log2FoldChang>foldChange | diff$log2FoldChange<(-foldChange))),]
write.table( diffSig, file="diffSig.xls",sep="\t",quote=F,row.names=F)
diffUp = diff[(diff$padj < padj & (diff$log2FoldChang>foldChange)),]
write.table( diffUp, file="up.xls",sep="\t",quote=F,row.names=F)
diffDown = diff[(diff$padj < padj & (diff$log2FoldChange<(-foldChange))),]
write.table( diffDown, file="down.xls",sep="\t",quote=F,row.names=F)
