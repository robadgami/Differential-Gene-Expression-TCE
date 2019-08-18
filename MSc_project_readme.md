# INTRODUCTION

The aim of the MSc project was to identify mechanisms associated with incompatibility of wheat cultivar Santiago to a group1 *Pst* isolate F22. Then, the expression of the underlging genes were observed upon a compatible Santiago- group 4 *Pst* isolate 13/14, to determine whether these mechanisms were targeted by 13/14 isolates.

The project can be split into 4 parts:

1. Data Preparation - to obtain high-quality gene expression information.
2. DGE analysis - to obtain incompatibility-associated genes.
3. Incompatibility mechanisms - to identify mechanisms linked to incompatibility-associated genes.
4. Expression in 13/14 - to observe how the expression of underlying genes change upon 13/14 infection.



## 1. Data Preparation

### 1.1 Clean Reads

Initially, the paired-end raw reads (`[sample.name]_R1_001.fastq.gz` and `[sample.name]_R2_001.fastq.gz`) need to be cleaned and trimmed. 

1. Fitler reads via all-in-one using **fastp v.0.12.3** set at phred-score 15 (default) in a slurm script [fastp.sh](Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/fastp.sh).

> Note1: phred-score can be increased to 20 by adding `-q 20` after `fastp` in the slurm script as in [fastpwheat.sh](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/fastpwheat.sh).
>
> Note2: some samples needed to have a defined adaptor sequence to search and remove, as [fastpredo.sh](Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/fastpredo.sh) 

2. Check filter read quality via **fastqc**, as in [fastqc.sh](Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/fastqc.sh).

   In the terminal, the following should be written, where `[sample.name]` is the name of the sample:

```sh
scriptlocation="path/to/slurm/script"
# for individual samples
sbatch $scriptlocation/fastpwheat.sh [sample.name]

# Alternatively,
# for multiple samples, make a uniqfiletitle.txt with all [sample.name], then:
while read line; do sbatch $scriptlocation $line; done < uniqfiletitle.txt
```



> To check if all samples have been done, do:
>
> ```sh
> # list of all raw reads
> readlocation="/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/RNAseq_data_from_Genewiz/TCE-reads"
> ls $readlocation | cut -d _ -f1 | uniq > rawreads.txt
> 
> # list of all fastp-completed files
> outputreadlocation="/jic/scratch/groups/Diane-Saunders/badgamir/fastpoutput"
> ls $outputreadlocation| cut -d _ -f1 |uniq > fastpdone.txt
> 
> # list which files have not been completed
> diff rawreads.txt fastpdone.txt | grep '^<' > dofastp.txt
> ```





During, data preparation, some samples would not remove some adaptors *even* when defined. For these, the fastp output files were further cleaned using **bbduk**. This involved using a slurm script [bbduk.sh](Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/bbduk.sh), kindly provided (then slightly altered) by *Pilar Corredor-Moreno*.  The following should be typed into the terminal:

```sh
sbatch $scriptlocation/bbduk.sh [sample.name]
```



##### Visualise Clean Reads

