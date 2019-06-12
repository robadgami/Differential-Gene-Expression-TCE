library(DESeq2)
library(DEGreport)
library(tibble)
library(ggplot2)
library(tximport)
library(readr)

txi <- readRDS(file = "/Users/rbadgami/Desktop/data2/read_count_data/txi.RData")


### Get previous data that will feed into this
source('~/Desktop/data2/Rscripts_2/tximport.R')
source('~/Desktop/data2/Rscripts_2/DESeq2_initial.R')

dds <- DESeqDataSetFromTximport(txi,colData=ExpVar,design=~cultivar_isolate)

## filter for timepointvsCON
dds_1dpi <- dds[, dds$timepoint %in% c("0", "1")]
dds_1dpi.SA <- dds_1dpi[, dds_1dpi$cultivar == "SA"]
dds_1dpi.SO <- dds_1dpi[, dds_1dpi$cultivar == "SO"]
dds_1dpi.OA <- dds_1dpi[, dds_1dpi$cultivar == "OA"]
dds_1dpi.1314_SAvsCON_SA <- dds_1dpi.SA[, dds_1dpi.SA$isolate == "1314" | dds_1dpi.SA$isolate == "CON" ]
dds_1dpi.F22_SAvsCON_SA <- dds_1dpi.SA[, dds_1dpi.SA$isolate == "F22" | dds_1dpi.SA$isolate == "CON" ]
dds_1dpi.1314_SOvsCON_SO <- dds_1dpi.SO[, dds_1dpi.SO$isolate == "1314" | dds_1dpi.SO$isolate == "CON" ]
dds_1dpi.F22_SOvsCON_SO <- dds_1dpi.SO[, dds_1dpi.SO$isolate == "F22" | dds_1dpi.SO$isolate == "CON" ]
dds_1dpi.1314_OAvsCON_OA <- dds_1dpi.OA[, dds_1dpi.OA$isolate == "1314" | dds_1dpi.OA$isolate == "CON" ]
dds_1dpi.F22_OAvsCON_OA <- dds_1dpi.OA[, dds_1dpi.OA$isolate == "F22" | dds_1dpi.OA$isolate == "CON" ]

dds_3dpi <- dds[, dds$timepoint %in% c("0", "3")]
dds_3dpi.SA <- dds_3dpi[, dds_3dpi$cultivar == "SA"]
dds_3dpi.SO <- dds_3dpi[, dds_3dpi$cultivar == "SO"]
dds_3dpi.OA <- dds_3dpi[, dds_3dpi$cultivar == "OA"]
dds_3dpi.1314_SAvsCON_SA <- dds_3dpi.SA[, dds_3dpi.SA$isolate == "1314" | dds_3dpi.SA$isolate == "CON" ]
dds_3dpi.F22_SAvsCON_SA <- dds_3dpi.SA[, dds_3dpi.SA$isolate == "F22" | dds_3dpi.SA$isolate == "CON" ]
dds_3dpi.1314_SOvsCON_SO <- dds_3dpi.SO[, dds_3dpi.SO$isolate == "1314" | dds_3dpi.SO$isolate == "CON" ]
dds_3dpi.F22_SOvsCON_SO <- dds_3dpi.SO[, dds_3dpi.SO$isolate == "F22" | dds_3dpi.SO$isolate == "CON" ]
dds_3dpi.1314_OAvsCON_OA <- dds_3dpi.OA[, dds_3dpi.OA$isolate == "1314" | dds_3dpi.OA$isolate == "CON" ]
dds_3dpi.F22_OAvsCON_OA <- dds_3dpi.OA[, dds_3dpi.OA$isolate == "F22" | dds_3dpi.OA$isolate == "CON" ]

dds_7dpi <- dds[, dds$timepoint %in% c("0", "7")]
dds_7dpi.SA <- dds_7dpi[, dds_7dpi$cultivar == "SA"]
dds_7dpi.SO <- dds_7dpi[, dds_7dpi$cultivar == "SO"]
dds_7dpi.OA <- dds_7dpi[, dds_7dpi$cultivar == "OA"]
dds_7dpi.1314_SAvsCON_SA <- dds_7dpi.SA[, dds_7dpi.SA$isolate == "1314" | dds_7dpi.SA$isolate == "CON" ]
dds_7dpi.F22_SAvsCON_SA <- dds_7dpi.SA[, dds_7dpi.SA$isolate == "F22" | dds_7dpi.SA$isolate == "CON" ]
dds_7dpi.1314_SOvsCON_SO <- dds_7dpi.SO[, dds_7dpi.SO$isolate == "1314" | dds_7dpi.SO$isolate == "CON" ]
dds_7dpi.F22_SOvsCON_SO <- dds_7dpi.SO[, dds_7dpi.SO$isolate == "F22" | dds_7dpi.SO$isolate == "CON" ]
dds_7dpi.1314_OAvsCON_OA <- dds_7dpi.OA[, dds_7dpi.OA$isolate == "1314" | dds_7dpi.OA$isolate == "CON" ]
dds_7dpi.F22_OAvsCON_OA <- dds_7dpi.OA[, dds_7dpi.OA$isolate == "F22" | dds_7dpi.OA$isolate == "CON" ]

dds_11dpi <- dds[, dds$timepoint %in% c("0", "11")]
dds_11dpi.SA <- dds_11dpi[, dds_11dpi$cultivar == "SA"]
dds_11dpi.SO <- dds_11dpi[, dds_11dpi$cultivar == "SO"]
dds_11dpi.OA <- dds_11dpi[, dds_11dpi$cultivar == "OA"]
dds_11dpi.1314_SAvsCON_SA <- dds_11dpi.SA[, dds_11dpi.SA$isolate == "1314" | dds_11dpi.SA$isolate == "CON" ]
dds_11dpi.F22_SAvsCON_SA <- dds_11dpi.SA[, dds_11dpi.SA$isolate == "F22" | dds_11dpi.SA$isolate == "CON" ]
dds_11dpi.1314_SOvsCON_SO <- dds_11dpi.SO[, dds_11dpi.SO$isolate == "1314" | dds_11dpi.SO$isolate == "CON" ]
dds_11dpi.F22_SOvsCON_SO <- dds_11dpi.SO[, dds_11dpi.SO$isolate == "F22" | dds_11dpi.SO$isolate == "CON" ]
dds_11dpi.1314_OAvsCON_OA <- dds_11dpi.OA[, dds_11dpi.OA$isolate == "1314" | dds_11dpi.OA$isolate == "CON" ]
dds_11dpi.F22_OAvsCON_OA <- dds_11dpi.OA[, dds_11dpi.OA$isolate == "F22" | dds_11dpi.OA$isolate == "CON" ]

## Fit generalised linear (negative binomial) model
levels(dds_1dpi.1314_SAvsCON_SA$cultivar_isolate)

