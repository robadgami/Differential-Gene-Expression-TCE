mkdir /Users/rbadgami/Desktop/rectifyingLFCerror

comparisonSAvOA_SAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SAvOA_RES_SAupreg.txt"
comparisonSAvSO_SAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SAvSO_RES_SAupreg.txt"
comparisonSOvOA_SAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SOvOA"
comparisonCON_SAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_F22_SAvsCON_SA.txt"
head -1 $comparisonCON_SAupreg > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_LFC.txt;
head -1 /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_F22.csv> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_Clusttpm.txt;
head -1 /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/*.csv> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_Clusttpmgroup.txt;
head -1 /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_manual_normalisedcounts.csv > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_tpmvalues.txt;

tail +2 $comparisonSAvOA_SAupreg | awk -F ' ' '{print $2}' | grep 'Traes' | sort | uniq | while read gene; do
if grep -q $gene $comparisonCON_SAupreg && grep -q $gene $comparisonSAvOA_SAupreg && grep -q $gene $comparisonSAvSO_SAupreg; then
echo 'YES TO' $gene '!!!';
echo $gene "comparisonCON" $(grep $gene $comparisonCON_SAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_LFC.txt; 
echo $gene "comparisonSAvOA" $(grep $gene $comparisonSAvOA_SAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_LFC.txt;
echo $gene "comparisonSAvSO" $(grep $gene $comparisonSAvSO_SAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_LFC.txt;
echo $gene "comparisonSOvOA" $(grep $gene $comparisonSOvOA_SAupreg*.txt) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_LFC.txt;
echo $gene 'SA>SOxOA' $(grep $gene /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_F22.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_Clusttpm.txt;
echo $gene 'SA>SOxOA' $(grep $gene /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/*.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_Clusttpmgroup.txt;
echo $gene 'SA>SOxOA' $(grep $gene /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_manual_normalisedcounts.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_SAupreg_tpmvalues.txt; else
echo 'not' $gene;
fi; done

comparisonSAvOA_OAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SAvOA_SUS_OAupreg.txt"
comparisonSAvSO_OAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SAvSO"
comparisonSOvOA_OAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_F22_7dpi_SOvOA_SUS_OAupreg.txt"
comparisonCON_OAupreg="/Users/rbadgami/Desktop/data2/read_count_data/DESeq2_CON/sig_7dpi_F22_OAvsCON_OA.txt"
head -1 $comparisonCON_OAupreg > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_LFC.txt;
head -1 /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_F22.csv > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_Clusttpm.txt;
head -1 /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/*.csv > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_Clusttpmgroup.txt;
head -1 /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_manual_normalisedcounts.csv > /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_tpmvalues.txt;


tail +2 $comparisonSAvOA_OAupreg | awk -F ' ' '{print $2}' | grep 'Traes' | sort | uniq | while read gene; do
if grep -q $gene $comparisonSAvOA_OAupreg && grep -q $gene $comparisonSAvOA_OAupreg && grep -q $gene $comparisonSOvOA_OAupreg; then
echo 'YES TO' $gene '!!!';
echo $gene "comparisonCON" $(grep $gene $comparisonCON_OAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_LFC.txt; 
echo $gene "comparisonSAvOA" $(grep $gene $comparisonSAvOA_OAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_LFC.txt;
echo $gene "comparisonSAvSO" $(grep $gene $comparisonSAvSO_OAupreg*.txt) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_LFC.txt;
echo $gene "comparisonSOvOA" $(grep $gene $comparisonSOvOA_OAupreg) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_LFC.txt;
echo $gene 'SAxSO<OA' $(grep $gene /Users/rbadgami/Desktop/data2/Cluster_matrix/final_Clust_pattern_F22.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_Clusttpm.txt;
echo $gene 'SAxSO<OA' $(grep $gene /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/*.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_Clusttpmgroup.txt;
echo $gene 'SAxSO<OA' $(grep $gene /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_manual_normalisedcounts.csv) >> /Users/rbadgami/Desktop/rectifyingLFCerror/rectifyingLFCerror_7dpi_OAupreg_tpmvalues.txt; else
echo 'not' $gene;
fi;
done

filelocation='/Users/rbadgami/Desktop/rectifyingLFCerror'
cd $filelocation
for file in rectifyingLFCerror_*LFC.txt; do
awk -F ' ' '{print $1}' $file | grep 'Traes' | sort | uniq > $filelocation/genes_$file; done



# go through and check the genes are as expected.
# repeat for other dpi, then make .txt file for genes.