cd /Users/rbadgami/Desktop/kallisto_quant/DESeq2_control_pairwisedata/
# what are the duplicate lines
cat 1314_uniqGenes.txt F22_uniqGenes.txt | grep "Traes" | sort | uniq -d | wc -l
cat 1314_uniqGenes.txt F22_uniqGenes.txt | grep "Traes" | sort | uniq -d >duplicated_uniqGenes.txt
# there are 48257 duplicate genes

# what are genes unique to F22:
cat duplicated_uniqGenes.txt F22_uniqGenes.txt | grep "Traes" | sort | uniq -u | wc -l
cat duplicated_uniqGenes.txt F22_uniqGenes.txt | grep "Traes" | sort | uniq -u > uniq_F22_uniqGenes.txt
# there are 5055 unique-to-F22 genes


# GOterm annotation
# MAKE THE GOterm table
filelocation="/Users/rbadgami/Desktop/kallisto_quant/DESeq2_control_pairwisedata"
file="uniq_F22_uniqGenes.txt"
mkdir $filelocation/GOannotation
#in another terminal
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/$file /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $filelocation/GOannotation/association_$file &&
# make table by removing the first 21 lines and the dots before GO
tail -n +21 $filelocation/GOannotation/association_$file | sed 's/^[^G]*G/G/' > $filelocation/GOannotation/association_table_$file; done
# make table for pfdr<0.01
head -1 $filelocation/GOannotation/association_table_$file > $filelocation/GOannotation/association_table_pfdr0.05_$file &&
awk -F '\t' 'BEGIN{OFS="\t";} $13 < 0.01' $filelocation/GOannotation/association_table_$file >> $filelocation/GOannotation/association_table_pfdr0.05_$file

#make an excel file version of $filelocation/GOannotation/association_table_pfdr0.05_$file > this will be used to refine the GOannotation to what will be used in results.

# determine GOannotation
## go onto REVIGO.irb.hr and take GOterm and pfdr and see what comes up - remove from excel all that deemed inappropriate
mkdir $filelocation/GOannotation/GOannotation_grouping;
awk -F '\t' 'BEGIN{OFS="\t";}$8 > 2 && $8 < 9{print $14,$8 "|" $2 "|" $1	"|" $4}' $filelocation/GOannotation/association_table_pfdr0.05_$file | sort -k2n > $filelocation/GOannotation/GOannotation_grouping/temp_grouping_$file;
sort -r $filelocation/GOannotation/GOannotation_grouping/temp_grouping_$file | awk -F '\t' 'BEGIN{OFS="\t";}{a[$1]=a[$1]"\t"$2;} END {for (x in a) print x "\t" substr(a[x],2);}' | sort > $filelocation/GOannotation/GOannotation_grouping/grouping_$file;
rm $filelocation/GOannotation/GOannotation_grouping/temp_grouping_$file

# cluster groups based on 75% similar matching study_items(genes) list
cd GOannotation
GOfile="final_association_table_pfdr0.05_uniq_F22_uniqGenes.txt";
mkdir $filelocation/GOannotation/GOannotation_grouping/test;
count="0"; while read line; do
	count=`expr $count + 1`;
	echo $line | awk -F '\t' '{print $1}' | tr ", " "\n" | sed '/^$/d' | grep "Traes"  > $filelocation/GOannotation/GOannotation_grouping/test/array_$count.txt; done < $GOfile; 
echo $count

## find the percentage similarity.
cd $filelocation/GOannotation/GOannotation_grouping/test;
for comparer in array*.txt; do
for files in array*.txt;do
array1count='0';array2count='0';samevalue='0'; uniquevalue='0';fractionsimilar='0';
while read line; do
array1count=`expr $array1count + 1`
	while read value; do
	array2count=`expr $array2count + 1`;
	if [ $line == $value ]; then
	samevalue=`expr $samevalue + 1`;
	fi;
	done < $files;
done < $comparer; array2count=`expr $array2count / $array1count`; uniquevalue=`expr $array1count + $array2count - $samevalue` 
fractionsimilar=$(awk "BEGIN { pc=100*${samevalue}/${uniquevalue}; i=int(pc); print (pc-i<0.5)?i:i+1}");
echo $comparer $files $fractionsimilar | tr ' ' '\t' >> matrix.txt
echo $comparer $files $fractionsimilar
done;
echo "end $comparer"
rm $comparer
done
#make a list of all the array_*.txt names that have >=75% similarity
cat matrix.txt | tr ' ' '\t' | grep -v "100" | awk '!/0/' | awk '($3 > 74)' | sort -r  -k3n > matrix_sorted2.txt; cp matrix_sorted2.txt copy_matrix_sorted2.txt;
awk -F '\t' '{print $1}' copy_matrix_sorted2.txt | sort -u > temp2_list.txt
awk -F '\t' '{print $2}' copy_matrix_sorted2.txt | sort -u >> temp2_list.txt; sort -u temp2_list.txt > temp_list.txt; rm temp2_list.txt

# find the most similar and grep the first array:
# remove that $arr form the temp_list.txt and copy_matrix:
arr=$(head -1 temp_list.txt); grep $arr copy_matrix_sorted2.txt >> order_matrix_$arr; sed /$arr/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt; sed /$arr/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt
# grep all matching that and put into that array file:
cut -d$'\t' -f2 order_matrix_$arr | while read line; do
if grep -q $line copy_matrix_sorted2.txt; then
echo "---------"$line "still got matches--------";
grep $line copy_matrix_sorted2.txt >> order_matrix_$arr;
sed /$line/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt;
sed /$line/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt; fi
done && 
cut -d$'\t' -f1 order_matrix_$arr | while read line; do
if grep -q $line copy_matrix_sorted2.txt; then
echo "---------"$line "still got matches--------";
grep $line copy_matrix_sorted2.txt >> order_matrix_$arr; 
sed /$line/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt;
mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt;
sed /$line/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt; fi;
[ -s temp_list.txt ] || rm temp_list.txt;
done
##### I NEED A WAY TO BE ABLE TO TELL WHEN IT IS NO LONGER SHORTENING THE copy_matrix_sorted2.txt; then it goes back to the arr="..."

#### THEN I need a way for it to recognise that temp_list.txt is empty and remove it and stop the loops.

### THEN I WANT TO MAKE THE ARRAYS INTO LISTS.txt
for files in order_matrix_array*.txt; do
awk -F '\t' '{print $1}' $files | sort -u > temp_list_$files.txt
awk -F '\t' '{print $2}' $files | sort -u >> temp_list_$files.txt; sort -u temp_list_$files.txt > list_$files.txt; rm temp_list_$files.txt; done