dds_1dpi.1314_SAvsCON_SA$cultivar_isolate <- droplevels(dds_1dpi.1314_SAvsCON_SA$cultivar_isolate)
dds_1dpi.F22_SAvsCON_SA$cultivar_isolate <- droplevels(dds_1dpi.F22_SAvsCON_SA$cultivar_isolate)
dds_1dpi.1314_SOvsCON_SO$cultivar_isolate <- droplevels(dds_1dpi.1314_SOvsCON_SO$cultivar_isolate)
dds_1dpi.F22_SOvsCON_SO$cultivar_isolate <- droplevels(dds_1dpi.F22_SOvsCON_SO$cultivar_isolate)
dds_1dpi.1314_OAvsCON_OA$cultivar_isolate <- droplevels(dds_1dpi.1314_OAvsCON_OA$cultivar_isolate)
dds_1dpi.F22_OAvsCON_OA$cultivar_isolate <- droplevels(dds_1dpi.F22_OAvsCON_OA$cultivar_isolate)
dds_1dpi.1314_SAvsCON_SA$cultivar_isolate <- relevel(dds_1dpi.1314_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_1dpi.F22_SAvsCON_SA$cultivar_isolate <- relevel(dds_1dpi.F22_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_1dpi.1314_SOvsCON_SO$cultivar_isolate <- relevel(dds_1dpi.1314_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_1dpi.F22_SOvsCON_SO$cultivar_isolate <- relevel(dds_1dpi.F22_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_1dpi.1314_OAvsCON_OA$cultivar_isolate <- relevel(dds_1dpi.1314_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_1dpi.F22_OAvsCON_OA$cultivar_isolate <- relevel(dds_1dpi.F22_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_1dpi.1314_SAvsCON_SA <- DESeq(dds_1dpi.1314_SAvsCON_SA)
dds_1dpi.F22_SAvsCON_SA <- DESeq(dds_1dpi.F22_SAvsCON_SA)
dds_1dpi.1314_SOvsCON_SO <- DESeq(dds_1dpi.1314_SOvsCON_SO)
dds_1dpi.F22_SOvsCON_SO <- DESeq(dds_1dpi.F22_SOvsCON_SO)
dds_1dpi.1314_OAvsCON_OA <- DESeq(dds_1dpi.1314_OAvsCON_OA)
dds_1dpi.F22_OAvsCON_OA <- DESeq(dds_1dpi.F22_OAvsCON_OA)

dds_3dpi.1314_SAvsCON_SA$cultivar_isolate <- droplevels(dds_3dpi.1314_SAvsCON_SA$cultivar_isolate)
dds_3dpi.F22_SAvsCON_SA$cultivar_isolate <- droplevels(dds_3dpi.F22_SAvsCON_SA$cultivar_isolate)
dds_3dpi.1314_SOvsCON_SO$cultivar_isolate <- droplevels(dds_3dpi.1314_SOvsCON_SO$cultivar_isolate)
dds_3dpi.F22_SOvsCON_SO$cultivar_isolate <- droplevels(dds_3dpi.F22_SOvsCON_SO$cultivar_isolate)
dds_3dpi.1314_OAvsCON_OA$cultivar_isolate <- droplevels(dds_3dpi.1314_OAvsCON_OA$cultivar_isolate)
dds_3dpi.F22_OAvsCON_OA$cultivar_isolate <- droplevels(dds_3dpi.F22_OAvsCON_OA$cultivar_isolate)
dds_3dpi.1314_SAvsCON_SA$cultivar_isolate <- relevel(dds_3dpi.1314_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_3dpi.F22_SAvsCON_SA$cultivar_isolate <- relevel(dds_3dpi.F22_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_3dpi.1314_SOvsCON_SO$cultivar_isolate <- relevel(dds_3dpi.1314_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_3dpi.F22_SOvsCON_SO$cultivar_isolate <- relevel(dds_3dpi.F22_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_3dpi.1314_OAvsCON_OA$cultivar_isolate <- relevel(dds_3dpi.1314_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_3dpi.F22_OAvsCON_OA$cultivar_isolate <- relevel(dds_3dpi.F22_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_3dpi.1314_SAvsCON_SA <- DESeq(dds_3dpi.1314_SAvsCON_SA)
dds_3dpi.F22_SAvsCON_SA <- DESeq(dds_3dpi.F22_SAvsCON_SA)
dds_3dpi.1314_SOvsCON_SO <- DESeq(dds_3dpi.1314_SOvsCON_SO)
dds_3dpi.F22_SOvsCON_SO <- DESeq(dds_3dpi.F22_SOvsCON_SO)
dds_3dpi.1314_OAvsCON_OA <- DESeq(dds_3dpi.1314_OAvsCON_OA)
dds_3dpi.F22_OAvsCON_OA <- DESeq(dds_3dpi.F22_OAvsCON_OA)

dds_7dpi.1314_SAvsCON_SA$cultivar_isolate <- droplevels(dds_7dpi.1314_SAvsCON_SA$cultivar_isolate)
dds_7dpi.F22_SAvsCON_SA$cultivar_isolate <- droplevels(dds_7dpi.F22_SAvsCON_SA$cultivar_isolate)
dds_7dpi.1314_SOvsCON_SO$cultivar_isolate <- droplevels(dds_7dpi.1314_SOvsCON_SO$cultivar_isolate)
dds_7dpi.F22_SOvsCON_SO$cultivar_isolate <- droplevels(dds_7dpi.F22_SOvsCON_SO$cultivar_isolate)
dds_7dpi.1314_OAvsCON_OA$cultivar_isolate <- droplevels(dds_7dpi.1314_OAvsCON_OA$cultivar_isolate)
dds_7dpi.F22_OAvsCON_OA$cultivar_isolate <- droplevels(dds_7dpi.F22_OAvsCON_OA$cultivar_isolate)
dds_7dpi.1314_SAvsCON_SA$cultivar_isolate <- relevel(dds_7dpi.1314_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_7dpi.F22_SAvsCON_SA$cultivar_isolate <- relevel(dds_7dpi.F22_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_7dpi.1314_SOvsCON_SO$cultivar_isolate <- relevel(dds_7dpi.1314_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_7dpi.F22_SOvsCON_SO$cultivar_isolate <- relevel(dds_7dpi.F22_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_7dpi.1314_OAvsCON_OA$cultivar_isolate <- relevel(dds_7dpi.1314_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_7dpi.F22_OAvsCON_OA$cultivar_isolate <- relevel(dds_7dpi.F22_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_7dpi.1314_SAvsCON_SA <- DESeq(dds_7dpi.1314_SAvsCON_SA)
dds_7dpi.F22_SAvsCON_SA <- DESeq(dds_7dpi.F22_SAvsCON_SA)
dds_7dpi.1314_SOvsCON_SO <- DESeq(dds_7dpi.1314_SOvsCON_SO)
dds_7dpi.F22_SOvsCON_SO <- DESeq(dds_7dpi.F22_SOvsCON_SO)
dds_7dpi.1314_OAvsCON_OA <- DESeq(dds_7dpi.1314_OAvsCON_OA)
dds_7dpi.F22_OAvsCON_OA <- DESeq(dds_7dpi.F22_OAvsCON_OA)

dds_11dpi.1314_SAvsCON_SA$cultivar_isolate <- droplevels(dds_11dpi.1314_SAvsCON_SA$cultivar_isolate)
dds_11dpi.F22_SAvsCON_SA$cultivar_isolate <- droplevels(dds_11dpi.F22_SAvsCON_SA$cultivar_isolate)
dds_11dpi.1314_SOvsCON_SO$cultivar_isolate <- droplevels(dds_11dpi.1314_SOvsCON_SO$cultivar_isolate)
dds_11dpi.F22_SOvsCON_SO$cultivar_isolate <- droplevels(dds_11dpi.F22_SOvsCON_SO$cultivar_isolate)
dds_11dpi.1314_OAvsCON_OA$cultivar_isolate <- droplevels(dds_11dpi.1314_OAvsCON_OA$cultivar_isolate)
dds_11dpi.F22_OAvsCON_OA$cultivar_isolate <- droplevels(dds_11dpi.F22_OAvsCON_OA$cultivar_isolate)
dds_11dpi.1314_SAvsCON_SA$cultivar_isolate <- relevel(dds_11dpi.1314_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_11dpi.F22_SAvsCON_SA$cultivar_isolate <- relevel(dds_11dpi.F22_SAvsCON_SA$cultivar_isolate, "CON_SA")
dds_11dpi.1314_SOvsCON_SO$cultivar_isolate <- relevel(dds_11dpi.1314_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_11dpi.F22_SOvsCON_SO$cultivar_isolate <- relevel(dds_11dpi.F22_SOvsCON_SO$cultivar_isolate, "CON_SO")
dds_11dpi.1314_OAvsCON_OA$cultivar_isolate <- relevel(dds_11dpi.1314_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_11dpi.F22_OAvsCON_OA$cultivar_isolate <- relevel(dds_11dpi.F22_OAvsCON_OA$cultivar_isolate, "CON_OA")
dds_11dpi.1314_SAvsCON_SA <- DESeq(dds_11dpi.1314_SAvsCON_SA)
dds_11dpi.F22_SAvsCON_SA <- DESeq(dds_11dpi.F22_SAvsCON_SA)
dds_11dpi.1314_SOvsCON_SO <- DESeq(dds_11dpi.1314_SOvsCON_SO)
dds_11dpi.F22_SOvsCON_SO <- DESeq(dds_11dpi.F22_SOvsCON_SO)
dds_11dpi.1314_OAvsCON_OA <- DESeq(dds_11dpi.1314_OAvsCON_OA)
dds_11dpi.F22_OAvsCON_OA <- DESeq(dds_11dpi.F22_OAvsCON_OA)

#total numbr raw counts per sample
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON.txt", append=TRUE, split=TRUE)
colSums(counts(dds_1dpi.1314_SAvsCON_SA))
colSums(counts(dds_1dpi.F22_SAvsCON_SA))
colSums(counts(dds_1dpi.1314_SOvsCON_SO))
colSums(counts(dds_1dpi.F22_SOvsCON_SO))
colSums(counts(dds_1dpi.1314_OAvsCON_OA))
colSums(counts(dds_1dpi.F22_OAvsCON_OA))

colSums(counts(dds_3dpi.1314_SAvsCON_SA))
colSums(counts(dds_3dpi.F22_SAvsCON_SA))
colSums(counts(dds_3dpi.1314_SOvsCON_SO))
colSums(counts(dds_3dpi.F22_SOvsCON_SO))
colSums(counts(dds_3dpi.1314_OAvsCON_OA))
colSums(counts(dds_3dpi.F22_OAvsCON_OA))

colSums(counts(dds_7dpi.1314_SAvsCON_SA))
colSums(counts(dds_7dpi.F22_SAvsCON_SA))
colSums(counts(dds_7dpi.1314_SOvsCON_SO))
colSums(counts(dds_7dpi.F22_SOvsCON_SO))
colSums(counts(dds_7dpi.1314_OAvsCON_OA))
colSums(counts(dds_7dpi.F22_OAvsCON_OA))

colSums(counts(dds_11dpi.1314_SAvsCON_SA))
colSums(counts(dds_11dpi.F22_SAvsCON_SA))
colSums(counts(dds_11dpi.1314_SOvsCON_SO))
colSums(counts(dds_11dpi.F22_SOvsCON_SO))
colSums(counts(dds_11dpi.1314_OAvsCON_OA))
colSums(counts(dds_11dpi.F22_OAvsCON_OA))

# total number of normalised counts per sample = how do numbers correlate
colSums(counts(dds_1dpi.1314_SAvsCON_SA, normalized=T))
colSums(counts(dds_1dpi.F22_SAvsCON_SA, normalized=T))
colSums(counts(dds_1dpi.1314_SOvsCON_SO, normalized=T))
colSums(counts(dds_1dpi.F22_SOvsCON_SO, normalized=T))
colSums(counts(dds_1dpi.1314_OAvsCON_OA, normalized=T))
colSums(counts(dds_1dpi.F22_OAvsCON_OA, normalized=T))

colSums(counts(dds_3dpi.1314_SAvsCON_SA, normalized=T))
colSums(counts(dds_3dpi.F22_SAvsCON_SA, normalized=T))
colSums(counts(dds_3dpi.1314_SOvsCON_SO, normalized=T))
colSums(counts(dds_3dpi.F22_SOvsCON_SO, normalized=T))
colSums(counts(dds_3dpi.1314_OAvsCON_OA, normalized=T))
colSums(counts(dds_3dpi.F22_OAvsCON_OA, normalized=T))

colSums(counts(dds_7dpi.1314_SAvsCON_SA, normalized=T))
colSums(counts(dds_7dpi.F22_SAvsCON_SA, normalized=T))
colSums(counts(dds_7dpi.1314_SOvsCON_SO, normalized=T))
colSums(counts(dds_7dpi.F22_SOvsCON_SO, normalized=T))
colSums(counts(dds_7dpi.1314_OAvsCON_OA, normalized=T))
colSums(counts(dds_7dpi.F22_OAvsCON_OA, normalized=T))

colSums(counts(dds_11dpi.1314_SAvsCON_SA, normalized=T))
colSums(counts(dds_11dpi.F22_SAvsCON_SA, normalized=T))
colSums(counts(dds_11dpi.1314_SOvsCON_SO, normalized=T))
colSums(counts(dds_11dpi.F22_SOvsCON_SO, normalized=T))
colSums(counts(dds_11dpi.1314_OAvsCON_OA, normalized=T))
colSums(counts(dds_11dpi.F22_OAvsCON_OA, normalized=T))
sink()
## gene-wise dispersion estimates and assess model fit
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_DispEst.pdf", height=11, width=8.5)
DispEst.1dpi.1314_SAvsCON_SA <- plotDispEsts(dds_1dpi.1314_SAvsCON_SA, main = "DispEst 1dpi 1314_SAvsCON_SA")
DispEst.1dpi.F22_SAvsCON_SA <- plotDispEsts(dds_1dpi.F22_SAvsCON_SA, main = "DispEst 1dpi F22_SAvsCON_SA")
DispEst.1dpi.1314_SOvsCON_SO <- plotDispEsts(dds_1dpi.1314_SOvsCON_SO, main = "DispEst 1dpi 1314_SOvsCON_SO")
DispEst.1dpi.F22_SOvsCON_SO <- plotDispEsts(dds_1dpi.F22_SOvsCON_SO, main = "DispEst 1dpi F22_SOvsCON_SO")
DispEst.1dpi.1314_OAvsCON_OA <- plotDispEsts(dds_1dpi.1314_OAvsCON_OA, main = "DispEst 1dpi 1314_OAvsCON_OA")
DispEst.1dpi.F22_OAvsCON_OA <- plotDispEsts(dds_1dpi.F22_OAvsCON_OA, main = "DispEst 1dpi F22_OAvsCON_OA")

DispEst.3dpi.1314_SAvsCON_SA <- plotDispEsts(dds_3dpi.1314_SAvsCON_SA, main = "DispEst 3dpi 1314_SAvsCON_SA")
DispEst.3dpi.F22_SAvsCON_SA <- plotDispEsts(dds_3dpi.F22_SAvsCON_SA, main = "DispEst 3dpi F22_SAvsCON_SA")
DispEst.3dpi.1314_SOvsCON_SO <- plotDispEsts(dds_3dpi.1314_SOvsCON_SO, main = "DispEst 3dpi 1314_SOvsCON_SO")
DispEst.3dpi.F22_SOvsCON_SO <- plotDispEsts(dds_3dpi.F22_SOvsCON_SO, main = "DispEst 3dpi F22_SOvsCON_SO")
DispEst.3dpi.1314_OAvsCON_OA <- plotDispEsts(dds_3dpi.1314_OAvsCON_OA, main = "DispEst 3dpi 1314_OAvsCON_OA")
DispEst.3dpi.F22_OAvsCON_OA <- plotDispEsts(dds_3dpi.F22_OAvsCON_OA, main = "DispEst 3dpi F22_OAvsCON_OA")

DispEst.7dpi.1314_SAvsCON_SA <- plotDispEsts(dds_7dpi.1314_SAvsCON_SA, main = "DispEst 7dpi 1314_SAvsCON_SA")
DispEst.7dpi.F22_SAvsCON_SA <- plotDispEsts(dds_7dpi.F22_SAvsCON_SA, main = "DispEst 7dpi F22_SAvsCON_SA")
DispEst.7dpi.1314_SOvsCON_SO <- plotDispEsts(dds_7dpi.1314_SOvsCON_SO, main = "DispEst 7dpi 1314_SOvsCON_SO")
DispEst.7dpi.F22_SOvsCON_SO <- plotDispEsts(dds_7dpi.F22_SOvsCON_SO, main = "DispEst 7dpi F22_SOvsCON_SO")
DispEst.7dpi.1314_OAvsCON_OA <- plotDispEsts(dds_7dpi.1314_OAvsCON_OA, main = "DispEst 7dpi 1314_OAvsCON_OA")
DispEst.7dpi.F22_OAvsCON_OA <- plotDispEsts(dds_7dpi.F22_OAvsCON_OA, main = "DispEst 7dpi F22_OAvsCON_OA")

DispEst.11dpi.1314_SAvsCON_SA <- plotDispEsts(dds_11dpi.1314_SAvsCON_SA, main = "DispEst 11dpi 1314_SAvsCON_SA")
DispEst.11dpi.F22_SAvsCON_SA <- plotDispEsts(dds_11dpi.F22_SAvsCON_SA, main = "DispEst 11dpi F22_SAvsCON_SA")
DispEst.11dpi.1314_SOvsCON_SO <- plotDispEsts(dds_11dpi.1314_SOvsCON_SO, main = "DispEst 11dpi 1314_SOvsCON_SO")
DispEst.11dpi.F22_SOvsCON_SO <- plotDispEsts(dds_11dpi.F22_SOvsCON_SO, main = "DispEst 11dpi F22_SOvsCON_SO")
DispEst.11dpi.1314_OAvsCON_OA <- plotDispEsts(dds_11dpi.1314_OAvsCON_OA, main = "DispEst 11dpi 1314_OAvsCON_OA")
DispEst.11dpi.F22_OAvsCON_OA <- plotDispEsts(dds_11dpi.F22_OAvsCON_OA, main = "DispEst 11dpi F22_OAvsCON_OA")
dev.off()
#### HYPOTHESIS TESTING - WALD TEST
# null hypothesis = no differential expression across the two sample groups (LFC == 0)
# For each dpi 1,3,7,11dpi:
# - pairwise comparisons:
# (1) CON_SA vs 1314_SA
# (2) CON_SO vs 1314_SO
# (3) CON_OA vs 1314_OA
# (4) CON_SA vs F22_SA
# (5) CON_SO vs F22_SO
# (6) CON_OA vs F22_OA

### define contrasts, 
contrast_1314_SAvsCON_SA <- c("cultivar_isolate", "1314_SA", "CON_SA")
contrast_F22_SAvsCON_SA <- c("cultivar_isolate", "F22_SA", "CON_SA")
contrast_1314_SOvsCON_SO <- c("cultivar_isolate", "1314_SO", "CON_SO")
contrast_F22_SOvsCON_SO <- c("cultivar_isolate", "F22_SO", "CON_SO")
contrast_1314_OAvsCON_OA <- c("cultivar_isolate", "1314_OA", "CON_OA")
contrast_F22_OAvsCON_OA <- c("cultivar_isolate", "F22_OA", "CON_OA")


### extract results table
restable.1dpi_1314_SAvsCON_SA_unshrunken <- results(dds_1dpi.1314_SAvsCON_SA, contrasts=contrast_1314_SAvsCON_SA, alpha = 0.05)
restable.1dpi_F22_SAvsCON_SA_unshrunken <- results(dds_1dpi.F22_SAvsCON_SA, contrasts=contrast_F22_SAvsCON_SA, alpha = 0.05)
restable.1dpi_1314_SOvsCON_SO_unshrunken <- results(dds_1dpi.1314_SOvsCON_SO, contrasts=contrast_1314_SOvsCON_SO, alpha = 0.05)
restable.1dpi_F22_SOvsCON_SO_unshrunken <- results(dds_1dpi.F22_SOvsCON_SO, contrasts=contrast_F22_SOvsCON_SO, alpha = 0.05)
restable.1dpi_1314_OAvsCON_OA_unshrunken <- results(dds_1dpi.1314_OAvsCON_OA, contrasts=contrast_1314_OAvsCON_OA, alpha = 0.05)
restable.1dpi_F22_OAvsCON_OA_unshrunken <- results(dds_1dpi.F22_OAvsCON_OA, contrasts=contrast_F22_OAvsCON_OA, alpha = 0.05)

restable.3dpi_1314_SAvsCON_SA_unshrunken <- results(dds_3dpi.1314_SAvsCON_SA, contrasts=contrast_1314_SAvsCON_SA, alpha = 0.05)
restable.3dpi_F22_SAvsCON_SA_unshrunken <- results(dds_3dpi.F22_SAvsCON_SA, contrasts=contrast_F22_SAvsCON_SA, alpha = 0.05)
restable.3dpi_1314_SOvsCON_SO_unshrunken <- results(dds_3dpi.1314_SOvsCON_SO, contrasts=contrast_1314_SOvsCON_SO, alpha = 0.05)
restable.3dpi_F22_SOvsCON_SO_unshrunken <- results(dds_3dpi.F22_SOvsCON_SO, contrasts=contrast_F22_SOvsCON_SO, alpha = 0.05)
restable.3dpi_1314_OAvsCON_OA_unshrunken <- results(dds_3dpi.1314_OAvsCON_OA, contrasts=contrast_1314_OAvsCON_OA, alpha = 0.05)
restable.3dpi_F22_OAvsCON_OA_unshrunken <- results(dds_3dpi.F22_OAvsCON_OA, contrasts=contrast_F22_OAvsCON_OA, alpha = 0.05)

restable.7dpi_1314_SAvsCON_SA_unshrunken <- results(dds_7dpi.1314_SAvsCON_SA, contrasts=contrast_1314_SAvsCON_SA, alpha = 0.05)
restable.7dpi_F22_SAvsCON_SA_unshrunken <- results(dds_7dpi.F22_SAvsCON_SA, contrasts=contrast_F22_SAvsCON_SA, alpha = 0.05)
restable.7dpi_1314_SOvsCON_SO_unshrunken <- results(dds_7dpi.1314_SOvsCON_SO, contrasts=contrast_1314_SOvsCON_SO, alpha = 0.05)
restable.7dpi_F22_SOvsCON_SO_unshrunken <- results(dds_7dpi.F22_SOvsCON_SO, contrasts=contrast_F22_SOvsCON_SO, alpha = 0.05)
restable.7dpi_1314_OAvsCON_OA_unshrunken <- results(dds_7dpi.1314_OAvsCON_OA, contrasts=contrast_1314_OAvsCON_OA, alpha = 0.05)
restable.7dpi_F22_OAvsCON_OA_unshrunken <- results(dds_7dpi.F22_OAvsCON_OA, contrasts=contrast_F22_OAvsCON_OA, alpha = 0.05)

restable.11dpi_1314_SAvsCON_SA_unshrunken <- results(dds_11dpi.1314_SAvsCON_SA, contrasts=contrast_1314_SAvsCON_SA, alpha = 0.05)
restable.11dpi_F22_SAvsCON_SA_unshrunken <- results(dds_11dpi.F22_SAvsCON_SA, contrasts=contrast_F22_SAvsCON_SA, alpha = 0.05)
restable.11dpi_1314_SOvsCON_SO_unshrunken <- results(dds_11dpi.1314_SOvsCON_SO, contrasts=contrast_1314_SOvsCON_SO, alpha = 0.05)
restable.11dpi_F22_SOvsCON_SO_unshrunken <- results(dds_11dpi.F22_SOvsCON_SO, contrasts=contrast_F22_SOvsCON_SO, alpha = 0.05)
restable.11dpi_1314_OAvsCON_OA_unshrunken <- results(dds_11dpi.1314_OAvsCON_OA, contrasts=contrast_1314_OAvsCON_OA, alpha = 0.05)
restable.11dpi_F22_OAvsCON_OA_unshrunken <- results(dds_11dpi.F22_OAvsCON_OA, contrasts=contrast_F22_OAvsCON_OA, alpha = 0.05)

# and shrink the log2 fold changes
restable.1dpi_1314_SAvsCON_SA <- lfcShrink(dds_1dpi.1314_SAvsCON_SA, contrast=contrast_1314_SAvsCON_SA, res=restable.1dpi_1314_SAvsCON_SA_unshrunken)
restable.1dpi_F22_SAvsCON_SA <- lfcShrink(dds_1dpi.F22_SAvsCON_SA, contrast=contrast_F22_SAvsCON_SA, res=restable.1dpi_F22_SAvsCON_SA_unshrunken)
restable.1dpi_1314_SOvsCON_SO <- lfcShrink(dds_1dpi.1314_SOvsCON_SO, contrast=contrast_1314_SOvsCON_SO, res=restable.1dpi_1314_SOvsCON_SO_unshrunken)
restable.1dpi_F22_SOvsCON_SO <- lfcShrink(dds_1dpi.F22_SOvsCON_SO, contrast=contrast_F22_SOvsCON_SO, res=restable.1dpi_F22_SOvsCON_SO_unshrunken)
restable.1dpi_1314_OAvsCON_OA <- lfcShrink(dds_1dpi.1314_OAvsCON_OA, contrast=contrast_1314_OAvsCON_OA, res=restable.1dpi_1314_OAvsCON_OA_unshrunken)
restable.1dpi_F22_OAvsCON_OA <- lfcShrink(dds_1dpi.F22_OAvsCON_OA, contrast=contrast_F22_OAvsCON_OA, res=restable.1dpi_F22_OAvsCON_OA_unshrunken)

restable.3dpi_1314_SAvsCON_SA <- lfcShrink(dds_3dpi.1314_SAvsCON_SA, contrast=contrast_1314_SAvsCON_SA, res=restable.3dpi_1314_SAvsCON_SA_unshrunken)
restable.3dpi_F22_SAvsCON_SA <- lfcShrink(dds_3dpi.F22_SAvsCON_SA, contrast=contrast_F22_SAvsCON_SA, res=restable.3dpi_F22_SAvsCON_SA_unshrunken)
restable.3dpi_1314_SOvsCON_SO <- lfcShrink(dds_3dpi.1314_SOvsCON_SO, contrast=contrast_1314_SOvsCON_SO, res=restable.3dpi_1314_SOvsCON_SO_unshrunken)
restable.3dpi_F22_SOvsCON_SO <- lfcShrink(dds_3dpi.F22_SOvsCON_SO, contrast=contrast_F22_SOvsCON_SO, res=restable.3dpi_F22_SOvsCON_SO_unshrunken)
restable.3dpi_1314_OAvsCON_OA <- lfcShrink(dds_3dpi.1314_OAvsCON_OA, contrast=contrast_1314_OAvsCON_OA, res=restable.3dpi_1314_OAvsCON_OA_unshrunken)
restable.3dpi_F22_OAvsCON_OA <- lfcShrink(dds_3dpi.F22_OAvsCON_OA, contrast=contrast_F22_OAvsCON_OA, res=restable.3dpi_F22_OAvsCON_OA_unshrunken)

restable.7dpi_1314_SAvsCON_SA <- lfcShrink(dds_7dpi.1314_SAvsCON_SA, contrast=contrast_1314_SAvsCON_SA, res=restable.7dpi_1314_SAvsCON_SA_unshrunken)
restable.7dpi_F22_SAvsCON_SA <- lfcShrink(dds_7dpi.F22_SAvsCON_SA, contrast=contrast_F22_SAvsCON_SA, res=restable.7dpi_F22_SAvsCON_SA_unshrunken)
restable.7dpi_1314_SOvsCON_SO <- lfcShrink(dds_7dpi.1314_SOvsCON_SO, contrast=contrast_1314_SOvsCON_SO, res=restable.7dpi_1314_SOvsCON_SO_unshrunken)
restable.7dpi_F22_SOvsCON_SO <- lfcShrink(dds_7dpi.F22_SOvsCON_SO, contrast=contrast_F22_SOvsCON_SO, res=restable.7dpi_F22_SOvsCON_SO_unshrunken)
restable.7dpi_1314_OAvsCON_OA <- lfcShrink(dds_7dpi.1314_OAvsCON_OA, contrast=contrast_1314_OAvsCON_OA, res=restable.7dpi_1314_OAvsCON_OA_unshrunken)
restable.7dpi_F22_OAvsCON_OA <- lfcShrink(dds_7dpi.F22_OAvsCON_OA, contrast=contrast_F22_OAvsCON_OA, res=restable.7dpi_F22_OAvsCON_OA_unshrunken)

restable.11dpi_1314_SAvsCON_SA <- lfcShrink(dds_11dpi.1314_SAvsCON_SA, contrast=contrast_1314_SAvsCON_SA, res=restable.11dpi_1314_SAvsCON_SA_unshrunken)
restable.11dpi_F22_SAvsCON_SA <- lfcShrink(dds_11dpi.F22_SAvsCON_SA, contrast=contrast_F22_SAvsCON_SA, res=restable.11dpi_F22_SAvsCON_SA_unshrunken)
restable.11dpi_1314_SOvsCON_SO <- lfcShrink(dds_11dpi.1314_SOvsCON_SO, contrast=contrast_1314_SOvsCON_SO, res=restable.11dpi_1314_SOvsCON_SO_unshrunken)
restable.11dpi_F22_SOvsCON_SO <- lfcShrink(dds_11dpi.F22_SOvsCON_SO, contrast=contrast_F22_SOvsCON_SO, res=restable.11dpi_F22_SOvsCON_SO_unshrunken)
restable.11dpi_1314_OAvsCON_OA <- lfcShrink(dds_11dpi.1314_OAvsCON_OA, contrast=contrast_1314_OAvsCON_OA, res=restable.11dpi_1314_OAvsCON_OA_unshrunken)
restable.11dpi_F22_OAvsCON_OA <- lfcShrink(dds_11dpi.F22_OAvsCON_OA, contrast=contrast_F22_OAvsCON_OA, res=restable.11dpi_F22_OAvsCON_OA_unshrunken)

### results as MA plots - see sigDEGs across range levels
#par(mfrow=c(2,1))
#plotMA_res_table_1314_SAvsCON_unshrunken_1dpi <- plotMA(res_table_SAxCONv1314_unshrunken, ylim=c(-2,2))
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_MAplots.pdf", height=11, width=8.5)
MAplot.restable_1dpi_1314_SAvsCON_SA <- plotMA(restable.1dpi_1314_SAvsCON_SA, ylim=c(-10,10), main="MAplot 1dpi 1314_SA vs CON_SA")
MAplot.restable_1dpi_1314_SOvsCON_SO <- plotMA(restable.1dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 1dpi 1314_SO vs CON_SO")
MAplot.restable_1dpi_1314_OAvsCON_OA <- plotMA(restable.1dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 1dpi 1314_SO vs CON_SO")
MAplot.restable_1dpi_F22_SAvsCON_SA <- plotMA(restable.1dpi_F22_SAvsCON_SA, ylim=c(-10,10), main="MAplot 1dpi F22_SA vs F22_SA")
MAplot.restable_1dpi_F22_SOvsCON_SO <- plotMA(restable.1dpi_F22_SOvsCON_SO, ylim=c(-10,10), main="MAplot 1dpi F22_SO vs F22_SO")
MAplot.restable_1dpi_F22_OAvsCON_OA <- plotMA(restable.1dpi_F22_OAvsCON_OA, ylim=c(-10,10), main="MAplot 1dpi F22_OA vs F22_OA")

MAplot.restable_3dpi_1314_SAvsCON_SA <- plotMA(restable.3dpi_1314_SAvsCON_SA, ylim=c(-10,10), main="MAplot 3dpi 1314_SA vs CON_SA")
MAplot.restable_3dpi_1314_SOvsCON_SO <- plotMA(restable.3dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 3dpi 1314_SO vs CON_SO")
MAplot.restable_3dpi_1314_OAvsCON_OA <- plotMA(restable.3dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 3dpi 1314_SO vs CON_SO")
MAplot.restable_3dpi_F22_SAvsCON_SA <- plotMA(restable.3dpi_F22_SAvsCON_SA, ylim=c(-10,10), main="MAplot 3dpi F22_SA vs F22_SA")
MAplot.restable_3dpi_F22_SOvsCON_SO <- plotMA(restable.3dpi_F22_SOvsCON_SO, ylim=c(-10,10), main="MAplot 3dpi F22_SO vs F22_SO")
MAplot.restable_3dpi_F22_OAvsCON_OA <- plotMA(restable.3dpi_F22_OAvsCON_OA, ylim=c(-10,10), main="MAplot 3dpi F22_OA vs F22_OA")

MAplot.restable_7dpi_1314_SAvsCON_SA <- plotMA(restable.7dpi_1314_SAvsCON_SA, ylim=c(-10,10), main="MAplot 7dpi 1314_SA vs CON_SA")
MAplot.restable_7dpi_1314_SOvsCON_SO <- plotMA(restable.7dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 7dpi 1314_SO vs CON_SO")
MAplot.restable_7dpi_1314_OAvsCON_OA <- plotMA(restable.7dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 7dpi 1314_SO vs CON_SO")
MAplot.restable_7dpi_F22_SAvsCON_SA <- plotMA(restable.7dpi_F22_SAvsCON_SA, ylim=c(-10,10), main="MAplot 7dpi F22_SA vs F22_SA")
MAplot.restable_7dpi_F22_SOvsCON_SO <- plotMA(restable.7dpi_F22_SOvsCON_SO, ylim=c(-10,10), main="MAplot 7dpi F22_SO vs F22_SO")
MAplot.restable_7dpi_F22_OAvsCON_OA <- plotMA(restable.7dpi_F22_OAvsCON_OA, ylim=c(-10,10), main="MAplot 7dpi F22_OA vs F22_OA")

MAplot.restable_11dpi_1314_SAvsCON_SA <- plotMA(restable.11dpi_1314_SAvsCON_SA, ylim=c(-10,10), main="MAplot 11dpi 1314_SA vs CON_SA")
MAplot.restable_11dpi_1314_SOvsCON_SO <- plotMA(restable.11dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 11dpi 1314_SO vs CON_SO")
MAplot.restable_11dpi_1314_OAvsCON_OA <- plotMA(restable.11dpi_1314_SOvsCON_SO, ylim=c(-10,10), main="MAplot 11dpi 1314_SO vs CON_SO")
MAplot.restable_11dpi_F22_SAvsCON_SA <- plotMA(restable.11dpi_F22_SAvsCON_SA, ylim=c(-10,10), main="MAplot 11dpi F22_SA vs F22_SA")
MAplot.restable_11dpi_F22_SOvsCON_SO <- plotMA(restable.11dpi_F22_SOvsCON_SO, ylim=c(-10,10), main="MAplot 11dpi F22_SO vs F22_SO")
MAplot.restable_11dpi_F22_OAvsCON_OA <- plotMA(restable.11dpi_F22_OAvsCON_OA, ylim=c(-10,10), main="MAplot 11dpi F22_OA vs F22_OA")
dev.off()

## EXPLORE RESULTS
#multiple testing problem: more genes tested, more false positive rate
# - DESeq2 removes unlikely genes with low count numbers and outlier samples (gene-levelQC)
# - correct for multiple testing to reduce false positives using Benjamini-Hochberg method
# ALWAYS USE p-adj method, uses FDR<0.05

#what package used
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_results.txt", append=TRUE, split=TRUE)
class(restable.1dpi_1314_SAvsCON_SA)
class(restable.1dpi_F22_SAvsCON_SA)
class(restable.1dpi_1314_SOvsCON_SO)
class(restable.1dpi_F22_SOvsCON_SO)
class(restable.1dpi_1314_OAvsCON_OA)
class(restable.1dpi_F22_OAvsCON_OA)

class(restable.3dpi_1314_SAvsCON_SA)
class(restable.3dpi_F22_SAvsCON_SA)
class(restable.3dpi_1314_SOvsCON_SO)
class(restable.3dpi_F22_SOvsCON_SO)
class(restable.3dpi_1314_OAvsCON_OA)
class(restable.3dpi_F22_OAvsCON_OA)

class(restable.7dpi_1314_SAvsCON_SA)
class(restable.7dpi_F22_SAvsCON_SA)
class(restable.7dpi_1314_SOvsCON_SO)
class(restable.7dpi_F22_SOvsCON_SO)
class(restable.7dpi_1314_OAvsCON_OA)
class(restable.7dpi_F22_OAvsCON_OA)

class(restable.11dpi_1314_SAvsCON_SA)
class(restable.11dpi_F22_SAvsCON_SA)
class(restable.11dpi_1314_SOvsCON_SO)
class(restable.11dpi_F22_SOvsCON_SO)
class(restable.11dpi_1314_OAvsCON_OA)
class(restable.11dpi_F22_OAvsCON_OA)

#check comparison (thus LFC) as expected i.e. CON~reference
mcols(restable.1dpi_1314_SAvsCON_SA)
mcols(restable.1dpi_F22_SAvsCON_SA)
mcols(restable.1dpi_1314_SOvsCON_SO)
mcols(restable.1dpi_F22_SOvsCON_SO)
mcols(restable.1dpi_1314_OAvsCON_OA)
mcols(restable.1dpi_F22_OAvsCON_OA)

mcols(restable.3dpi_1314_SAvsCON_SA)
mcols(restable.3dpi_F22_SAvsCON_SA)
mcols(restable.3dpi_1314_SOvsCON_SO)
mcols(restable.3dpi_F22_SOvsCON_SO)
mcols(restable.3dpi_1314_OAvsCON_OA)
mcols(restable.3dpi_F22_OAvsCON_OA)

mcols(restable.7dpi_1314_SAvsCON_SA)
mcols(restable.7dpi_F22_SAvsCON_SA)
mcols(restable.7dpi_1314_SOvsCON_SO)
mcols(restable.7dpi_F22_SOvsCON_SO)
mcols(restable.7dpi_1314_OAvsCON_OA)
mcols(restable.7dpi_F22_OAvsCON_OA)

mcols(restable.11dpi_1314_SAvsCON_SA)
mcols(restable.11dpi_F22_SAvsCON_SA)
mcols(restable.11dpi_1314_SOvsCON_SO)
mcols(restable.11dpi_F22_SOvsCON_SO)
mcols(restable.11dpi_1314_OAvsCON_OA)
mcols(restable.11dpi_F22_OAvsCON_OA)

# check column names
colnames(restable.1dpi_1314_SAvsCON_SA)
colnames(restable.1dpi_F22_SAvsCON_SA)
colnames(restable.1dpi_1314_SOvsCON_SO)
colnames(restable.1dpi_F22_SOvsCON_SO)
colnames(restable.1dpi_1314_OAvsCON_OA)
colnames(restable.1dpi_F22_OAvsCON_OA)

colnames(restable.3dpi_1314_SAvsCON_SA)
colnames(restable.3dpi_F22_SAvsCON_SA)
colnames(restable.3dpi_1314_SOvsCON_SO)
colnames(restable.3dpi_F22_SOvsCON_SO)
colnames(restable.3dpi_1314_OAvsCON_OA)
colnames(restable.3dpi_F22_OAvsCON_OA)

colnames(restable.7dpi_1314_SAvsCON_SA)
colnames(restable.7dpi_F22_SAvsCON_SA)
colnames(restable.7dpi_1314_SOvsCON_SO)
colnames(restable.7dpi_F22_SOvsCON_SO)
colnames(restable.7dpi_1314_OAvsCON_OA)
colnames(restable.7dpi_F22_OAvsCON_OA)

colnames(restable.11dpi_1314_SAvsCON_SA)
colnames(restable.11dpi_F22_SAvsCON_SA)
colnames(restable.11dpi_1314_SOvsCON_SO)
colnames(restable.11dpi_F22_SOvsCON_SO)
colnames(restable.11dpi_1314_OAvsCON_OA)
colnames(restable.11dpi_F22_OAvsCON_OA)
sink()
# View dataframe
View(data.frame(restable.1dpi_1314_SAvsCON_SA))
View(data.frame(restable.1dpi_F22_SAvsCON_SA))
View(data.frame(restable.1dpi_1314_SOvsCON_SO))
View(data.frame(restable.1dpi_F22_SOvsCON_SO))
View(data.frame(restable.1dpi_1314_OAvsCON_OA))
View(data.frame(restable.1dpi_F22_OAvsCON_OA))

View(data.frame(restable.3dpi_1314_SAvsCON_SA))
View(data.frame(restable.3dpi_F22_SAvsCON_SA))
View(data.frame(restable.3dpi_1314_SOvsCON_SO))
View(data.frame(restable.3dpi_F22_SOvsCON_SO))
View(data.frame(restable.3dpi_1314_OAvsCON_OA))
View(data.frame(restable.3dpi_F22_OAvsCON_OA))

View(data.frame(restable.7dpi_1314_SAvsCON_SA))
View(data.frame(restable.7dpi_F22_SAvsCON_SA))
View(data.frame(restable.7dpi_1314_SOvsCON_SO))
View(data.frame(restable.7dpi_F22_SOvsCON_SO))
View(data.frame(restable.7dpi_1314_OAvsCON_OA))
View(data.frame(restable.7dpi_F22_OAvsCON_OA))

View(data.frame(restable.11dpi_1314_SAvsCON_SA))
View(data.frame(restable.11dpi_F22_SAvsCON_SA))
View(data.frame(restable.11dpi_1314_SOvsCON_SO))
View(data.frame(restable.11dpi_F22_SOvsCON_SO))
View(data.frame(restable.11dpi_1314_OAvsCON_OA))
View(data.frame(restable.11dpi_F22_OAvsCON_OA))

# SUMMARISE RESULTS
# tells whats up/down-regulated and number genes with non-zero total read count and number genes not included
sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_summary.txt", append=TRUE, split=TRUE)
summary(restable.1dpi_1314_SAvsCON_SA)
summary(restable.1dpi_F22_SAvsCON_SA)
summary(restable.1dpi_1314_SOvsCON_SO)
summary(restable.1dpi_F22_SOvsCON_SO)
summary(restable.1dpi_1314_OAvsCON_OA)
summary(restable.1dpi_F22_OAvsCON_OA)

summary(restable.3dpi_1314_SAvsCON_SA)
summary(restable.3dpi_F22_SAvsCON_SA)
summary(restable.3dpi_1314_SOvsCON_SO)
summary(restable.3dpi_F22_SOvsCON_SO)
summary(restable.3dpi_1314_OAvsCON_OA)
summary(restable.3dpi_F22_OAvsCON_OA)

summary(restable.7dpi_1314_SAvsCON_SA)
summary(restable.7dpi_F22_SAvsCON_SA)
summary(restable.7dpi_1314_SOvsCON_SO)
summary(restable.7dpi_F22_SOvsCON_SO)
summary(restable.7dpi_1314_OAvsCON_OA)
summary(restable.7dpi_F22_OAvsCON_OA)

summary(restable.11dpi_1314_SAvsCON_SA)
summary(restable.11dpi_F22_SAvsCON_SA)
summary(restable.11dpi_1314_SOvsCON_SO)
summary(restable.11dpi_F22_SOvsCON_SO)
summary(restable.11dpi_1314_OAvsCON_OA)
summary(restable.11dpi_F22_OAvsCON_OA)
sink()
## set thresholds
padj.cutoff <- 0.05

# subset table to include only those that are significant
library(tibble)
library("dplyr")

# subset table to include only those that are significant

sig.1dpi_1314_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_1314_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.1dpi_F22_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_F22_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.1dpi_1314_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_1314_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.1dpi_F22_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_F22_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.1dpi_1314_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_1314_OAvsCON_OA), var="gene")), padj < padj.cutoff)
sig.1dpi_F22_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.1dpi_F22_OAvsCON_OA), var="gene")), padj < padj.cutoff)

sig.3dpi_1314_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_1314_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.3dpi_F22_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_F22_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.3dpi_1314_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_1314_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.3dpi_F22_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_F22_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.3dpi_1314_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_1314_OAvsCON_OA), var="gene")), padj < padj.cutoff)
sig.3dpi_F22_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.3dpi_F22_OAvsCON_OA), var="gene")), padj < padj.cutoff)

sig.7dpi_1314_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_1314_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.7dpi_F22_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_F22_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.7dpi_1314_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_1314_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.7dpi_F22_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_F22_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.7dpi_1314_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_1314_OAvsCON_OA), var="gene")), padj < padj.cutoff)
sig.7dpi_F22_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.7dpi_F22_OAvsCON_OA), var="gene")), padj < padj.cutoff)

sig.11dpi_1314_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_1314_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.11dpi_F22_SAvsCON_SA <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_F22_SAvsCON_SA), var="gene")), padj < padj.cutoff)
sig.11dpi_1314_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_1314_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.11dpi_F22_SOvsCON_SO <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_F22_SOvsCON_SO), var="gene")), padj < padj.cutoff)
sig.11dpi_1314_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_1314_OAvsCON_OA), var="gene")), padj < padj.cutoff)
sig.11dpi_F22_OAvsCON_OA <- filter(as_tibble(rownames_to_column(data.frame(restable.11dpi_F22_OAvsCON_OA), var="gene")), padj < padj.cutoff)

