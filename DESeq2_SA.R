library(DESeq2)
library(DEGreport)
library(tibble)
library(ggplot2)
library(tximport)
library(readr)

#txi <- readRDS(file = "/Users/rbadgami/Desktop/data2/read_count_data/txi.RData")
### Get previous data that will feed into this
#source('~/Desktop/data2/Rscripts_2/tximport.R')
#source('~/Desktop/data2/Rscripts_2/DESeq2_initial.R')

dds <- DESeqDataSetFromTximport(txi,colData=ExpVar,design=~cultivar_isolate)

dds <- DESeqDataSetFromTximport(txi, colData=ExpVar, design= ~ cultivar + timepoint + cultivar:timepoint)
dds$cultivar_isolate=as.factor(dds$cultivar_isolate)
dds$cultivar=as.factor(dds$cultivar)
dds$timepoint=as.factor(dds$timepoint)
dds$isolate=as.factor(dds$isolate)

design(dds) <- formula(~cultivar + timepoint + cultivar:timepoint)
dds <- dds[rowSums(counts(dds)) > 1, ]

#### filter for Santiago at each timepoint ####
dds_SA <- dds[, dds$cultivar == 'SA']
dds_SA$cultivar <- droplevels(dds_SA$cultivar)
dds_SA$timepoint=as.factor(dds_SA$timepoint)
dds_SA_normalised_counts <- counts(dds_SA, normalized=TRUE)
#timepoint
dds_SA_1dpi <- dds_SA[, dds_SA$timepoint == "1"]
dds_SA_1dpi$timepoint <- droplevels(dds_SA_1dpi$timepoint)
dds_SA_3dpi <- dds_SA[, dds_SA$timepoint == "3"]
dds_SA_3dpi$timepoint <- droplevels(dds_SA_3dpi$timepoint)
dds_SA_7dpi <- dds_SA[, dds_SA$timepoint == "7"]
dds_SA_7dpi$timepoint <- droplevels(dds_SA_7dpi$timepoint)
dds_SA_11dpi <- dds_SA[, dds_SA$timepoint == "11"]
dds_SA_11dpi$timepoint <- droplevels(dds_SA_11dpi$timepoint)

#cultivars
dds_SA_1dpi_F22v1314 <- dds_SA_1dpi[, dds_SA_1dpi$isolate %in% c("1314", "F22")]
dds_SA_1dpi_F22v1314$isolate <- droplevels(dds_SA_1dpi_F22v1314$isolate)
dds_SA_3dpi_F22v1314 <- dds_SA_3dpi[, dds_SA_3dpi$isolate %in% c("1314", "F22")]
dds_SA_3dpi_F22v1314$isolate <- droplevels(dds_SA_3dpi_F22v1314$isolate)
dds_SA_7dpi_F22v1314 <- dds_SA_7dpi[, dds_SA_7dpi$isolate %in% c("1314", "F22")]
dds_SA_7dpi_F22v1314$isolate <- droplevels(dds_SA_7dpi_F22v1314$isolate)

#### Fit generalised linear (negative binomial) model ####
design(dds_SA_1dpi_F22v1314) <- formula(~ isolate)
dds_SA_1dpi_F22v1314 <- DESeq(dds_SA_1dpi_F22v1314)
design(dds_SA_3dpi_F22v1314) <- formula(~ isolate)
dds_SA_3dpi_F22v1314 <- DESeq(dds_SA_3dpi_F22v1314)
design(dds_SA_7dpi_F22v1314) <- formula(~ isolate)
dds_SA_7dpi_F22v1314 <- DESeq(dds_SA_7dpi_F22v1314)

##### check sizefactors ####
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_F22v1314.txt", append=TRUE, split=TRUE)
sizefactors(dds_SA_1dpi_F22v1314)
estimateSizeFactors(dds_SA_1dpi_F22v1314)
colSums(counts(dds_SA_1dpi_F22v1314))
colSums(counts(dds_SA_1dpi_F22v1314, normalized=T))
sizefactors(dds_SA_3dpi_F22v1314)
estimateSizeFactors(dds_SA_3dpi_F22v1314)
colSums(counts(dds_SA_3dpi_F22v1314))
colSums(counts(dds_SA_3dpi_F22v1314, normalized=T))
sizefactors(dds_SA_7dpi_F22v1314)
estimateSizeFactors(dds_SA_7dpi_F22v1314)
colSums(counts(dds_SA_7dpi_F22v1314))
colSums(counts(dds_SA_7dpi_F22v1314, normalized=T))
sink()
#### gene-wise dispersion estimations ####
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_F22v1314_DispEst.pdf", height=11, width=8.5)
plotDispEsts(dds_SA_1dpi_F22v1314, main = "DispEst 1dpi 13/14-SAvF22-SA")
plotDispEsts(dds_SA_3dpi_F22v1314, main = "DispEst 3dpi 13/14-SAvF22-SA")
plotDispEsts(dds_SA_7dpi_F22v1314, main = "DispEst 7dpi 13/14-SAvF22-SA")
dev.off()

