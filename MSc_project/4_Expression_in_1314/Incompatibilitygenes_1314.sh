# run .R script for DESeq2_SA.R to find total differentially expressed genes between F22 and 13/14-SA (where 13/14 is reference)
# Then find what happened to the incompatibility-related genes:
# LFC F22 vs 1314
echo 'dpi gene gene baseMean log2FoldChange stat pvalue padj'> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_LFC.txt
for dpi in '1dpi' '3dpi' '7dpi'; do
while read line; do 
echo $dpi  $line $(grep "$line " /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/sig_SA_$dpi\_F22v1314_shrunk.txt) | grep 'Traes' >> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_LFC.txt;
 done < /Users/rbadgami/Desktop/rectifyingLFCerror/genes_rectifyingLFCerror_$dpi\_SAupreg_LFC.txt; done
# LFC 1314_SAvsCON
 echo 'dpi gene gene baseMean log2FoldChange stat pvalue padj'> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_1314CON_LFC.txt
 for dpi in '1dpi' '3dpi' '7dpi'; do
while read line; do 
echo $dpi  $line $(grep "$line " /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_$dpi\_1314_SAvsCON_SA.txt) | grep 'Traes' >> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_1314CON_LFC.txt;
done < /Users/rbadgami/Desktop/rectifyingLFCerror/genes_rectifyingLFCerror_$dpi\_SAupreg_LFC.txt; done
# LFC Clusttpm
echo 'dpi gene isolate_cultivar gene2 1dpi 3dpi 7dpi 11dpi gene3 Cluster'> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_tpm.txt
 for dpi in '1dpi' '3dpi' '7dpi'; do
 	while read line; do 
 	echo $dpi  $line ' 1314_SA' $(grep $line /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_1314.csv | grep '1314_SA')  $(egrep "$line," /Users/rbadgami/Desktop/data2/Cluster_matrix/final_cluster_matrix_1314.csv | awk -F ',' '{print $4}' | tr -d '\n') >> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_tpm.txt; 
 	echo $dpi  $line ' F22_SA' $(grep $line /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_F22.csv | grep 'F22_SA') $(egrep "$line," /Users/rbadgami/Desktop/data2/Cluster_matrix/final_cluster_matrix_F22.csv| awk -F ',' '{print $4}' | tr -d '\n') >> /Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_tpm.txt
 done < /Users/rbadgami/Desktop/rectifyingLFCerror/genes_rectifyingLFCerror_$dpi\_SAupreg_LFC.txt; done

 # if its blank that implies the expression was the same bertween F22 and 13/14-infected SA.