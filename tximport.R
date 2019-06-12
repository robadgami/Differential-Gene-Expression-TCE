# https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
citation("tximport")

### kallisto found transcript abundance via pseudoalignment, want gene-level count matrix for DESeq2 - so import transcript abundance and convert to gene-level via tximport
# "Note that the tximport-to-DESeq2 approach uses estimated gene counts from the transcript abundance quantifiers, but not normalized counts!!!"

# Install tximport package into R
# source("https://bioconductor.org/biocLite.R")
# biocLite("tximport")

# load tximport package
library(tximport)
library(readr)

# import .csv with "sample_info" and "abundance.tsv" filepath (sleuthpath.csv)
base_dir <- "/Users/rbadgami/Desktop/data2/read_count_data"
sample_info <- read.table(file = file.path(base_dir,"metadata","sleuthpath.csv"), sep = ",", header = TRUE, stringsAsFactors = FALSE)
#combine filepath with "abundance.tsv" so vector to kallisto results files
files <- file.path(sample_info$path, "abundance.h5")
names(files) <- paste0(sample_info$sample)
# check file name and filepath match.
files
all(file.exists(files))

# associate transcripts with gene IDs for gene-level summarisation. Kallisto only gives transcript ID.
# get this pre-constructed tx2gene (transscript to gene) table of wheat from Borrill github.
tx2gene <- read.table("https://raw.githubusercontent.com/Borrill-Lab/WheatFlagLeafSenescence/master/data/transcripts_to_genes_RefSeqv1.0_annot_v1.1.txt", header=TRUE)
head(tx2gene)

###### Summarise counts per gene #####
# information on RNA-seq units: https://haroldpimentel.wordpress.com/2014/05/08/what-the-fpkm-a-review-rna-seq-expression-units/

# read in the files and sum per gene
txi <- tximport(files, type="kallisto", tx2gene = tx2gene)
saveRDS(txi, file = "/Users/rbadgami/Desktop/data2/read_count_data/txi.RData")
names(txi)
# abundance = tpm summarised per gene
# counts = 
# length = average transcript length for each gene which can be used as an offset for gene-level analysis
# countsFromAbundance = c("no", "scaledTPM", "lengthScaledTPM")


# to see counts summarised per gene
## number reads align to location, depends on relative abundance and length (available start sites)
## NOT scaled by length so NOT COMPARABLE WITHIN SAMPLE
## generally used for differential expression as represented by negative binomial - "DESeq2 expects un-normalised counts or estimated counts in a count matrix (row=genes, column=sample, fill=un-normalised counts) as it internally corrects for library size
# Ref(https://www.bioconductor.org/packages/devel/bioc/vignettes/DESeq2/inst/doc/DESeq2.html)
colnames(txi$counts)
head(txi$counts)
# to see tpm summarised per gene
colnames(txi$abundance)
head(txi$abundance)

expression_location <- "/Users/rbadgami/Desktop/data2/read_count_data/"

# save counts summarised per gene:
# write.table(txi$counts, file=paste0(expression_location,"genelevel_kallisto_unnormalisedcounts.tsv"),sep="\t")

# save tpm summarised per gene:
# write.table(txi$abundance, file=paste0(expression_location,"genelevel_kallisto_tpm.tsv"),sep = "\t")

# see lengths summarised per gene
head(txi$length)

# calculate average gene length across all samples
gene_length <-as.data.frame(rowMeans(txi$length))
head(gene_length)
colnames(gene_length) <- c("length")
head(gene_length)

#save length per gene
# write.csv(gene_length, file=paste0(expression_location,"kallisto_gene_length.csv"))

# also make transcript-level estimates as a list of matrices
txi.kallisto <- tximport(files, type = "kallisto", txOut = TRUE)
# names(txi.kallisto)
# head(txi.kallisto$counts)
# write.csv(txi.kallisto$counts, file=paste0(expression_location,"transcriptlevel_kallisto_unnormalisedcounts.tsv",sep="\t"))