1. Collate multiple fastqc or fastp output files for easier visualisation using **multiqc v.1.5a**, as in [multiqc_fastqc.sh](Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.1_Clean_reads/multiqc_fastqc.sh).
2. Data for filtered output in excel format in [qualityfilter_output.xlsx](smb://jic-group-data/jic-research-groups/Diane-Saunders/Rosh/Files/qualityfilter_output.xlsx).

----

### 1.2 Pseudoalignment

The clean-raw reads can be pseudoaligned to a reference genome to obtain a raw read count.

1. The reference used is the new refseqv1.1 transcriptome. Both the HC `IWGSC_v1.1_HC_20170706_transcripts.fasta` and LC `IWGSC_v1.1_LC_20170706_transcripts.fasta`  files were downloaded from https://wheat-urgi.versailles.inra.fr/Seq-Repository/Annotations.

2. They were then concatenated and sorted to form a summative transcriptome `IWGSC_v1.1_ALL_20170706_transcripts.fasta` using the slurm script [cat_transcripts.sh](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.2_Pseudoalignment/cat_transcipts.sh). 

3. Then, a kallisto index was built to enable psedoalignment by using the slurm script [kallisto_index.sh](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.2_Pseudoalignment/kallisto_index.sh).

4. Then, pseudoalignment of filtered reads for each sample was done using the slurm script [kallisto_quant.sh](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.2_Pseudoalignment/kallisto_quant.sh). 

> **Note:** within the script, input the [sample.names] to be pseudoaligned.

5. Whether the pseudoalignment was successful can be confirmed in ***R*** by typing in the following code.

```R
#install.packages (“rhdf5”)
library("rhdf5")
rhdf5::h5read("/Users/rbadgami/Desktop/kallisto_quant/kallisto_results/[sample.name]/abundance.h5", "aux/ids")
```

> For samples where pseudoalignment was unsuccessful, kallisto_quant.sh was re-run but with greater memory and time.



##### Visualise percentage reads mapped to wheat/isolate

Data for "reads mapped to wheat" is in [20190529_readsmappedtowheat.xlsx](smb://jic-group-data/jic-research-groups/Diane-Saunders/Rosh/Files/20190529_readsmappedtowheat.xlsx).

Visualise percentage reads mapped to wheat/isolate via [mappingreadsstackedbarchart.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.2_Pseudoalignment/mappingreadsstackedbarchart.R).

----

### 1.3 Gene Expression

The pseuodalignment read counts need to be converted to gene expression data.

1. Move all the kallisto_quant.sh output files onto desktop and open R.

2. Have a quick look at kallisto results via [sleuth.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.3_Gene_expression/sleuth.R)

3. Convert to gene expression data using R script [tximport.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.3_Gene_expression/tximport.R).

4. Make data suitable for DGE analysis and analyse gene expression QC using R script [DESeq2_initial.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.3_Gene_expression/DESeq2_initial.R).



##### Visualise Gene Expression analysis

Graphs for gene expression QC within R script DESeq2_initial.R.



-----

## 2. DGE analysis:
#####2.1 DGE analysis

Identify differential gene expression (DGE) upon infection (infected vs control) and between cultivars (cultivar vs cultivar), to obtain incomaptibility-associated genes that are: 

​		''*differentially expressed upon infection and more expressed in the most incompatible cultivar than other, 		more compatible, cultivars*"

1. Find genes differentially expressed upon infection within each cultivar via R script [DESeq2_CON2.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.4_DGE_analysis/DESeq2_CON2.R).

2. Find genes differentially expressed between cultivars via R script [DESeq2_isolate.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.4_DGE_analysis/DESeq2_isolate.R).

   ##### Visualise DGE Analysis

   Data for significantly differentially expressed genes upon F22 or 13/14 infection available in [sigF22_TPMlist.xlsx](smb://jic-group-data/jic-research-groups/Diane-Saunders/Rosh/Files/sigF22_TPMlist.xlsx) and [sig1314_TPMlist.xlsx](smb://jic-group-data/jic-research-groups/Diane-Saunders/Rosh/Files/sig1314_TPMlist.xlsx), respectively.

   Data for total number DEGs for infected/control and cultivar/cultivar comparisons available in [control_sig.xlsx](smb://jic-group-data/jic-research-groups/Diane-Saunders/Rosh/Files/control_sig.xlsx)

   Visualise number DEGs for each infected/control comparison via [barchart_DESeq2_control_sigDEG.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.4_DGE_analysis/barchart_DESeq2_control_sigDEG.R).

   Visualise number DEGs for each cultivar/cultivar comparison via [DESeq2_isolate_barchart.R](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.4_DGE_analysis/DESeq2_isolate_barchart.R).

   

##### 2.2 Identify incompatibility-associated genes

1. Collate both info to find incompatibility-associated genes using bash script [rectifyingLFCcomparisons.sh](/Users/rbadgami/Desktop/untitled folder/1_Data_Preparation/1.4_DGE_analysis/rectifyingLFCcomparisons.sh).

2. Visualise how incompatibility-associated genes were chosen based on their log2 foldchange expression during pairwise comparisons via R script [LFC_SAvCON.R](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/2_DGE_analysis/2.2_Identify_incompatibility_genes/LFC_SAvCON.R).

   

-----

## 3. Incompatibility mechanisms

1. Obtain GO terms of incompatibility-associated genes via pipeline in [GOterm_incompatibility_genes.sh](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/3_Incompatibility_mechanisms/GOterm_incompatibility_genes.sh).
2. Visualise percentage genes assigned to GO terms of incompatibility-associated genes via R script [rectifyingLFC_F22_graphs.R](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/3_Incompatibility_mechanisms/rectifyingLFC_F22_graphs.R).

2. KEGG pathway information via pipeline described in [all_things_KEGG.md](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/3_Incompatibility_mechanisms/all_things_KEGG.md).
3. Simple Ortholog searches also possible by searching gene ID in [Ensembl Plant](http://plants.ensembl.org/index.html).



----

## 4. Expression in 13/14

1. Obtain log2 fold change in gene expression of F22-infected Santiago vs 13/14-infected Santiago via R script [DESeq2_SA.R](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/4_Expression_in_1314/DESeq2_SA.R).
2. Grep incompatibility-associated genes by following bash script [Incompatibilitygenes_1314.sh](Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/4_Expression_in_1314/Incompatibilitygenes_1314.sh).
3. Visualise log2 fold change in gene expression via R script [ggplot_LFC_SA.R](/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/MSc_project/4_Expression_in_1314/ggplot_LFC_SA.R).