sink("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_summary.txt", append=TRUE, split=TRUE)
length(pull(sig.1dpi_1314_SAvsCON_SA, gene))
length(pull(sig.1dpi_F22_SAvsCON_SA, gene))
length(pull(sig.1dpi_1314_SOvsCON_SO, gene))
length(pull(sig.1dpi_F22_SOvsCON_SO, gene))
length(pull(sig.1dpi_1314_OAvsCON_OA, gene))
length(pull(sig.1dpi_F22_OAvsCON_OA, gene))

length(pull(sig.3dpi_1314_SAvsCON_SA, gene))
length(pull(sig.3dpi_F22_SAvsCON_SA, gene))
length(pull(sig.3dpi_1314_SOvsCON_SO, gene))
length(pull(sig.3dpi_F22_SOvsCON_SO, gene))
length(pull(sig.3dpi_1314_OAvsCON_OA, gene))
length(pull(sig.3dpi_F22_OAvsCON_OA, gene))

length(pull(sig.7dpi_1314_SAvsCON_SA, gene))
length(pull(sig.7dpi_F22_SAvsCON_SA, gene))
length(pull(sig.7dpi_1314_SOvsCON_SO, gene))
length(pull(sig.7dpi_F22_SOvsCON_SO, gene))
length(pull(sig.7dpi_1314_OAvsCON_OA, gene))
length(pull(sig.7dpi_F22_OAvsCON_OA, gene))

