# need to make list of genes that are significantly different to control samples:
cd /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON
ls sig*.txt | while read line; do awk -F ' ' '{print $2}' $line| grep 'Traes' | sort > gene_lists/gene_$line; done

filelocationCON="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/gene_lists"
filelocationISO="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar"
filelocationBOTH="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR"


ls $filelocationCON/gene*.txt | cut -d"/" -f9 |cut -d"_" -f3-5 | cut -d"." -f1 | sort | uniq | while read line; do
cat $filelocationCON/*$line*.txt $filelocationISO/uniqgenes*$line*.txt | grep 'Traes' | sort | uniq -d > $filelocationBOTH/$line.txt; 
echo "________"$line"_______"; wc -l $filelocationCON/*$line*.txt; wc -l $filelocationISO/uniqgenes*$line*.txt; wc -l $filelocationBOTH/$line.txt; done

# now want to work out the criteriae for both:
ls $filelocationBOTH/*.txt | cut -d"/" -f12 |cut -d"." -f1 | cut -d"_" -f1-2 | sort | uniq | while read line; do
cat $filelocationBOTH/$line\_OA.txt $filelocationBOTH/$line\_SO.txt $filelocationBOTH/$line\_SA.txt | grep 'Traes' | sort | uniq > $filelocationBOTH/comparing_list/overall_$line.txt
cat $filelocationBOTH/$line\_OA.txt $filelocationBOTH/$line\_SO.txt | grep 'Traes' | sort | uniq -d > $filelocationBOTH/comparing_list/$line\_OAnSO.txt &&
cat $filelocationBOTH/$line\_OA.txt $filelocationBOTH/$line\_SA.txt | grep 'Traes' | sort | uniq -d > $filelocationBOTH/comparing_list/$line\_OAnSA.txt &&
cat $filelocationBOTH/$line\_SA.txt $filelocationBOTH/$line\_SO.txt | grep 'Traes' | sort | uniq -d > $filelocationBOTH/comparing_list/$line\_SOnSA.txt &&
cat $filelocationBOTH/comparing_list/$line\_OAnSO.txt $filelocationBOTH/comparing_list/$line\_OAnSA.txt $filelocationBOTH/comparing_list/$line\_SOnSA.txt  | grep 'Traes' | sort | uniq -d > $filelocationBOTH/comparing_list/$line\_OAnSOnSA.txt &&

cat $filelocationBOTH/comparing_list/$line\_OAnSOnSA.txt $filelocationBOTH/comparing_list/$line\_OAnSO.txt | grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_OAnSOonly.txt &&
cat $filelocationBOTH/comparing_list/$line\_OAnSOnSA.txt $filelocationBOTH/comparing_list/$line\_OAnSA.txt | grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_OAnSAonly.txt &&
cat $filelocationBOTH/comparing_list/$line\_OAnSOnSA.txt $filelocationBOTH/comparing_list/$line\_SOnSA.txt | grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_SOnSAonly.txt &&

cat $filelocationBOTH/$line\_OA.txt $filelocationBOTH/comparing_list/$line\_OAnSO.txt $filelocationBOTH/comparing_list/$line\_OAnSA.txt| grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_OAonly.txt &&
cat $filelocationBOTH/$line\_SO.txt $filelocationBOTH/comparing_list/$line\_OAnSO.txt $filelocationBOTH/comparing_list/$line\_SOnSA.txt| grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_SOonly.txt &&
cat $filelocationBOTH/$line\_SA.txt $filelocationBOTH/comparing_list/$line\_OAnSA.txt $filelocationBOTH/comparing_list/$line\_SOnSA.txt| grep 'Traes' | sort | uniq -u > $filelocationBOTH/comparing_list/$line\_SAonly.txt &&

echo "---------"$line"----------"
echo "criteria" "number_sigDEG"
echo "OA_only" $(wc -l $filelocationBOTH/comparing_list/$line\_OAonly.txt)
echo "OA_and_SO" $(wc -l $filelocationBOTH/comparing_list/$line\_OAnSOonly.txt)
echo "SO_only" $(wc -l $filelocationBOTH/comparing_list/$line\_SOonly.txt)
echo "SO_and_SA" $(wc -l $filelocationBOTH/comparing_list/$line\_SOnSAonly.txt)
echo "SA_only" $(wc -l $filelocationBOTH/comparing_list/$line\_SAonly.txt)
echo "OA_and_SA" $(wc -l $filelocationBOTH/comparing_list/$line\_OAnSAonly.txt)
echo "SO_and_SA_and_OA" $(wc -l $filelocationBOTH/comparing_list/$line\_OAnSOnSA.txt)
echo "overall"  $(wc -l $filelocationBOTH/comparing_list/overall_$line.txt); done

# get info on interesting peaks
mkdir $filelocationBOTH/comparing_list/GOannotation

conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
filelocation=$filelocationBOTH'/comparing_list'
file="F22_1dpi_SAonly.txt"
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/$file /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $filelocation/GOannotation/GOannotation_$file && tail -n +21 $filelocation/GOannotation/GOannotation_$file | sed 's/^[^G]*G/G/' > $filelocation/GOannotation/table_GOannotation_$file && awk -F '\t' '$13 < 0.01' $filelocation/GOannotation/table_GOannotation_$file > $filelocation/table_pfdr0.01_GOannotation_$file
awk -F '\t' '$13 < 0.05' $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file

# to do it for all criteriae
ls /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/F22*.txt | cut -d'/' -f13 | while read file; do
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/$file /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $filelocation/GOannotation/GOannotation_$file &&
tail -n +21 $filelocation/GOannotation/GOannotation_original/GOannotation_$file | head -1 > $filelocation/GOannotation/table_GOannotation_$file
tail -n +21 $filelocation/GOannotation/GOannotation_original/GOannotation_$file | sed 's/^[^G]*G/G/' | awk -F '\t' '$8 < 9 && $8>3' >> $filelocation/GOannotation/table_GOannotation_$file

head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_pfdr0.01_GOannotation_$file &&
awk -F '\t' '$13 < 0.01' $filelocation/GOannotation/table_GOannotation_$file >> $filelocation/GOannotation/table_pfdr0.01_GOannotation_$file
head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file
awk -F '\t' '$13 < 0.05' $filelocation/GOannotation/table_GOannotation_$file >> $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file

# find the cluster patterns that these genes assign to:
mkdir /Users/rbadgami/Desktop/data2/combine_sigCONsigISO_cluster
mkdir /Users/rbadgami/Desktop/data2/combine_sigCONsigISO_cluster/temp
filelocationCLUSTER="/Users/rbadgami/Desktop/data2/Cluster_matrix"
filelocationCOMBINE="/Users/rbadgami/Desktop/data2/combine_sigCONsigISO_cluster"

cat $filelocationBOTH/comparing_list/overall*F22*.txt | grep 'Traes' | sort | uniq | sed 's/$/=/' > $filelocationCOMBINE/temp/overall_F22.txt
cat $filelocationBOTH/comparing_list/overall*1314*.txt | grep 'Traes' | sort | uniq | sed 's/$/=/' > $filelocationCOMBINE/temp/overall_1314.txt
sed 's/00,/00=,/' $filelocationCLUSTER/final_cluster_matrix_F22.csv |  sed 's/00LC,/00LC=,/'> $filelocationCOMBINE/temp/final_cluster_matrix_F22.txt
sed 's/00,/00=,/' $filelocationCLUSTER/final_cluster_matrix_1314.csv |  sed 's/00LC,/00LC=,/'> $filelocationCOMBINE/temp/final_cluster_matrix_1314.txt

for isolate in "F22" "1314"; do
	head -1 $filelocationCOMBINE/temp/final_cluster_matrix_$isolate.txt > $filelocationCOMBINE/sigCONsigISO_clusters_$isolate.txt; while read line; do
		if grep -qw $line $filelocationCOMBINE/temp/final_cluster_matrix_$isolate.txt; then
			grep -w $line $filelocationCOMBINE/temp/final_cluster_matrix_$isolate.txt >> $filelocationCOMBINE/sigCONsigISO_clusters_$isolate.txt; else
			echo $line > $filelocationCOMBINE/notincluster_$isolate.txt;
		fi;
	done < $filelocationCOMBINE/temp/overall_$isolate.txt;
	wc -l $filelocationCOMBINE/temp/overall_$isolate.txt;
	wc -l $filelocationCOMBINE/sigCONsigISO_clusters_$isolate.txt;
	wc -l $filelocationCOMBINE/notincluster_$isolate.txt;
done

# find the clustering patterns for OA only samples:
$filelocationBOTH/comparing_list/F22_1dpi_OAonly.txt



