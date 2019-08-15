#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-00:15
#SBATCH -c 1
#SBATCH --mem=2GB
#SBATCH -N 1
#SBATCH -J fastpscript_wheat
#SBATCH --mail-type=none
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/filetitle_output
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/filetitle_error

readlocation="/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/RNAseq_data_from_Genewiz/TCE-reads"
namesfile=readnames

ls $readlocation | cut -d _ -f1 | uniq > $namesfile\.txt