#### HYPOTHESIS TESTING - WALD TEST ####
# null hypothesis = no differential expression across the two sample groups (LFC == 0)
# For each dpi 1,3,7,11dpi for 1314 and F22:
# - pairwise comparisons:
# (1) SA vs OA
# (2) SO v OA
# (3) SA v SO

#### define contrasts ####
## What comparisons will be made
contrast_isolate_1314vF22 <- c("isolate", "F22", "1314")

#### extract results table ####
res_table_SA_1dpi_F22v1314_unshrunken <- results(dds_SA_1dpi_F22v1314, contrasts=contrast_isolate_1314vF22, alpha = 0.05)
res_table_SA_3dpi_F22v1314_unshrunken <- results(dds_SA_3dpi_F22v1314, contrasts=contrast_isolate_1314vF22, alpha = 0.05)
res_table_SA_7dpi_F22v1314_unshrunken <- results(dds_SA_7dpi_F22v1314, contrasts=contrast_isolate_1314vF22, alpha = 0.05)

#### and shrink the log2 fold changes ####
res_table_SA_1dpi_F22v1314_shrunk <- lfcShrink(dds_SA_1dpi_F22v1314, contrast=contrast_isolate_1314vF22, res=res_table_SA_1dpi_F22v1314_unshrunken)
res_table_SA_3dpi_F22v1314_shrunk <- lfcShrink(dds_SA_3dpi_F22v1314, contrast=contrast_isolate_1314vF22, res=res_table_SA_3dpi_F22v1314_unshrunken)
res_table_SA_7dpi_F22v1314_shrunk <- lfcShrink(dds_SA_7dpi_F22v1314, contrast=contrast_isolate_1314vF22, res=res_table_SA_7dpi_F22v1314_unshrunken)

#### results as MA plots - see sigDEGs across range levels ####
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_1314vF22_MAplots.pdf", height=11, width=8.5)
plotMA_res_table_SA_1dpi_F22v1314_unshrunken <- plotMA(res_table_SA_1dpi_F22v1314_unshrunken, ylim=c(-10,10), main="MAplot 1dpi 13/14-SA v F22-SA unshrunken")
plotMA_res_table_SA_1dpi_F22v1314_shrunk <- plotMA(res_table_SA_1dpi_F22v1314_shrunk, ylim=c(-10,10), main="MAplot 1dpi 1314-SA v F22-SA")
plotMA_res_table_SA_3dpi_F22v1314_unshrunken <- plotMA(res_table_SA_3dpi_F22v1314_unshrunken, ylim=c(-10,10), main="MAplot 3dpi 13/14-SA v F22-SA unshrunken")
plotMA_res_table_SA_3dpi_F22v1314_shrunk <- plotMA(res_table_SA_3dpi_F22v1314_shrunk, ylim=c(-10,10), main="MAplot 3dpi 1314-SA v F22-SA")
plotMA_res_table_SA_7dpi_F22v1314_unshrunken <- plotMA(res_table_SA_7dpi_F22v1314_unshrunken, ylim=c(-10,10), main="MAplot 7dpi 13/14-SA v F22-SA unshrunken")
plotMA_res_table_SA_7dpi_F22v1314_shrunk <- plotMA(res_table_SA_7dpi_F22v1314_shrunk, ylim=c(-10,10), main="MAplot 7dpi 1314-SA v F22-SA")
dev.off()

#### EXPLORE RESULTS ####
#multiple testing problem: more genes tested, more false positive rate
# - DESeq2 removes unlikely genes with low count numbers and outlier samples (gene-levelQC)
# - correct for multiple testing to reduce false positives using Benjamini-Hochberg method
# ALWAYS USE p-adj method, uses FDR<0.05
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_1314vF22_results.txt", append=TRUE, split=TRUE)
class(res_table_SA_1dpi_F22v1314_shrunk)
class(res_table_SA_3dpi_F22v1314_shrunk)
class(res_table_SA_7dpi_F22v1314_shrunk)

