cd /Users/rbadgami/Desktop/data2/GOenrichment
mkdir comparing_cluster_grouping
GOenrichmentlocation="/Users/rbadgami/Desktop/data2/GOenrichment"

# clusterSA="C0"; clusterSO="C0"; clusterOA="C0"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1A_C0_C0_C0'; group="group3"
# clusterSA="C6"; clusterSO="C12"; clusterOA="C6"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1B_C6_C12_C6'; group="group1"
# clusterSA="C14"; clusterSO="NA"; clusterOA="C12"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2A_C14_NA_C12'; group="group2"
# clusterSA="NA"; clusterSO="C15"; clusterOA="C5"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2B_NA_C15_C5'; group="group4"
# clusterSA="C7"; clusterSO="C4"; clusterOA="C7"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2C_C7_C4_C7'; group="group5"
# clusterSA="C5"; clusterSO="C11"; clusterOA="C5"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster3A_C5_C11_C5'; group="group9"

# clusterSA="C13"; clusterSO="C6"; clusterOA="NA"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster4A_C13_C6_NA'; group="group6"
# clusterSA="C15"; clusterSO="NA"; clusterOA="C5"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster4B_C15_NA_C5'; group="group8"
# clusterSA="C9"; clusterSO="C2"; clusterOA="C9"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster5A_C9_C2_C9'; group="group10"
# clusterSA="C3"; clusterSO="C9"; clusterOA="C2"; group="group11"

#group='group1'; COA="C6:F22_OA"; CSO="C12:F22_SO"; CSA="C6:F22_SA"
#group='group2'; COA="C12:F22_OA"; CSO="noSOhere"; CSA="C14:F22_SA"
#group='group3'; COA="C0:F22_OA"; CSO="C0:F22_SO"; CSA="C0:F22_SA"
#group='group4'; COA="C15:F22_OA"; CSO="C5:F22_SO"; CSA="noSAhere"
#group='group5'; COA="C7:F22_OA"; CSO="C4:F22_SO"; CSA="C7:F22_SA"
#group='group6'; COA="noOAhere"; CSO="C6:F22_SO"; CSA="C13:F22_SA"
#group='group7'; COA="noOAhere"; CSO="noSOhere"; CSA="C12:F22_SA"
#group='group8'; COA="C5:F22_OA"; CSO="noSOhere"; CSA="C15:F22_SA"
#group='group9'; COA="C4:F22_OA"; CSO="C11:F22_SO"; CSA="C5:F22_SA"
#group='group10'; clusterOA="C9"; clusterSO="C2"; clusterSA="C9"
group='group11'; clusterOA="C2"; clusterSO="C9"; clusterSA="C3"
group='group12'; clusterOA="C1"; clusterSO="C7"; clusterSA="C1"
group='group13'; clusterOA="C8"; clusterSO="C3"; clusterSA="NA"
group='group14'; clusterOA="C10"; clusterSO="NA"; clusterSA="C10"
group='group15'; clusterOA="C4"; clusterSO="C10"; clusterSA="C4"
group='group16'; clusterOA="C13"; clusterSO="C8"; clusterSA="C2"
group='group17'; clusterOA="C14"; clusterSO="C13"; clusterSA="NA"
group='group18'; clusterOA="NA"; clusterSO="C1"; clusterSA="C11"
group='group19'; clusterOA="C11"; clusterSO="C15"; clusterSA="NA"


head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/GO_sigfdr_table_F22_SA_$clusterSA.txt;awk -F '\t' '$8 < 4 && $8>1'  table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' >> comparing_cluster_graphing/GO_sigfdr_table_F22_SA_$clusterSA.txt;head -1 table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/GO_sigfdr_table_F22_SO_$clusterSO.txt;awk -F '\t' '$8 < 4 && $8>1'  table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' >> comparing_cluster_graphing/GO_sigfdr_table_F22_SO_$clusterSO.txt;head -1 table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}'> comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt;awk -F '\t' '$8 < 4 && $8>1'  table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}'>> comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt;


