#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:15
#SBATCH -c 1
#SBATCH --mem=2gb
#SBATCH -J kallistotranscriptome_wheat
#SBATCH --mail-type=end,fail
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/transcriptome_error
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/transcriptome_output

filelocation='/hpc-home/rbadgami/RefSeq/iwgsc_refseqv1.1_genes_2017July06'
cat IWGSC_v1.1_HC_20170706_transcripts.fasta IWGSC_v1.1_LC_20170706_transcripts.fasta | sort > IWGSC_v1.1_ALL_20170706_transcripts.fasta