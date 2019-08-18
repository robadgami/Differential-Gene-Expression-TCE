# roughly following: https://github.com/hbctraining/DGE_workshop/blob/master/lessons/

library(DESeq2)
#require(ggplot2)
library(ggplot2)
##### make DESeqDataSet object #####
# have metadata match unnormalised count data (counts) i.e. so the number of gene rows is correct (DESeq2 normalises so must input unnormalised count data!)
base_dir <- "/Users/rbadgami/Desktop/data2/read_count_data"
sample_info <- read.table(file = file.path(base_dir,"metadata","sleuthpath.csv"), sep = ",", header = TRUE, stringsAsFactors = FALSE)
txicounts <- read.table(file = file.path(base_dir,"genelevel_kallisto_unnormalisedcounts.tsv"), sep = "\t", header = TRUE, stringsAsFactors = FALSE)
ExpVar <- data.frame(row.names=colnames(txicounts), sample_info)
#alternatively,
#ExpVar <- data.frame(row.names=colnames(txi$counts), sample_info)
head(ExpVar)
colnames(ExpVar)

ExpVar$sample=as.factor(ExpVar$sample)
ExpVar$treatment=as.factor(ExpVar$treatment)
ExpVar$timepoint=as.factor(ExpVar$timepoint)
ExpVar$dpi=as.factor(ExpVar$dpi)
ExpVar$isolate=as.factor(ExpVar$isolate)
ExpVar$cultivar=as.factor(ExpVar$cultivar)
ExpVar$cultivar_isolate=as.factor(ExpVar$cultivar_isolate)
ExpVar$replicate=as.factor(ExpVar$replicate)
ExpVar$RNA_dilution=as.Date(ExpVar$RNA_dilution)
ExpVar$data_cleaning=as.factor(ExpVar$data_cleaning)
ExpVar$QC_date=as.factor(ExpVar$QC_date)
# note: QC_date is fastp_date

# make the DESeqDataSet Object - uses counts and average transcript lengths from tximport
#dds <- DESeqDataSetFromTximport(txi, colData=ExpVar, design=~isolate+cultivar+isolate:cultivar)
dds <- DESeqDataSetFromTximport(txi, colData=sample_info, design=~cultivar_isolate)
nrow(dds)
# get rid of genes that only give 0 or 1 normalised count OVER ALL SAMPLES
#nrow(dds) were 269428 rows/transcripts
dds <- dds[rowSums(counts(dds)) > 1, ]
nrow(dds)
#nrows(dds) now 162004
View(counts(dds))

##### NORMALISATION #####
# normalise counts - automatically done in DESeq() function. May be good for later visualisation
dds <- estimateSizeFactors(dds)
sizeFactors(dds)
normalised_counts <- counts(dds, normalized=TRUE)

expression_location <- "/Users/rbadgami/Desktop/data2/read_count_data/"
write.csv(normalised_counts, file=paste0(expression_location, "DESeq2_manual_normalisedcounts.csv"), quote=F, col.names=NA)


##### DGE QC ANALYSIS #####
# transform normalised counts via rlog transformation
## improve clustering for PCA and hierarchical clustering visualisation methods
rld <- vst(dds, blind=TRUE, nsub = 20000, fitType = "parametric")
head(rld)
# plot PCA for PC1 and PC2
plot.PCA_treatment <- plotPCA(rld, intgroup="treatment")
plot.PCA_isolate <- plotPCA(rld, intgroup="isolate") 
plot.PCA_cultivar <- plotPCA(rld, intgroup="cultivar")
plot.PCA_dpi <-plotPCA(rld, intgroup="dpi")
plot.PCA_cultivar_isolate <- plotPCA(rld, intgroup="cultivar_isolate")
plot.PCA_data_cleaning <- plotPCA(rld, intgroup="data_cleaning")
plot.PCA_sample <- plotPCA(rld, intgroup="sample")

# for other PCs input is a matrix of log transformed values
rld_mat <- assay(rld)
#pca <- prcomp(t(rld_mat))
#create data frame with metadata and PCx, Pcy values for input to ggplot
#df <- cbind(sample_info, pca$x)
# ggplot(df) + geom_point(aes(x=PC3, y=PC4, colour = cultivar_isolate))

##### HIERARCHICAL CLUSTERING #####
# install.packages("pheatmap")
library(pheatmap)

# compute pairwise correlation values
#View(rld_mat)
rld_cor <- cor(rld_mat)
head(rld_cor)

# Plot heatmap - are there outlying samples? do samples cluster by sample group?
plot.heatmap <- pheatmap(rld_cor)

## Export as pdf images
pdf("/Users/rbadgami/Desktop/data2/Results_figures/DESeq2_initial.pdf",height=11, width=8.5)
plot.new()
plot.PCA_treatment
plot.PCA_isolate 
plot.PCA_cultivar
plot.PCA_dpi
plot.PCA_cultivar_isolate
plot.PCA_data_cleaning
plot.PCA_sample
plot.new()
plot.heatmap
dev.off()
sessionInfo()
