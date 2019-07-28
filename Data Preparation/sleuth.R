# Tutorial: https://scilifelab.github.io/courses/rnaseq/labs/kallisto
# paper with more detail: Harold J. Pimentel, Nicolas Bray, Suzette Puente, Páll Melsted and Lior Pachter, Differential analysis of RNA-Seq incorporating quantification uncertainty, Nature Methods (2017), advanced access http://dx.doi.org/10.1038/nmeth.4324.
# following info at: https://pachterlab.github.io/sleuth_walkthroughs/trapnell/analysis.html


### note: sleuth is "a group of kallisto results, and can then operate on them while accounting for covariates, sequencing depth, technical and biological variance.
### i.e. sleuth is great for an initial overview of the read count information before extracting count data

# load sleuth package
library("sleuth")

# specify location of kallisto_quant sample read count files
base_dir <- "/Users/rbadgami/Desktop/data2/read_count_data"

# specify where samples (kallisto results) are stored
sample <- dir(file.path(base_dir,"kallisto_results2"))
sample
# collate list of paths to  kallisto results which are indexed by sample ID
kal_path <- file.path(base_dir, "kallisto_results2", sample)
kal_path

# load auxillary table describing design and relationship between the direcotries and samples
s2c <- read.table(file = file.path(base_dir,"metadata","sampleinfo.csv"), sep = ",", header = TRUE, stringsAsFactors = FALSE)
View(s2c)

s2c <- dplyr::select(s2c, sample=sample_id,treatment,isolate,timepoint,cultivar,cultivar_isolate,replicate,RNA_dilution,data_cleaning,QC_date)
# append directory in new column called 'path' to table describing experiment so samples are associated with kallisto quantifications 
s2c <- dplyr::mutate(s2c,path = kal_path)
# check pairing is correct - - check sampleID and path match.
print(s2c)
colnames(s2c)
View(s2c)
write.csv(s2c, "/Users/rbadgami/Desktop/data2/read_count_data/metadata/sleuthpath.csv")
#### MAKE SLEUTH OBJECT ####
# stores experiment info, differential testing model info and results
## (1) load kallisto processed data into object 'so' - read kallisto output, connect to metadata, set up linear model
so <- sleuth_prep(s2c, extra_bootstrap_summary = TRUE, num_cores = 1)

## (2) estimate parameters for sleuth response error measurement (full) model - fit full model so 'smooth' raw kallisto abundance estimates for each sample via the linear model with parameters representing the experimental conditions
### includes parameters that are strain dependent
so <- sleuth_fit(so, ~timepoint + cultivar_isolate + RNA_dilution, 'full')

## (3) estimate sleuth reduced model parameter - fit 'reduced' model
### reduced model fits a single parameter for each gene so enforces equal abundance between conditions
so <- sleuth_fit(so, ~1, 'reduced')

## (4) perform differential analysis using likelihood ratio test
##use a likelihood ratio test to identify which abundances are better explained when full model is taken into account
so <- sleuth_lrt(so, 'reduced', 'full')

########### VISUALISE EXPERIMENT VIA SHINY #############
## Shiny is an R-package that creates a webpage to allow easy exploration of expression variation among samples, qc plots, etc to view and interact with results:
sleuth_live(so)
