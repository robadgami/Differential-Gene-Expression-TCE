# Comparing F22_OA and F22_SA for GOannotations

OAlocation="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_table_pfdr0.05/OAonly"
SAlocation="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_table_pfdr0.05/SAonly"
g4SAlocation="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_table_pfdr0.05/1314_SAonly"
g4OAlocation="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_table_pfdr0.05/1314_OAonly"

GOcomparisonlocation="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA"

# I want to collate all level 2s for 1,3,7,11dpi F22_OA and F22_SA into a table for 'GO | NS | name | ratio_in_study | depth | p_fdr_bh | "ID"'
mkdir $GOcomparisonlocation


for time in "_1dpi" "_3dpi" "_7dpi" "_11dpi"; do
echo "GO	NS	name	ratio_in_study	depth	sp_fdr_bh	isolate_cultivar" > $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt
cat $OAlocation/table_pfdr0.05_GOannotation_F22$time\_OAonly.txt | awk -F '\t' -v isolate_cultivar='F22_OA' 'BEGIN{OFS="\t";}{print $1, $2, $4, $5, $8, $13, isolate_cultivar}' >> $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt;
cat $SAlocation/table_pfdr0.05_GOannotation_F22$time\_SAonly.txt | awk -F '\t' -v isolate_cultivar='F22_SA' 'BEGIN{OFS="\t";}{print $1, $2, $4, $5, $8, $13, isolate_cultivar}' >> $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt;
cat $g4SAlocation/table_pfdr0.05_GOannotation_1314$time\_SAonly.txt | awk -F '\t' -v isolate_cultivar='1314_SA' 'BEGIN{OFS="\t";}{print $1, $2, $4, $5, $8, $13, isolate_cultivar}' >> $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt;
cat $g4OAlocation/table_pfdr0.05_GOannotation_1314$time\_OAonly.txt | awk -F '\t' -v isolate_cultivar='1314_OA' 'BEGIN{OFS="\t";}{print $1, $2, $4, $5, $8, $13, isolate_cultivar}' >> $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt;
done

head -1 $GOcomparisonlocation/GOcomparison_F22_OAnSA_1dpi.txt > $GOcomparisonlocation/GOcomparison_F22_OAnSA_alltime.txt; for time in "_1dpi" "_3dpi" "_7dpi" "_11dpi"; do
tail -n +2 $GOcomparisonlocation/GOcomparison_F22_OAnSA$time.txt | awk -F '\t' -v time=$time 'BEGIN{OFS="\t";}{print $0, time}' >> $GOcomparisonlocation/GOcomparison_F22_OAnSA_alltime.txt;
done



### refined GO terms of interest
head -1 GOcomparison_F22_OAnSA_1dpi.txt > refined_GOcomparison_F22_OAnSA_1dpi.txt
while read line; do grep $line GOcomparison_F22_OAnSA_1dpi.txt >> refined_GOcomparison_F22_OAnSA_1dpi.txt; done < interest_1dpi.txt

head -1 $GOcomparisonlocation/GOcomparison_F22_OAnSA_1dpi.txt > $GOcomparisonlocation/refined_GOcomparison_F22_OAnSA_3dpi.txt
while read line; do grep $line $GOcomparisonlocation/GOcomparison_F22_OAnSA_3dpi.txt >> $GOcomparisonlocation/refined_GOcomparison_F22_OAnSA_3dpi.txt; done < $GOcomparisonlocation/interest_3dpi.txt

head -1 $GOcomparisonlocation/GOcomparison_F22_OAnSA_1dpi.txt > $GOcomparisonlocation/refined_GOcomparison_F22_OAnSA_7dpi.txt
while read line; do grep $line $GOcomparisonlocation/GOcomparison_F22_OAnSA_7dpi.txt >> $GOcomparisonlocation/refined_GOcomparison_F22_OAnSA_7dpi.txt; done < $GOcomparisonlocation/interest_7dpi.txt
