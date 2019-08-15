#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:15
#SBATCH -c 1
#SBATCH --mem=2gb
#SBATCH -J control_DEGs
#SBATCH --mail-type=end,fail
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/controlDEG_error
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/controlDEG_output


while read line ; do  cut -d " " -f2 $line >> DEG_gene.txt; done<sig_CON.txt