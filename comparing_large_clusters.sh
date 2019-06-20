cd /Users/rbadgami/Desktop/GOenrichment
mkdir comparing_clusters

clusterSA="C9"
clusterSO="C2"
clusterOA="C9"

awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/GO_sigfdr_table_F22_SA_$clusterSA.txt;
awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/GO_sigfdr_table_F22_SO_$clusterSO.txt;
awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/GO_sigfdr_table_F22_OA_$clusterOA.txt;

# make lists of GOterm clusters
head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt
cat comparing_clusters/GO_sigfdr_table_F22_*.txt | sort | uniq -c | grep "3 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt

head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_SA_$clusterSA.txt comparing_clusters/GO_sigfdr_table_F22_SO_$clusterSO.txt | sort | uniq -c | grep "2 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt
head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_SA_$clusterSA.txt comparing_clusters/GO_sigfdr_table_F22_OA_$clusterOA.txt | sort | uniq -c | grep "2 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt
head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_SO_$clusterSO.txt comparing_clusters/GO_sigfdr_table_F22_OA_$clusterOA.txt | sort | uniq -c | grep "2 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt

head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_1_GO_SA_$clusterSA.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt comparing_clusters/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_SA_$clusterSA.txt | sort | uniq -c | grep "1 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_1_GO_SA_$clusterSA.txt
head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_1_GO_SO_$clusterSO.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt comparing_clusters/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_SO_$clusterSO.txt | sort | uniq -c | grep "1 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_1_GO_SO_$clusterSO.txt
head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' '{print $1, $2, $8, $4}' | sed 's/^[^G]*G/G/' > comparing_clusters/ONLY_1_GO_OA_$clusterOA.txt
cat comparing_clusters/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt comparing_clusters/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt comparing_clusters/GO_sigfdr_table_F22_OA_$clusterOA.txt | sort | uniq -c | grep "1 GO" | sed 's/^[^G]*G/G/' >> comparing_clusters/ONLY_1_GO_OA_$clusterOA.txt

# open in excel, sort by depth, NS; filter by CC/BP/MF, write short description, save as excel - do for all ONLY_*.txt and concatenate all as sheets in an excel sheet.
mkdir comparing_clusters/Cluster5A_C9_C2_C9
mv comparing_clusters/*.txt comparing_clusters/Cluster5A_C9_C2_C9

#now do this for all the other Clusters of interest.
mkdir comparing_clusters_heatmap
## visualise via heatmaps
# FINAL CLUSTERS:
#clustergroup="Cluster1A_C0_C0_C0";clusterSA="C0"; clusterSO="C0"; clusterOA="C0"
#Cluster3A_C5_C11_C4
#Cluster1B_C6_C12_C6
#Cluster4A_C13_C6_NA
#Cluster2A_C14_NA_C14
#Cluster4B_SA_C15_OA_C5
#Cluster2B_NA_C5_C15	
#Cluster5A_C9_C2_C9
#Cluster2C_C7_C4_C7

### Now, to make a heatmap of the relevant GOterms for visualisation
#make list of all the GO terms associated with that grouping
echo "GO" > comparing_clusters_heatmap/temp_ONLY_genelist_$clustergroup.txt; awk -F ' ' '{print $1}' comparing_clusters/$clustergroup/GO_sigfdr_*.txt | sort | uniq >> comparing_clusters_heatmap/temp_ONLY_genelist_$clustergroup.txt


for files in comparing_clusters/$clustergroup/ONLY*OA*.txt; do
awk -F ' ' '{print $1}' $files | grep "GO:" | while read line; do
	grep -w $line table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | awk -F '\t' 'BEGIN { OFS="\t" } {print $1, "F22_OA", $2, $8, $13, $5, $9, $4}' | sed 's/^[^G]*G/G/' >> comparing_clusters_heatmap/temp_F22_OA_$clusterOA.txt; done; done

for files in comparing_clusters/$clustergroup/ONLY*SO*.txt; do
awk -F ' ' '{print $1}' $files | grep "GO:" | while read line; do
	grep -w $line table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | awk -F '\t' 'BEGIN { OFS="\t" } {print $1, "F22_OA", $2, $8, $13, $5, $9, $4}' | sed 's/^[^G]*G/G/' >> comparing_clusters_heatmap/temp_F22_SO_$clusterSO.txt; done; done

for files in comparing_clusters/$clustergroup/ONLY*SA*.txt; do
awk -F ' ' '{print $1}' $files | grep "GO:" | while read line; do
	grep -w $line table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | awk -F '\t' 'BEGIN { OFS="\t" } {print $1, "F22_OA", $2, $8, $13, $5, $9, $4}' | sed 's/^[^G]*G/G/' >> comparing_clusters_heatmap/temp_F22_SA_$clusterSA.txt; done; done

# now to make a large pile of it all:
cd comparing_clusters_heatmap
cat temp_ONLY_genelist_$clustergroup.txt | while read line; do if grep -qw $line temp_F22_OA_$clusterOA.txt; then grep -w $line temp_F22_OA_$clusterOA.txt; else echo $line "F22_OA"; fi; done | sort | uniq | sed 's/ F22_/	F22_/'> temp_final_F22_OA_$clusterOA.txt
cat temp_ONLY_genelist_$clustergroup.txt | while read line; do if grep -qw $line temp_F22_SO_$clusterSO.txt; then grep -w $line temp_F22_SO_$clusterSO.txt; else echo $line "F22_SO"; fi; done | sort | uniq | sed 's/ F22_/	F22_/'> temp_final_F22_SO_$clusterSO.txt
cat temp_ONLY_genelist_$clustergroup.txt | while read line; do if grep -qw $line temp_F22_SA_$clusterSA.txt; then grep -w $line temp_F22_SA_$clusterSA.txt; else echo $line "F22_SA"; fi; done | sort | uniq | sed 's/ F22_/	F22_/'> temp_final_F22_SA_$clusterSA.txt

cat temp_final_F22_OA_$clusterOA.txt temp_final_F22_SO_$clusterSO.txt temp_final_F22_SA_$clusterSA.txt > final_$clustergroup.txt

# onto Rstudio

