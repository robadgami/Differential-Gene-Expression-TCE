#!/bin/bash
#SBATCH -p nbi-medium
#SBATCH -c 2
#SBATCH --mem=60gb
#SBATCH -J F22-7-SO2_bbduk
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=roshani.badgami@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/F22-7-SO2_fastqc/F22-7-SO2_bbduk_slurmoutput
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/F22-7-SO2_fastqc/F22-7-SO2_bbduk_slurmerror

home='/jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/F22-7-SO2_fastqc'
cd $home
# source trimmomatic-0.33
# source fastqc-0.11.3   
source jre-7.21
source bbtools-37.68
path='/nbi/software/testing/trimmomatic/0.33/x86_64/bin'
file='F22-7-SO2_bbduk'


/nbi/software/testing/bbtools/37.68/x86_64/bbduk.sh -Xmx1g t=12 in1=F22-7-SO2_output_R1_001.fastq.gz in2=F22-7-SO2_output_R2_002.fastq.gz out1=$file\_clean_R1_001.fastq.gz out2=$file\_clean_R2_001.fastq.gz minlength=36 qtrim=rl trimq=20 ktrim=r k=25 mink=11 ref=$path/adapters/TruSeq3-PE-2.fa hdist=1
	
# fastqc $file\_clean_R1_001.fastq.gz
# fastqc $file\_clean_R2_001.fastq.gz
