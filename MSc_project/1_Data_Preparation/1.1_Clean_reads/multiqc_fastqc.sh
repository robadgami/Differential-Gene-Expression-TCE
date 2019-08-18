#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:30
# SBATCH -c 1
#SBATCH --mem=10gb
#SBATCH -J multiqc_kallisto_quant1
#SBATCH --mail-type=end,fail

source multiqc-1.5a
line=$1
# $1 is the files for fastqc e.g. 1314-3

cd /jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/fastqc_completed/

multiqc ./completed_fastpoutput/$1*/*fastqc.zip

# for  fastp output collation:
#multiqc $filelocaion/$file\*fastp.json