#check comparison (thus LFC) as expected i.e. CON~reference
mcols(res_table_SA_1dpi_F22v1314_shrunk, use.names=T)
mcols(res_table_SA_3dpi_F22v1314_shrunk, use.names=T)
mcols(res_table_SA_7dpi_F22v1314_shrunk, use.names=T)

# check column names
colnames(res_table_SA_1dpi_F22v1314_shrunk)
colnames(res_table_SA_3dpi_F22v1314_shrunk)
colnames(res_table_SA_7dpi_F22v1314_shrunk)
sink()

##### SUMMARISE RESULTS ####
#### tells whats up/down-regulated and number genes with non-zero total read count and number genes not included ####
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_F22v1314_summary.txt", append=TRUE, split=TRUE)
summary(res_table_SA_1dpi_F22v1314_shrunk)
summary(res_table_SA_3dpi_F22v1314_shrunk)
summary(res_table_SA_7dpi_F22v1314_shrunk)
sink()
#### subset table to include only those that are significant ####
## set thresholds
padj.cutoff <- 0.05
# subset table to include only those that are significant
library(tibble)
library("dplyr")
sig_SA_1dpi_F22v1314_shrunk <- filter(as_tibble(rownames_to_column(data.frame(res_table_SA_1dpi_F22v1314_shrunk), var="gene")), padj < padj.cutoff)
sig_SA_3dpi_F22v1314_shrunk <- filter(as_tibble(rownames_to_column(data.frame(res_table_SA_3dpi_F22v1314_shrunk), var="gene")), padj < padj.cutoff)
sig_SA_7dpi_F22v1314_shrunk <- filter(as_tibble(rownames_to_column(data.frame(res_table_SA_7dpi_F22v1314_shrunk), var="gene")), padj < padj.cutoff)

sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA_F22v1314_summary.txt", append=TRUE, split=TRUE)
length(pull(as_tibble(rownames_to_column(data.frame(res_table_SA_1dpi_F22v1314_shrunk), var="gene"))))
length(pull(sig_SA_1dpi_F22v1314_shrunk, gene))
length(pull(as_tibble(rownames_to_column(data.frame(res_table_SA_3dpi_F22v1314_shrunk), var="gene"))))
length(pull(sig_SA_3dpi_F22v1314_shrunk, gene))
length(pull(as_tibble(rownames_to_column(data.frame(res_table_SA_3dpi_F22v1314_shrunk), var="gene"))))
length(pull(sig_SA_7dpi_F22v1314_shrunk, gene))
sink()

write.table(sig_SA_1dpi_F22v1314_shrunk, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/sig_SA_1dpi_F22v1314_shrunk.txt", quote=F, col.names=NA)
write.table(sig_SA_3dpi_F22v1314_shrunk, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/sig_SA_3dpi_F22v1314_shrunk.txt", quote=F, col.names=NA)
write.table(sig_SA_7dpi_F22v1314_shrunk, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/sig_SA_7dpi_F22v1314_shrunk.txt", quote=F, col.names=NA)

pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_SA F22v1314_hists.pdf", height=11, width=8.5)
hist(res_table_SA_1dpi_F22v1314_shrunk$padj, breaks=40, col="grey")
hist(res_table_SA_3dpi_F22v1314_shrunk$padj, breaks=40, col="grey")
hist(res_table_SA_7dpi_F22v1314_shrunk$padj, breaks=40, col="grey")
dev.off()



#### SUC/RES up/donwreg
write.table(filter(sig_SA_1dpi_F22v1314_shrunk, log2FoldChange > 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_1dpi_F22v1314_F22upreg.txt", quote=F, col.names=NA)
write.table(filter(sig_SA_3dpi_F22v1314_shrunk, log2FoldChange > 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_3dpi_F22v1314_F22upreg.txt", quote=F, col.names=NA)
write.table(filter(sig_SA_7dpi_F22v1314_shrunk, log2FoldChange > 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_7dpi_F22v1314_F22upreg.txt", quote=F, col.names=NA)
write.table(filter(sig_SA_1dpi_F22v1314_shrunk, log2FoldChange < 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_1dpi_F22v1314_1314upreg.txt", quote=F, col.names=NA)
write.table(filter(sig_SA_3dpi_F22v1314_shrunk, log2FoldChange < 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_3dpi_F22v1314_1314upreg.txt", quote=F, col.names=NA)
write.table(filter(sig_SA_7dpi_F22v1314_shrunk, log2FoldChange < 0), file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC_SA_7dpi_F22v1314_1314upreg.txt", quote=F, col.names=NA)

View(sig_SA_1dpi_F22v1314_shrunk)
