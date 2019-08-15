#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:05
#SBATCH -c 1
#SBATCH --mem=3gb
#SBATCH -J transcriptsort_wheat
#SBATCH --mail-type=end,fail
# SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/transcriptsort_error
# SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/transcriptsort_output

sort IWGSC_v1.1_ALL_20170706_transcripts.fasta