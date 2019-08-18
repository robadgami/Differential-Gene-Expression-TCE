#!/bin/bash
#SBATCH -p nbi-medium
# SBATCH -t 1-00:30
# SBATCH -c 1
# SBATCH --mem=20gb
#SBATCH -J kallistoquant
#SBATCH --mail-type=end,fail
# SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/kallistoindex_error
# SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/kallistoindex_output

source kallisto-0.43.1

index='IWGSC_v1.1_ALL_20170706_transcripts_kallisto0.44.0_index'
workinglocation='/jic/scratch/groups/Diane-Saunders/badgamir'
output='IWGSC_v1.1_ALL_20170706_transcripts_kallisto0.44.0_alignment'
readlocation='/jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/fastqc_completed/completed_fastpoutput'

A='1314-11-SO3'
B='1314-11-SO2'
C='1314-11-SO1'
D='1314-11-SA3'
E='1314-11-SA2'
F='1314-11-SA1'
G='1314-11-OA3'
H='1314-11-OA2'
I='1314-11-OA1'

for readtitle in $A $B $C $D $E $F $G $H $I 
do
readtitle=$readtitle
# Borrill put -t 8 as using 8 CPU cores per task, number threads
# -b INT is number bootstraps
kallisto quant -i $workinglocation/$index -b 100 -o $workinglocation/$readtitle --pseudobam $readlocation/$readtitle/$readtitle\_output_R1_001.fastq.gz $readlocation/$readtitle/$readtitle\_output_R2_002.fastq.gz
done
