#!/bin/bash
#SBATCH -p nbi-medium
#SBATCH -t 1-0:00
#SBATCH --mem=60gb
#SBATCH -J kall_faultyhd5
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=roshani.badgami@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/kall_faultyhd5_output
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/kall_faultyhd5_output


source kallisto-0.43.1

index='IWGSC_v1.1_ALL_20170706_transcripts_kallisto0.44.0_index'
workinglocation='/jic/scratch/groups/Diane-Saunders/badgamir'
output='IWGSC_v1.1_ALL_20170706_transcripts_kallisto0.44.0_alignment'
readlocation='/jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/fastqc_completed/completed_fastpoutput'

A='1314-1-SA1'
B='1314-1-SA2'
C='1314-1-SA3'
D='1314-7-OA3'
E='1314-7-SA2'
for readtitle in $A $B $C $D $E
do
	# Borrill put -t 8 as using 8 CPU cores per task, number threads
# -b INT is number bootstraps
kallisto quant -i $workinglocation/$index -b 100 -o $workinglocation/$readtitle --pseudobam $readlocation/$readtitle/$readtitle\_output_R1_001.fastq.gz $readlocation/$readtitle/$readtitle\_output_R2_002.fastq.gz
done
