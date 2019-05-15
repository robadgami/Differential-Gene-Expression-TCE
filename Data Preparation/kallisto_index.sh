#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:25
#SBATCH -c 1
#SBATCH --mem=10gb
#SBATCH -J kallistoindex_wheat
#SBATCH --mail-type=end,fail
# SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/kallistoindex_error
# SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/kallistoindex_output

source kallisto-0.43.1

# make kallisto index for wheat transcriptome
# transcriptome sequences are in /hpc-home/rbadgami/RefSeq/iwgsc_refseqv1.1_genes_2017July06
kallisto index -k 31 --index IWGSC_v1.1_ALL_20170706_transcripts_kallisto0.44.0_index IWGSC_v1.1_ALL_20170706_transcripts.fasta