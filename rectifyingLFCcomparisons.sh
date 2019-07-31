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
mkdir $filelocation/GOannotation
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
for file in genes*.txt; do
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/$file /Users/rbadgami/Desktop/data2/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/data2/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $filelocation/GOannotation/GOannotation_$file &&
tail -n +21 $filelocation/GOannotation/GOannotation_$file | sed 's/^[^G]*G/G/' > $filelocation/GOannotation/table_GOannotation_$file &&
head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file
awk -F '\t' '$13 < 0.05' $filelocation/GOannotation/table_GOannotation_$file | awk -F '\t' '$8 < 4 && $8>2' >> $filelocation/GOannotation/table_pfdr0.05_GOannotation_$file; done

cd $filelocation/GOannotation
for file in 'genes_rectifyingLFCerror_1dpi_SAupreg_LFC.txt' 'genes_rectifyingLFCerror_3dpi_SAupreg_LFC.txt'; do
head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_puncorrected0.05_GOannotation_$file
awk -F '\t' '$7 < 0.05' $filelocation/GOannotation/table_GOannotation_$file | awk -F '\t' '$8 < 4 && $8>2' >> $filelocation/GOannotation/table_puncorrected0.05_GOannotation_$file; done

head -1 $filelocation/GOannotation/table_GOannotation_$file > $filelocation/GOannotation/table_p0.05_depth3_collated.txt
for files in table_p*.txt; do
	awk -F '\t' -v info=$files '{print info, $0}' $files >> $filelocation/GOannotation/table_p0.05_depth3_collated.txt; done

# open excel and do final checks and modifications
# run R to visualise key molecular processes.




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

