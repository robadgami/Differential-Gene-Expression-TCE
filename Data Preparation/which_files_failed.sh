#!/bin/bash
#SBATCH -p nbi-short
#SBATCH -t 0-0:10
#SBATCH -c 1
#SBATCH --mem=4gb
#SBATCH -J checkingfastpfile
#SBATCH --mail-type=none
#SBATCH -o /jic/scratch/groups/Diane-Saunders/badgamir/file_output
#SBATCH -e /jic/scratch/groups/Diane-Saunders/badgamir/file_error

inputfiles=rawreads.txt
completedfiles=fastpdone.txt
failedfiles=dofastp.txt

## this script will show which files have not worked
## need to first make the files themselves
## make sure there are no duplicates

diff $inputfiles $completedfiles | grep '^<' > $failedfiles
