#Data Preparation

### Clean raw reads

Initially, the paired-end raw reads (`[sample.name]_R1_001.fastq.gz` and `[sample.name]_R2_001.fastq.gz`) need to be cleaned and trimmed. This can be done all-in-one using **fastp v.0.12.3** set at phred-score 15 (default) in a slurm script (fastp.sh)[….].

(Note: phred-score can be increased to 20 by adding `-q 20` after `fastp` in the slurm script.)

While fastp does give a `.json` and `.html` report, **fastqc** is done on samples.

In the terminal, the following should be written, where `[sample.name]` is the name of the sample:

``` sh
scriptlocation="path/to/slurm/script"
# for individual samples
sbatch $scriptlocation/fastpwheat.sh [sample.name]

# Alternatively,
# for multiple samples, make a uniqfiletitle.txt with all [sample.name], then:
while read line; do sbatch $scriptlocation $line; done < uniqfiletitle.txt
```

*note: check -u 50*

> If adapters are not be removed properly, they can be defined using (1) fastp adaptor library by the option `--detect_adaptor_for_pe` or (2) manually defined using `—adaptor_sequence=[nucleotide.sequence.forward.adaptor] —adaptor_sequence_r2=[nucleotide.sequence.reverse.adaptor]`. 

To check if all samples have been done, do:

``` sh
# list of all raw reads
readlocation="/nbi/Research-Groups/JIC/Diane-Saunders/User_Workareas/morenop/RNAseq_data_from_Genewiz/TCE-reads"
ls $readlocation | cut -d _ -f1 | uniq > rawreads.txt

# list of all fastp-completed files
outputreadlocation="/jic/scratch/groups/Diane-Saunders/badgamir/fastpoutput"
ls $outputreadlocation| cut -d _ -f1 |uniq > fastpdone.txt

# list which files have not been completed
diff rawreads.txt fastpdone.txt | grep '^<' > dofastp.txt
```



It is possible to collate multiple fastqc or fastp output files for easier visualisation using **multiqc v.1.5a** using the code:

``` sh
$filelocation="path/to/outputfile/location"
$file="directory.containing.all.desired.files"
source multiqc-1.5a
multiqc $filelocation/$file\*fastqc.zip
#alternatively,
#multiqc $filelocaion/$file\*fastp.json
```

During, data preparation, some samples would not remove some adaptors *even* when defined. For these, the fastp output files were further cleaned using **bbduk**. This involved using a slurm script [bbduk.sh](….). kindly provided (then slightly altered) by *Pilar Corredor-Moreno*.  The following should be typed into the terminal:

``` sh
sbatch $scriptlocation/bbduk.sh [sample.name]
```



### Pseudoalignment

The clean-raw reads can be pseudoaligned to a reference genome to obtain a raw read count.



The reference used is the new refseqv1.1 transcriptome. Both the HC `IWGSC_v1.1_HC_20170706_transcripts.fasta` and LC `IWGSC_v1.1_LC_20170706_transcripts.fasta`  files were downloaded from …..



They were then concatenated to form a summative transcriptome `IWGSC_v1.1_ALL_20170706_transcripts.fasta` using the slurm script [cat_transcripts.sh](…). 

> …….
>
> WRITE UP ABOUT KALLISTO INDEX
>
> ………...
>
> use slurm script [kallisto_index.sh](…) 



To pseudoalign use slurm script [kallisto_quant.sh](…). 

**Note:** within the script, input the [sample.names] to be pseudoaligned.



Whether the pseudoalignment was successful can be confirmed in ***R*** by typing in the following code.

``` R
#install.packages (“rhdf5”)
library("rhdf5")
rhdf5::h5read("/Users/rbadgami/Desktop/kallisto_quant/kallisto_results/[sample.name]/abundance.h5", "aux/ids")
```

