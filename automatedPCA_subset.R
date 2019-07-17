#!/usr/bin/env Rscript

#a file that is accessed by PCA_r to conduct principle component analyses

args = commandArgs()

dataset <- args[6]
outDir <- args[7]
pops <- args[8]
name <- args[9]

library(gdsfmt)
library(SNPRelate)

#open the GDS file
genofile <- snpgdsOpen(paste0(outDir,"/"name,".gds"))

#get population information
pop_code <- scan(paste(pops), what=character())
table(pop_code)

#prune SNPS based on linkage disequilibrium
set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2, autosome.only = FALSE)
snpset.id <- unlist(snpset)

#run PCA
#with subsetted snps
pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=2, autosome.only = FALSE)

#to calculate percent of variation that is accounted for by top PCA components:
pc.percent <- pca$varprop*100
sink(paste0(outDir,"/",name,"_percentvariation.txt"), append=TRUE, split=FALSE)
head(round(pc.percent, 2))
sink()

#get sample id
sample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))

#make data frame
tab <- data.frame(sample.id = pca$sample.id,
pop = factor(pop_code)[match(pca$sample.id, sample.id)],
EV1 = pca$eigenvect[,1],    # the first eigenvector
EV2 = pca$eigenvect[,2],    # the second eigenvector
stringsAsFactors = FALSE)

#save files:
write.table(tab, file = paste0(outDir,"/"name,".txt"), sep = "\t")

tab <- read.table(paste0(outDir,"/"name,"_subset.txt"), header = TRUE, sep = "\t")


#draw it:
pdf(file = paste0(outDir,"/",name,"_pca_populations_subsetted.pdf"), useDingbats=FALSE)

plot(tab$EV2, tab$EV1, col=as.integer(tab$pop), xlab="eigenvector 2", ylab="eigenvector 1")
legend("topright", legend=levels(tab$pop), pch="o", col=1:nlevels(tab$pop))

dev.off()

pdf(file = paste0(outDir,"/",name,"_pca_individuals_subsetted.pdf"), useDingbats=FALSE)

plot(tab$EV2, tab$EV1, col=as.integer(tab$sampleid), xlab="eigenvector 2", ylab="eigenvector 1")
legend("topright", legend=levels(tab$sampleid), pch="o", col=1:nlevels(tab$sampleid))

dev.off()