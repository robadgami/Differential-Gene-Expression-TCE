#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-1:00
#SBATCH -c 1
#SBATCH --mem=4gb
#SBATCH -J fastpscript_wheat
#SBATCH --mail-type=end,fail
# SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/output
# SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/error


inputreads="/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/RNAseq_data_from_Genewiz/TCE-reads"
work="/jic/scratch/groups/Diane-Saunders/badgamir"

source fastp-0.12.3


## This script will run a fastp for paired-end reads
## the fastq.gz files can be differentiated by ***_R1.fastq.gz
## the output files will be saved in the work directory

### to run this, on the terminal input:
### while read line ; do sbatch fastpwheat.sh $line ; done<uniqfiletitle.txt
### where 'uniqfiletitle' contains the filename to match R1 and R2.

line=$1
sample=$line

fastp -i $inputreads/$sample\_R1_001.fastq.gz -I $inputreads/$sample\_R2_001.fastq.gz -o $work/$sample\_output_R1_001.fastq.gz -O $work/$sample\_output_R2_002.fastq.gz

mv fastp.html $sample\_fastp.html
mv fastp.json $sample\_fastp.json

# run fastqc on output files
source fastqc-0.11.3
source jre-7.21
source jdk-1.7.0_25

fastqc $sample\_output_R1_001.fastq.gz
 fastqc $sample\_output_R2_002.fastq.gz
