#!/bin/bash 
#SBATCH --mem=128G
#SBATCH -c 12
#SBATCH -p RG-Diane-Saunders
#SBATCH -J gunzip



# home=('/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/RNAseq_data_from_Genewiz') #Give working directory
home=('/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/refseq-FP-aug18') 
# work=('MY1708311_R1_pilar')
cd $home
# source trimmomatic-0.33
source fastqc-0.11.3   
source jre-7.21
source bbtools-37.68
path=('/nbi/software/testing/trimmomatic/0.33/x86_64/bin')
file=$1


/nbi/software/testing/bbtools/37.68/x86_64/bbduk.sh -Xmx1g t=12 in1=*_R1.fastq in2=*_R2.fastq out1=$file\_clean_R1_001.fastq out2=$file\_clean_R2_001.fastq minlen=36 qtrim=rl trimq=10 ktrim=r k=25 mink=11 ref=$path/adapters/TruSeq3-PE-2.fa hdist=1
	
fastqc $file\_clean_R1_001.fastq
fastqc $file\_clean_R2_001.fastq