length(pull(sig.11dpi_1314_SAvsCON_SA, gene))
length(pull(sig.11dpi_F22_SAvsCON_SA, gene))
length(pull(sig.11dpi_1314_SOvsCON_SO, gene))
length(pull(sig.11dpi_F22_SOvsCON_SO, gene))
length(pull(sig.11dpi_1314_OAvsCON_OA, gene))
length(pull(sig.11dpi_F22_OAvsCON_OA, gene))
sink()

write.table(sig.1dpi_1314_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_1314_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.1dpi_F22_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_F22_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.1dpi_1314_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_1314_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.1dpi_F22_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_F22_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.1dpi_1314_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_1314_OAvsCON_OA.txt", quote=F, col.names=NA)
write.table(sig.1dpi_F22_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_1dpi_F22_OAvsCON_OA.txt", quote=F, col.names=NA)

write.table(sig.3dpi_1314_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_1314_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.3dpi_F22_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_F22_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.3dpi_1314_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_1314_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.3dpi_F22_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_F22_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.3dpi_1314_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_1314_OAvsCON_OA.txt", quote=F, col.names=NA)
write.table(sig.3dpi_F22_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_3dpi_F22_OAvsCON_OA.txt", quote=F, col.names=NA)

write.table(sig.7dpi_1314_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_1314_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.7dpi_F22_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_F22_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.7dpi_1314_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_1314_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.7dpi_F22_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_F22_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.7dpi_1314_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_1314_OAvsCON_OA.txt", quote=F, col.names=NA)
write.table(sig.7dpi_F22_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_F22_OAvsCON_OA.txt", quote=F, col.names=NA)

write.table(sig.11dpi_1314_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_1314_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.11dpi_F22_SAvsCON_SA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_F22_SAvsCON_SA.txt", quote=F, col.names=NA)
write.table(sig.11dpi_1314_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_1314_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.11dpi_F22_SOvsCON_SO, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_F22_SOvsCON_SO.txt", quote=F, col.names=NA)
write.table(sig.11dpi_1314_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_1314_OAvsCON_OA.txt", quote=F, col.names=NA)
write.table(sig.11dpi_F22_OAvsCON_OA, file="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_11dpi_F22_OAvsCON_OA.txt", quote=F, col.names=NA)

### results as MA plots - see sigDEGs across range levels
#par(mfrow=c(2,1))
#plotMA_res_table_1314_SAvsCON_unshrunken_1dpi <- hist(res_table_SAxCONv1314_unshrunken, ylim=c(-2,2))
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_CON_hists.pdf", height=11, width=8.5)
hist.restable_1dpi_1314_SAvsCON_SA <- hist(restable.1dpi_1314_SAvsCON_SA$padj, breaks=40, col="grey")
hist.restable_1dpi_1314_SOvsCON_SO <- hist(restable.1dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_1dpi_1314_OAvsCON_OA <- hist(restable.1dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_1dpi_F22_SAvsCON_SA <- hist(restable.1dpi_F22_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_1dpi_F22_SOvsCON_SO <- hist(restable.1dpi_F22_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_1dpi_F22_OAvsCON_OA <- hist(restable.1dpi_F22_OAvsCON_OA$padj, breaks=40,col="grey")

hist.restable_3dpi_1314_SAvsCON_SA <- hist(restable.3dpi_1314_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_3dpi_1314_SOvsCON_SO <- hist(restable.3dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_3dpi_1314_OAvsCON_OA <- hist(restable.3dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_3dpi_F22_SAvsCON_SA <- hist(restable.3dpi_F22_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_3dpi_F22_SOvsCON_SO <- hist(restable.3dpi_F22_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_3dpi_F22_OAvsCON_OA <- hist(restable.3dpi_F22_OAvsCON_OA$padj, breaks=40,col="grey")

hist.restable_7dpi_1314_SAvsCON_SA <- hist(restable.7dpi_1314_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_7dpi_1314_SOvsCON_SO <- hist(restable.7dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_7dpi_1314_OAvsCON_OA <- hist(restable.7dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_7dpi_F22_SAvsCON_SA <- hist(restable.7dpi_F22_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_7dpi_F22_SOvsCON_SO <- hist(restable.7dpi_F22_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_7dpi_F22_OAvsCON_OA <- hist(restable.7dpi_F22_OAvsCON_OA$padj, breaks=40,col="grey")

hist.restable_11dpi_1314_SAvsCON_SA <- hist(restable.11dpi_1314_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_11dpi_1314_SOvsCON_SO <- hist(restable.11dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_11dpi_1314_OAvsCON_OA <- hist(restable.11dpi_1314_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_11dpi_F22_SAvsCON_SA <- hist(restable.11dpi_F22_SAvsCON_SA$padj, breaks=40,col="grey")
hist.restable_11dpi_F22_SOvsCON_SO <- hist(restable.11dpi_F22_SOvsCON_SO$padj, breaks=40,col="grey")
hist.restable_11dpi_F22_OAvsCON_OA <- hist(restable.11dpi_F22_OAvsCON_OA$padj, breaks=40,col="grey")
dev.off()

# (1) convert results table into tibble
#res_table_SAxCONv1314_1dpi_tb <- as_tibble(rownames_to_column(data.frame(res_table_SAxCONv1314), var="gene"))
#View(res_table_SAxCONv1314_1dpi_tb)
# (2) subset table to keep unsignificant genes via pre-defined thresholds:
#sig_SAxCONv1314_1dpi <- filter(res_table_SAxCONv1314_1dpi_tb,res_table_SAxCONv1314_1dpi_tb$padj < 0.05)
#View(sig_SAxCONv1314_1dpi)
#write.table(sig_SAxCONv1314_1dpi, file="/Users/rbadgami/Desktop/kallisto_quant/pairwisedata/dds_1dpi/sig_SAxCONv1314.txt", quote=F, col.names=NA)


