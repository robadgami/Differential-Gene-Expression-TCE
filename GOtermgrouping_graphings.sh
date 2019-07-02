cd /Users/rbadgami/Desktop/data2/GOenrichment
mkdir comparing_cluster_grouping

clusterSA="C15"
clusterSO="NA"
clusterOA="C5"

head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/GO_sigfdr_table_F22_SA_$clusterSA.txt;
awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' >> comparing_cluster_graphing/GO_sigfdr_table_F22_SA_$clusterSA.txt;
head -1 table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/GO_sigfdr_table_F22_SO_$clusterSO.txt;
awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_SO/sigfdr_table_F22_SO/sig_fdr_table_F22_SO_$clusterSO.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' >> comparing_cluster_graphing/GO_sigfdr_table_F22_SO_$clusterSO.txt
head -1 table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}'> comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt;
awk -F '\t' '$8 < 7 && $8>3'  table_GOassociation_F22_OA/sigfdr_table_F22_OA/sig_fdr_table_F22_OA_$clusterOA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}'>> comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt;


clusterSA="C9"
clusterSO="C2"
clusterOA="C9"
Gocategorylocation='/Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster5A_C9_C2_C9'
group="group10"
echo 'category|isolate_cultivar|' $(head -1 comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt) > comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
echo 'category|isolate_cultivar|' $(head -1 comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt) > comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
echo 'category|isolate_cultivar|' $(head -1 comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt) > comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_1_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_SA_$clusterSA.txt| tail -n +2 | while read line; do echo 'ONLY_1_SA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_1_GO_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_1_SO|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_OA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_SO|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SA_$clusterSA\_SO_$clusterSO.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SA_SO|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SO_OA|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_2_GO_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_2_GO_SO_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_OA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_OA_$clusterOA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_SO|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SO_$clusterSO.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt
awk -F ' ' '{print $1}' $Gocategorylocation/ONLY_3_GO_SA_$clusterSA\_SO_$clusterSO\_OA_$clusterOA.txt| tail -n +2 | while read line; do echo 'ONLY_3_GO_SA_SO_OA|F22_SA|' $(grep $line comparing_cluster_graphing/GOvalues/GO_sigfdr_table_F22_SA_$clusterSA.txt); done >> comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt


#awk -F '\t' '{print $4}' comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt | tail -n +2 | sort | uniq | while read line; do grep $line comparing_cluster_graphing/$group\_GO_sigfdr_table_F22_OA_$clusterOA\_SO_$clusterSO\_SA_$clusterSA.txt | awk -F '\t' 'BEGIN{OFS="\t";}{print $1, $2, $3, $4, $5, $6, $7}'; done > comparing_cluster_graphing/GOannotation.txt

# cd /Users/rbadgami/Desktop/data2/GOenrichment/comparing_cluster_graphing
#head -1 table_GOassociation_F22_SA/sigfdr_table_F22_SA/sig_fdr_table_F22_SA_$clusterSA.txt | sed 's/^[^G]*G/G/' | awk -F '\t' 'BEGIN{OFS="|";}{print $1, $2, $8, $5, $9, $13, $4}' > comparing_cluster_graphing/ONLY_1GO_OA_GO_sigfdr_table_F22_OA_$clusterSA.txt;
#awk -F ' ' '{print $1}' /Users/rbadgami/Desktop/data2/GOenrichment/comparing_clusters/Cluster1B_C6_C12_C6/ONLY_1_GO_OA_C6.txt | tail -n +2 | while read line; do grep $line comparing_cluster_graphing/GO_sigfdr_table_F22_OA_$clusterOA.txt >> comparing_cluster_graphing/ONLY_1GO_OA_GO_sigfdr_table_F22_OA_$clusterSA.txt