### READ CLEANING

Script used is [fastp.sh and bbduk.sh](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/Data Preparation) and 

Cleaned reads can be found in [here](smb://jic-group-data/Group-Scratch/Diane-Saunders/badgamir/fastp_output1/fastqc_completed); multiqc report can be found here - [qualityfilter_output.xlsx](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/Data Preparation/qualityfilter_output.xlsx)

- To calculate how many sequences passed filtering (fastqc) -> get mean and standard deviation as I'm interested in the variability. mean=20.7M, stdv=3.5M, se=0.3 (1dp)
- sequence per sample: mean=136bp, stdv=6.0bp, se=0.5bp
- GCcontent%: mean=52.5%, stdv=2.1, se=0.2

> standard deviation: how accurately the mean represents sample data. 
>
> standard error: how precise the mean of the sample is versus the true mean of the population



## READ PSEUDOALIGNMENT

Gene model for high- and low-confidence genes were concatenated using script [cat_transcripts.sh](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/Data Preparation/cat_transcripts.sh).

Script used is [kallisto_index.sh and kallisto_quant.sh](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/Data Preparation). 

Mapping data can be found here - 

]

- total mapped reads per sample: mean=15523724, stdv=4819746, se=535527