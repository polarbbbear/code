
source("http://bioconductor.org/biocLite.R")   #source("https://bioconductor.org/biocLite.R")
biocLite("edgeR")
install.packages("gplots")

foldChange=1
padj=0.05

setwd(" ")#Set the path              
library("edgeR")
rt=read.table("mRNAexp.txt",sep="\t",header=T,check.names=F)  #input gene data
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>0,]


group=c(rep("non-recurrence",158),rep("recurrence",148))                       
design <- model.matrix(~group)
y <- DGEList(counts=data,group=group)
keep <- filterByExpr(y)
y <- y[keep, , keep.lib.sizes=FALSE]
y <- calcNormFactors(y)
y <- estimateCommonDisp(y)
y <- estimateTagwiseDisp(y)
et <- exactTest(y,pair = c("non-recurrence","recurrence"))
topTags(et)
ordered_tags <- topTags(et, n=100000)

allDiff=ordered_tags$table
allDiff=allDiff[is.na(allDiff$FDR)==FALSE,]
diff=allDiff
#newData=y$pseudo.counts

write.table(diff,file="edgerOut.xls",sep="\t",quote=F)
diffSig = diff[(diff$FDR < padj & (diff$logFC>foldChange | diff$logFC<(-foldChange))),]
write.table(diffSig, file="diffSig.xls",sep="\t",quote=F)
diffUp = diff[(diff$FDR < padj & (diff$logFC>foldChange)),]
write.table(diffUp, file="up.xls",sep="\t",quote=F)
diffDown = diff[(diff$FDR < padj & (diff$logFC<(-foldChange))),]
write.table(diffDown, file="down.xls",sep="\t",quote=F)

