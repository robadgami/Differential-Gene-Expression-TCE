# get GO names for ALL F22 samples
awk '{print $1}' /Users/rbadgami/Desktop/GOenrichment/uniqsumGO_F22.txt > /Users/rbadgami/Desktop/GOenrichment/genesonly_uniqsumGO_F22.txt


#### To make matrix for study_count

uniqsumGOlocation="/Users/rbadgami/Desktop/GOenrichment"
sigGOlocation="/Users/rbadgami/Desktop/GOenrichment/table_GOassociation_F22_OA/sigfdr_table_F22_OA"

for file in "F22_OA_C0"  "F22_OA_C1" "F22_OA_C2" "F22_OA_C3" "F22_OA_C4" "F22_OA_C5" "F22_OA_C6" "F22_OA_C7" "F22_OA_C8" "F22_OA_C9" "F22_OA_C10" "F22_OA_C11" "F22_OA_C12" "F22_OA_C12" "F22_OA_C13" "F22_OA_C14" "F22_OA_C15"; do
	awk -F '\t' '{print $1, $9}' $sigGOlocation/GO_fdr_table_$file.txt > $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_$file.txt;
	while read line;do 
	if grep -qw $line $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_$file.txt;
	then grep -w $line $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_$file.txt >> $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_full_$file.csv;
	else echo $line "0" >> $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_full_$file.csv;
	fi; done < $uniqsumGOlocation/genesonly_uniqsumGO_F22.txt
	sort $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_GO_studycount_full_$file.csv | uniq > $uniqsumGOlocation/temp_matrix/temp_matrix_count/sorted_temp_GO_studycount_full_$file.csv;
	awk '{print $2}' $uniqsumGOlocation/temp_matrix/temp_matrix_count/sorted_temp_GO_studycount_full_$file.csv > $uniqsumGOlocation/temp_matrix/temp_matrix_count/studycount_$file.csv;
	rm $uniqsumGOlocation/temp_matrix/temp_matrix_count/temp_*
done
wc -l  $uniqsumGOlocation/temp_matrix/temp_matrix_count/studycount_
##### To make matrix for p-value(fdr_benjamini-Hochberg)

uniqsumGOlocation="/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr"
sigGOlocation="/Users/rbadgami/Desktop/GOenrichment/table_GOassociation_F22_OA/sigfdr_table_F22_OA"

for file in "F22_OA_C0"  "F22_OA_C1" "F22_OA_C2" "F22_OA_C3" "F22_OA_C4" "F22_OA_C5" "F22_OA_C6" "F22_OA_C7" "F22_OA_C8" "F22_OA_C9" "F22_OA_C10" "F22_OA_C11" "F22_OA_C12" "F22_OA_C12" "F22_OA_C13" "F22_OA_C14" "F22_OA_C15"; do
	awk -F '\t' '{print $1, $13}' $sigGOlocation/GO_fdr_table_$file.txt > $uniqsumGOlocation/temp_GO_studypfdr_$file.txt;
	cp /Users/rbadgami/Desktop/GOenrichment/uniqsumGO_F22.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_OA_pfdr.txt
	while read line;do 
	if grep -qw $line $uniqsumGOlocation/temp_GO_studypfdr_$file.txt;
	then grep -w $line $uniqsumGOlocation/temp_GO_studypfdr_$file.txt >> $uniqsumGOlocation/temp_GO_studypfdr_full_$file.csv;
	else echo $line "0" >> $uniqsumGOlocation/temp_GO_studypfdr_full_$file.csv;
	fi; done < /Users/rbadgami/Desktop/GOenrichment/genesonly_uniqsumGO_F22.txt
	sort $uniqsumGOlocation/temp_GO_studypfdr_full_$file.csv | uniq > $uniqsumGOlocation/sorted_temp_GO_studypfdr_full_$file.csv;
	awk '{print $2}' $uniqsumGOlocation/sorted_temp_GO_studypfdr_full_$file.csv > $uniqsumGOlocation/studypfdr_$file.csv;
	sed "s/p_fdr_bh/$file/" $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv;
	mv $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv $uniqsumGOlocation/studypfdr_$file.csv;
	rm $uniqsumGOlocation/temp_*
	awk -F '\t' '{getline f1 <"/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/total_matrix_F22_OA_pfdr.txt" ;print $0, f1}' OFS='\t' $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt;
	mv $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_OA_pfdr.txt
done
wc -l $uniqsumGOlocation/*

cp /Users/rbadgami/Desktop/GOenrichment/uniqsumGO_F22.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_OA_pfdr.txt
for file in "F22_OA_C0"  "F22_OA_C1" "F22_OA_C2" "F22_OA_C3" "F22_OA_C4" "F22_OA_C5" "F22_OA_C6" "F22_OA_C7" "F22_OA_C8" "F22_OA_C9" "F22_OA_C10" "F22_OA_C11" "F22_OA_C12" "F22_OA_C12" "F22_OA_C13" "F22_OA_C14" "F22_OA_C15"; do
	sed "s/p_fdr_bh/$file/" $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv;
	mv $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv $uniqsumGOlocation/studypfdr_$file.csv;
	awk -F '\t' '{getline f1 <"/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/total_matrix_F22_OA_pfdr.txt" ;print $0, f1}' OFS='\t' $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt;
	 mv $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_OA_pfdr.txt;
done


for file in "F22_OA_C0"  "F22_OA_C1" "F22_OA_C2" "F22_OA_C3" "F22_OA_C4" "F22_OA_C5" "F22_OA_C6" "F22_OA_C7" "F22_OA_C8" "F22_OA_C9" "F22_OA_C10" "F22_OA_C11" "F22_OA_C12" "F22_OA_C12" "F22_OA_C13" "F22_OA_C14" "F22_OA_C15"; do
	sed "s/p_fdr_bh/$file/" $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv;
	mv $uniqsumGOlocation/pfdr_matrix/formatrix_temp_pfdr_list_$file.csv $uniqsumGOlocation/studypfdr_$file.csv;
done

cp /Users/rbadgami/Desktop/GOenrichment/uniqsumGO_F22.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_pfdr.txt
#for file in "F22_OA_C0"  "F22_OA_C1" "F22_OA_C2" "F22_OA_C3" "F22_OA_C4" "F22_OA_C5" "F22_OA_C6" "F22_OA_C7" "F22_OA_C8" "F22_OA_C9" "F22_OA_C10" "F22_OA_C11" "F22_OA_C12" "F22_OA_C12" "F22_OA_C13" "F22_OA_C14" "F22_OA_C15"; do
paste $uniqsumGOlocation/studypfdr_$file.csv /Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/total_matrix_F22_pfdr.txt > $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt
#awk -F '\t' '{getline f1 <"/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/total_matrix_F22_OA_pfdr.txt" ;print $0, f1}' OFS=, $uniqsumGOlocation/studypfdr_$file.csv > $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt;
mv $uniqsumGOlocation/pfdr_matrix/temp_matrix.txt $uniqsumGOlocation/pfdr_matrix/total_matrix_F22_pfdr.txt
done

## Then, go to Rstudio to collate the overall matrix
