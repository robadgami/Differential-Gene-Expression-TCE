#!/bin/bash
#SBATCH -p nbi-medium
#SBATCH -t 0-3:30
#SBATCH -c 4
#SBATCH --mem=10gb
#SBATCH -J TPMmat_F22
#SBATCH --mail-type=end,fail
#SBATCH --mail-user=roshani.badgami@jic.ac.uk
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/sigDEG_F22/TPMmat_F22_output
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/sigDEG_F22/TPMmat_F22_error

cd /jic/scratch/groups/Diane-Saunders/badgamir/sigDEG_F22/sigDEG_F22_1dpi/F22_1dpi

while read line; do grep -w $line kallisto_tpm.txt >> sigF22_TPMlist.txt; done < sigDEG_F22.txt

#while read line; do grep $line overalllist.txt; done < lineofinterest.txt