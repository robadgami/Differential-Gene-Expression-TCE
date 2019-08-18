mkdir $filelocation/GOannotation
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
for file in genes*.txt; do
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/$file /Users/rbadgami/Desktop/data2/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/data2/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $filelocation/GOannotation/GOannotation_$file &&
tail -n +21 $filelocation/GOannotation/GOannotation_$file | sed 's/^[^G]*G/G/' > $filelocation/GOannotation/table_GOannotation_$file &&
head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file
awk -F '\t' '$13 < 0.05' $filelocation/GOannotation/table_GOannotation_$file | awk -F '\t' '$8 < 4 && $8>2' >> $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file; done

cd $filelocation/GOannotation
for file in 'genes_rectifyingLFCerror_1dpi_SAupreg_LFC.txt' 'genes_rectifyingLFCerror_3dpi_SAupreg_LFC.txt'; do
head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_puncorrected0.05_GOannotation_$file
awk -F '\t' '$7 < 0.05' $filelocation/GOannotation/table_GOannotation_$file | awk -F '\t' '$8 < 4 && $8>2' >> $filelocation/GOannotation/table_puncorrected0.05_GOannotation_$file; done

head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_p0.05_depth3_collated.txt
for files in table_p*.txt; do
	awk -F '\t' -v info=$files '{print info, $0}' $files >> $filelocation/GOannotation/table_p0.05_depth3_collated.txt; done

# open excel and do final checks and modifications
# run R to visualise key molecular processes.