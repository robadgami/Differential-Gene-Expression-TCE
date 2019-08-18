awk -F ',' '{print $1}' cluster_original_1314_SA.csv > genelist_1314_SA_C0.txt
awk -F ',' '{print $2}' cluster_original_1314_SA.csv > genelist_1314_SA_C1.txt
awk -F ',' '{print $3}' cluster_original_1314_SA.csv > genelist_1314_SA_C2.txt
awk -F ',' '{print $4}' cluster_original_1314_SA.csv > genelist_1314_SA_C3.txt
awk -F ',' '{print $5}' cluster_original_1314_SA.csv > genelist_1314_SA_C4.txt
awk -F ',' '{print $6}' cluster_original_1314_SA.csv > genelist_1314_SA_C5.txt
awk -F ',' '{print $7}' cluster_original_1314_SA.csv > genelist_1314_SA_C6.txt
awk -F ',' '{print $8}' cluster_original_1314_SA.csv > genelist_1314_SA_C7.txt
awk -F ',' '{print $9}' cluster_original_1314_SA.csv > genelist_1314_SA_C8.txt
awk -F ',' '{print $10}' cluster_original_1314_SA.csv > genelist_1314_SA_C9.txt
awk -F ',' '{print $11}' cluster_original_1314_SA.csv > genelist_1314_SA_C10.txt
awk -F ',' '{print $12}' cluster_original_1314_SA.csv > genelist_1314_SA_C11.txt
awk -F ',' '{print $13}' cluster_original_1314_SA.csv > genelist_1314_SA_C12.txt

for i in genelist_1314_SA*.txt; do
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $i /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $GOannotationlocation/association_$i &&
echo $i "done"
tail -n +21 $GOannotationlocation/association_$i | sed 's/^[^G]*G/G/' > $GOannotationlocation/GOannotation_table/association_table-$i &&
head -1 $GOannotationlocation/GOannotation_table/association_table-$i > $GOannotationlocation/GOannotation_table_pfdr0.01/pfdr0.01_table-$i &&
awk -F '\t' '$13 < 0.01' $GOannotationlocation/GOannotation_table/association_table-$i >> $GOannotationlocation/GOannotation_table_pfdr0.01/pfdr0.01_table-$i;
done

mkdir GOannotation_grouping; for files in pfdr0.01_table-*.txt; do
	awk -F '\t' 'BEGIN{OFS="\t";}$8 > 2 && $8 < 9{print $14,$8 "|" $2 "|" $1	"|" $4}' $files | sort -k2n >> GOannotation_grouping/temp_grouping_$files;
	echo "study_items"	"GOannotation" > GOannotation_grouping/grouping_$files;
	sort -r GOannotation_grouping/temp_grouping_$files | awk -F '\t' 'BEGIN{OFS="\t";}{a[$1]=a[$1]"\t"$2;} END {for (x in a) print x "\t" substr(a[x],2);}' | sort >> GOannotation_grouping/grouping_$files; rm GOannotation_grouping/temp_grouping_$files
done
#remove all  empty files
for files in GOannotation_grouping/grouping_*.txt; do
	echo $files >> empty_grouping.txt; [ -s $files ] || rm $files; done

cd GOannotation_grouping
mkdir test
cd test

file=$(ls *.txt); count='0';while read line; do count=`expr $count + 1`; echo $line | awk -F '\t' '{print $1}' | tr ", " "\n" | sed '/^$/d' | grep "Traes"  > array$count.txt; done < $file; 
echo $count