#echo 'category|isolate_cultivar| GO|NS|depth|ratio_in_study|study_count|p_fdr_bh|name' > comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_1_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05' >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_SA_$clusterSA.txt| tail -n +2 | while read line; do echo 'ONLY_1_SA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_1_SO|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_OA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_SO|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_SO|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SO_OA|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SO_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt ;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt;
#awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done | awk -F '|' 'BEGIN{OFS="|";} $8<0.05'>> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt


# clusterSA="C0"; clusterSO="C0"; clusterOA="C0"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1A_C0_C0_C0'; group="group3"
# clusterSA="C6"; clusterSO="C12"; clusterOA="C6"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1B_C6_C12_C6'; group="group1"
# clusterSA="C14"; clusterSO="NA"; clusterOA="C12"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2A_C14_NA_C12'; group="group2"
# clusterSA="NA"; clusterSO="C15"; clusterOA="C5"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2B_NA_C15_C5'; group="group4"
# clusterSA="C7"; clusterSO="C4"; clusterOA="C7"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster2C_C7_C4_C7'; group="group5"
# clusterSA="C5"; clusterSO="C11"; clusterOA="C4"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster3A_C5_C11_C5'; group="group9"
# clusterSA="C12"; clusterSO="NA"; clusterOA="NA"
# clusterSA="C13"; clusterSO="C6"; clusterOA="NA"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster4A_C13_C6_NA'; group="group6"
# clusterSA="C15"; clusterSO="NA"; clusterOA="C5"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster4B_C15_NA_C5'; group="group8"
# clusterSA="C9"; clusterSO="C2"; clusterOA="C9"; Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster5A_C9_C2_C9'; group="group10"


# alternatively, just to sort out clustering later:
echo 'GO|NS|depth|ratio_in_study|study_count|p_fdr_bh|name|isolate_cultivar' > $GOenrichmentlocation/comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt;awk -F '\t' '$8 < 4 && $8>1 && $13<0.05'  $GOenrichmentlocation/table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' -v sample='F22_SA' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4,sample}' >> $GOenrichmentlocation/comparing_cluster_graphing/$group\_GO_sigfdr_taGO_sigfdr_table_F22_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt; awk -F '\t' '$8 < 4 && $8>1 && $13<0.05'  $GOenrichmentlocation/table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | sed 's/^[^G]*G/G/' | awk -F '\t' -v sample='F22_SO' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4,sample}' >> $GOenrichmentlocation/comparing_cluster_graphing/$group\_GO_sigfdr_taGO_sigfdr_table_F22_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt; awk -F '\t' '$8 < 4 && $8>1 && $13<0.05'  table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' -v sample='F22_OA' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4,sample}' >> comparing_cluster_graphing/$group\_GO_sigfdr_taGO_sigfdr_table_F22_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt

# open only want depth 2:
mkdir comparing_cluster_graphing/depth2
for files in /Users/rbadgami/Desktop/data2/GOenrichment/comparing_cluster_graphing/group*.txt; do
	head -1 $files > comparing_cluster_graphing/depth2_$files; awk -F '|' 'BEGIN{OFS="|";} $5==2' $files > /Users/rbadgami/Desktop/data2/GOenrichment/comparing_cluster_graphing/depth2_$files;
done









#awk -F '\t' '{print $4}' comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt | tail -n +2 | sort | uniq | while read line; do grep $line comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt | awk -F '\t' 'BEGIN{OFS="\t";}{print $1, $2, $3, $4, $5, $6, $7}'; done > comparing_cluster_graphing/GOannotation.txt

# cd /Users/rbadgami/Desktop/data2/GOenrichment/comparing_cluster_graphing
#head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/ONLY_1GO_OA_GO_sigfdr_table_F22_OA_$clusterSA.txt;
#awk -F ' ' '{print $1}' /Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1B_C6_C12_C6/ONLY_1_GO_OA_C6.txt | tail -n +2 | while read line; do grep $line comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt >> comparing_cluster_graphing/ONLY_1GO_OA_GO_sigfdr_table_F22_OA_$clusterSA.txt