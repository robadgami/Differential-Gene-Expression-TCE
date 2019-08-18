#!/bin/bash
#SBATCH -p nbi-medium
#SBATCH -t 0-02:30
#SBATCH -c 1
#SBATCH --mem=16gb
#SBATCH -J fastqc-0.11.3
#SBATCH --mail-type=end,fail
# SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/fastpoutput_fastqcoutput
# SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/fastpoutput_fastqcerror
source fastqc-0.11.3
source jre-7.21
source jdk-1.7.0_25

cd /jic/scratch/groups/Diane-Saunders/badgamir/fastp_output1/fastqc_completed/completed_fastpoutput

F='./fastqcneeded_1314-3-SA2/1314-3-SA2'
G='./fastqcneeded_1314-3-SA3/1314-3-SA3'
H='./fastqcneeded_CON-0-OA1/CON-0-OA1'
I='./fastqcneeded_CON-0-OA2/CON-0-OA2'
J='./fastqcneeded_CON-0-OA3/CON-0-OA3'
I='./fastqcneeded_CON-0-SA1/CON-0-SA1'
J='./fastqcneeded_CON-0-SA2/CON-0-SA2'
K='./fastqcneeded_F22-11-SA2/F22-11-SA2'

for filename in $F $G $H $I $J $K
do
 fastqc $filename\_output_R1_001.fastq.gz
 fastqc $filename\_output_R2_002.fastq.gz
done