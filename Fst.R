#!/usr/bin/env Rscript
#Fst.R

#a file that is accessed by fst_slidingwindow.sh to create a pdf of an fst sliding window scan (just like it sounds dummy)

args = commandArgs()

dataset <- args[6]
outDir <- args[7]
pops <- args[8]
name <- args[9]
window <- args[10]

library(qqman)
fst<-read.table(print0($outDir,"/",$name,".windowed.weir.fst"), header=TRUE)
fstsubset<-fst[complete.cases(fst),]
SNP<-c(1: (nrow(fstsubset)))
mydf<-data.frame(SNP,fstsubset)

pdf(file = print0($outDir,"/",$name,".pdf"), width = 20, height = 7, useDingbats=FALSE)
print(manhattan(mydf,chr="CHROM",bp="BIN_START",p="WEIGHTED_FST",snp="SNP",logp=FALSE,ylab="Weighted Weir and Cockerham Fst"))
dev.off()
