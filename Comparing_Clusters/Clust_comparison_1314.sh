filelocation="/Users/rbadgami/Desktop/data2/Cluster_matrix"

#### FOR each sample ####
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_1314_OA.tsv $filelocation/cluster_data/cluster_original_1314_OA.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_1314_SA.tsv $filelocation/cluster_data/cluster_original_1314_SA.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_1314_SA.tsv $filelocation/cluster_data/cluster_original_1314_SA.tsv

# also copy the processed cluster datapoints for each sample as excel in $filelocation
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/1314_OA_processed.tsv $filelocation/cluster_data/1314_OA_processed.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/1314_SO_processed.tsv $filelocation/cluster_data/1314_SO_processed.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/1314_SA_processed.tsv $filelocation/cluster_data/1314_SA_processed.tsv


# MANUALLY open in excel and save as .csv

echo "Genes,Cluster:Sample" > $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $1, ",C0:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $2, ",C1:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $3, ",C2:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $4, ",C3:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $5, ",C4:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $6, ",C5:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $7, ",C6:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $8, ",C7:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $9, ",C8:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $10, ",C9:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $11, ",C10:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
awk -F ',' '{print $12, ",C11:1314_SA"}' $filelocation/cluster_data/cluster_original_1314_SA.csv >> $filelocation/cluster_matrix_1314_SA.txt
# I had trouble with last column so added this one separately:
awk -F ',' '{print $13}' $filelocation/cluster_data/cluster_original_1314_SA.csv > $filelocation/cluster_matrix_1314_SA_C12.csv
# MANUALLY add C15:1314_SA, a space after gene and convert to .txt format
sed 's/00,/00 ,/g' $filelocation/cluster_matrix_1314_SA_C12.csv | sed 's/LC,/LC ,/g' > $filelocation/cluster_matrix_1314_SA_C12.txt


awk '{print $0}' $filelocation/cluster_matrix_1314_SA_C12.txt >> $filelocation/cluster_matrix_1314_SA.txt &&
sort -u $filelocation/cluster_matrix_1314_SA.txt  > $filelocation/noblank_cluster_matrix_1314_SA.txt
# manually remove all non-gene-containing columns and check length is as expected.

rm $filelocation/cluster_matrix_1314_SA_C12.csv
rm $filelocation/cluster_matrix_1314_SA_C12.txt
rm $filelocation/cluster_matrix_1314_SA.txt
#### FIN ####

# check total number genes is as expected:
wc -l $filelocation/noblank_cluster_matrix_1314_*.txt


##### Make list clust genes within 1314 ####
for sample in "1314_OA" "1314_SO" "1314_SA"; do
cat $filelocation/noblank_cluster_matrix_$sample\.txt >> $filelocation/temp_noblank_matrix_1314.txt; done
awk -F ',' '{print $1}' $filelocation/temp_noblank_cluster_matrix_1314.txt | sort | uniq > $filelocation/final_noblank_cluster_matrix_1314.txt
# check length is as expected
rm $filelocation/temp_noblank_cluster_matrix_1314.txt

#####FIN #####

###MAKE CLUSTER MATRIX ####
for sample in "1314_OA" "1314_SO" "1314_SA"; do
while read line; do
if grep -qw $line $filelocation/noblank_cluster_matrix_$sample\.txt;
then echo $(grep -w $line $filelocation/noblank_cluster_matrix_$sample\.txt) >> $filelocation/final_cluster_matrix_$sample\.csv;
else echo $line ,"NA:"$sample >> $filelocation/final_cluster_matrix_$sample\.csv;
fi;
done < $filelocation/final_noblank_cluster_matrix_1314.txt;
done
# check final_cluster_matrix_$sample.txt same length as sorted_noblank_cluster_matrix_1314.txt
wc -l $final_noblank_cluster_matrix_1314.txt
wc -l $final_cluster_matrix_1314_*.csv
## MERGE IN R ##
library(readr)
final_cluster_matrix_1314_OA <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_1314_OA.csv")
colnames(final_cluster_matrix_1314_OA)
final_cluster_matrix_1314_SA <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_1314_SA.csv")
colnames(final_cluster_matrix_1314_SA)
final_cluster_matrix_1314_SO <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_1314_SO.csv")
colnames(final_cluster_matrix_1314_SO)
final_cluster_matrix_1314 <- data.frame(final_cluster_matrix_1314_OA$Genes, final_cluster_matrix_1314_OA$`Cluster:Sample`,
                                        final_cluster_matrix_1314_SO$`Cluster:Sample`,
                                        final_cluster_matrix_1314_SA$`Cluster:Sample`)
colnames(final_cluster_matrix_1314) <- c("Genes", "Cluster:1314_OA", "Cluster:1314_SO", "Cluster:1314_SA")
write_csv(final_cluster_matrix_1314, "~/Desktop/data2/Cluster_matrix/final_cluster_matrix_1314.csv")

### FIN ####

for sample in "1314_OA" "1314_SO" "1314_SA"; do
rm /Users/rbadgami/Desktop/data2/Cluster_matrix/final_cluster_matrix_$sample\.csv;done

#### WORK OUT GENE COUNT FOR EACH COMPARATIVE CLUST PATTERN #####
head -1 $filelocation/final_cluster_matrix_1314.csv > $filelocation/final_cluster_matrix_1314_genecount.csv &&
awk -F ',' 'BEGIN{OFS=",";}{print $2, $3, $4}' $filelocation/final_cluster_matrix_1314.csv | sort | uniq -c | sort -r | sed 's/ /,/g' >> $filelocation/final_cluster_matrix_1314_genecount.csv
#manually sort the count list so it appears in columns


##### IMPROVED GENE IDENTIFICATION ####
### add '=' to cluster matrix ###
sed 's/00,/00=,/' $filelocation/final_cluster_matrix_1314.csv > $filelocation/identification_final_cluster_matrix_1314.csv
### and to clust datapoints SO ONLY obtain datapoints for genes within a cluster ####


for sample in "1314_OA" "1314_SO" "1314_SA"; do
	sed 's/00,/00=,/' $filelocation/cluster_data/$sample\_processed.csv | sed "s/Traes/"$sample",Traes/" | sed "s/Gene/Cluster:Sample,Gene/"> $filelocation/temp_final_Clustpattern_$sample\.csv &&
	sed 's/00 ,/00=,/' $filelocation/noblank_cluster_matrix_$sample\.txt > $filelocation/temp_noblank_cluster_matrix_$sample\.txt &&
	awk -F ',' '{print $1}' $filelocation/temp_noblank_cluster_matrix_$sample\.txt | while read line; do
		grep -e $line $filelocation/temp_final_Clustpattern_$sample\.csv >> $filelocation/temp_final_final_Clust_pattern_$sample\.csv;
	done;
	wc -l $filelocation/temp_noblank_cluster_matrix_$sample\.txt;
	wc -l $filelocation/temp_final_final_Clust_pattern_$sample\.csv;
done

# if length is as expecte then concatenate the within-cluster-datapoints into one large file
echo "Cluster:Sample,Genes,01dpi,03dpi,07dpi,11dpi" > $filelocation/identification_final_Clust_pattern_1314.csv &&
for sample in "1314_OA" "1314_SO" "1314_SA"; do tail -n +2 $filelocation/temp_final_final_Clust_pattern_$sample\.csv | cat >> $filelocation/identification_final_Clust_pattern_1314.csv; done &&
wc -l $filelocation/temp_final_final_Clust_pattern_1314_*.csv
wc -l $filelocation/identification_final_Clust_pattern_1314.csv
# identification_final_Clust_pattern_1314.csv should be sum(temp_final_final_Clust_pattern_1314_*.csv)-2
sed 's/00=,/00 ,/' $filelocation/identification_final_Clust_pattern_1314.csv > $filelocation/final_Clust_pattern_1314.csv


rm $filelocation/temp_*.csv
rm $filelocation/temp_*.txt


##### SPECIFIC PATTERN CLUST DATAPOINTS #####
mkdir $filelocation/1314_temp_genelist
# to do individual clustdata:
#grep -e "NA:1314_OA,C2:1314_SO,NA:1314_SA" $filelocation/identification_final_cluster_matrix_1314.csv | awk -F ',' '{print $1}' | while read line; do
# grep -e $line /Users/rbadgami/Desktop/data2/Cluster_matrix/identification_final_Clust_pattern_1314.csv >> $filelocation/clustergraph/NA-1314_OA_C2-1314_SO_NA-1314_SA.csv; done
# to do group clustdata:
# get the datapoints for first 89 patterns
#head -n 90 temp_patternquotation.csv
# manually add " at start and end of line and make list into string to put after 'for i in '

# I want to see what the genes from the comparative cluster patterns in F22 look like in 1314:
mkdir $filelocation/1314_temp_genelist/compared_to_F22_genes
for i in "NA:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,C12:F22_SO,C6:F22_SA" "C0:F22_OA,C0:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C10:F22_SO,NA:F22_SA" "NA:F22_OA,C0:F22_SO,NA:F22_SA" "NA:F22_OA,C4:F22_SO,C6:F22_SA" "C6:F22_OA,C12:F22_SO,C6:F22_SA" "NA:F22_OA,NA:F22_SO,C0:F22_SA" "NA:F22_OA,C4:F22_SO,NA:F22_SA" "NA:F22_OA,C0:F22_SO,C0:F22_SA" "NA:F22_OA,C9:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C6:F22_SA" "NA:F22_OA,C3:F22_SO,NA:F22_SA" "C0:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C7:F22_SO,C0:F22_SA" "C0:F22_OA,C0:F22_SO,C0:F22_SA" "NA:F22_OA,C1:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,NA:F22_SA" "C6:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,C7:F22_SO,NA:F22_SA" "NA:F22_OA,C5:F22_SO,NA:F22_SA" "C0:F22_OA,C0:F22_SO,C10:F22_SA" "NA:F22_OA,C3:F22_SO,C6:F22_SA" "C6:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,C1:F22_SA" "C0:F22_OA,C1:F22_SO,NA:F22_SA" "C10:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C1:F22_SA" "C0:F22_OA,NA:F22_SO,C0:F22_SA" "NA:F22_OA,C15:F22_SO,NA:F22_SA" "NA:F22_OA,C11:F22_SO,NA:F22_SA" "C3:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C9:F22_SO,C0:F22_SA" "C6:F22_OA,C10:F22_SO,NA:F22_SA" "C10:F22_OA,NA:F22_SO,NA:F22_SA"  "NA:F22_OA,NA:F22_SO,C12:F22_SA" "C3:F22_OA,C10:F22_SO,NA:F22_SA" "NA:F22_OA,C6:F22_SO,NA:F22_SA" "NA:F22_OA,C13:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C9:F22_SA" "C2:F22_OA,NA:F22_SO,NA:F22_SA" "C6:F22_OA,NA:F22_SO,C6:F22_SA" "C4:F22_OA,NA:F22_SO,NA:F22_SA" "C1:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C3:F22_SA" "NA:F22_OA,C0:F22_SO,C10:F22_SA" "NA:F22_OA,C7:F22_SO,C1:F22_SA" "NA:F22_OA,NA:F22_SO,C2:F22_SA" "NA:F22_OA,C10:F22_SO,C0:F22_SA" "C4:F22_OA,C9:F22_SO,NA:F22_SA" "C0:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C5:F22_SA" "C3:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C8:F22_SA" "C9:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C10:F22_SA" "NA:F22_OA,C9:F22_SO,C1:F22_SA" "NA:F22_OA,C2:F22_SO,C6:F22_SA" "NA:F22_OA,C10:F22_SO,C3:F22_SA" "NA:F22_OA,C2:F22_SO,C0:F22_SA" "NA:F22_OA,C10:F22_SO,C5:F22_SA" "C4:F22_OA,C10:F22_SO,NA:F22_SA" "C8:F22_OA,C3:F22_SO,C6:F22_SA" "NA:F22_OA,C4:F22_SO,C8:F22_SA" "NA:F22_OA,C10:F22_SO,C6:F22_SA" "NA:F22_OA,C1:F22_SO,C10:F22_SA" "C3:F22_OA,C12:F22_SO,C6:F22_SA" "NA:F22_OA,C2:F22_SO,C9:F22_SA" "C13:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C5:F22_SO,C8:F22_SA" "NA:F22_OA,C5:F22_SO,C6:F22_SA" "NA:F22_OA,C2:F22_SO,C8:F22_SA" "NA:F22_OA,C12:F22_SO,C4:F22_SA" "C12:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C8:F22_SO,NA:F22_SA" "C8:F22_OA,NA:F22_SO,NA:F22_SA" "C8:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C4:F22_SA" "NA:F22_OA,C15:F22_SO,C0:F22_SA" "NA:F22_OA,C3:F22_SO,C8:F22_SA" "C0:F22_OA,C0:F22_SO,C9:F22_SA" "C8:F22_OA,NA:F22_SO,C6:F22_SA" "C6:F22_OA,C10:F22_SO,C6:F22_SA" "C1:F22_OA,C0:F22_SO,NA:F22_SA" ; do
	# (1) grab the genes showing that pattern
	pattern=$(echo $i | sed 's/:/-/g' | sed 's/,/_/g' | sed 's/-/_/g')
	echo "Sample,Genes,1,3,7,11" > $filelocation/1314_temp_genelist/compared_to_F22_genes/clusterdata_1314_$pattern\.csv
	grep -e $i $filelocation/identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' > $filelocation/1314_temp_genelist/temp_pattern_genelist.csv &&
	# (2) find the Clust-derived datapoints for 1314
	while read line; do
		grep -e $line  $filelocation/identification_final_Clust_pattern_1314.csv >> $filelocation/1314_temp_genelist/compared_to_F22_genes/clusterdata_1314_$pattern\.csv;
	done < $filelocation/1314_temp_genelist/temp_pattern_genelist.csv;
done
rm $filelocation/1314_temp_genelist/temp_pattern_genelist.csv

# I want to see what the comparative cluster patterns look like for 1314:
mkdir $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314
# (1) lets look at the largest 112 patterns
head -113 $filelocation/final_cluster_matrix_1314_genecount.csv | tail -n +2  | awk -F "," 'BEGIN{OFS=",";}{print $2, $3, $4}' | sed 's/^/"/;s/1314_SA/1314_SA"/' | tr '\n' ' '> $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/temp_pattern.txt
# in sublime, make into a string

for i in "NA:1314_OA,C0:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C0:1314_SA" "C0:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,C4:1314_SO,C0:1314_SA" "C9:1314_OA,C4:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C1:1314_SO,NA:1314_SA" "C8:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,NA:1314_SO,C7:1314_SA" "C0:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,C0:1314_SO,NA:1314_SA" "NA:1314_OA,C2:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C0:1314_SA" "NA:1314_OA,NA:1314_SO,C3:1314_SA" "C0:1314_OA,C0:1314_SO,C6:1314_SA" "C11:1314_OA,NA:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C3:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C4:1314_SA" "C4:1314_OA,NA:1314_SO,NA:1314_SA" "C10:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C9:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C12:1314_SA" "C7:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C6:1314_SO,NA:1314_SA" "NA:1314_OA,C7:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C6:1314_SA" "NA:1314_OA,NA:1314_SO,C8:1314_SA" "C9:1314_OA,C5:1314_SO,NA:1314_SA" "C1:1314_OA,NA:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,NA:1314_SO,C9:1314_SA" "C2:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C11:1314_SO,NA:1314_SA" "C6:1314_OA,NA:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C6:1314_SA" "NA:1314_OA,C10:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C2:1314_SA" "NA:1314_OA,C0:1314_SO,C4:1314_SA" "C8:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,C13:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C11:1314_SA" "NA:1314_OA,C1:1314_SO,C3:1314_SA" "NA:1314_OA,C8:1314_SO,NA:1314_SA" "C9:1314_OA,C5:1314_SO,C10:1314_SA" "C3:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,NA:1314_SO,C4:1314_SA" "NA:1314_OA,C9:1314_SO,C7:1314_SA" "C8:1314_OA,C6:1314_SO,NA:1314_SA" "C9:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,C1:1314_SO,NA:1314_SA" "C5:1314_OA,C0:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C3:1314_SA" "C8:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,C10:1314_SA" "C9:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C2:1314_SO,C1:1314_SA" "C0:1314_OA,C0:1314_SO,C4:1314_SA" "NA:1314_OA,C1:1314_SO,C5:1314_SA" "C1:1314_OA,C0:1314_SO,NA:1314_SA" "C8:1314_OA,C4:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C11:1314_SO,C0:1314_SA" "C3:1314_OA,NA:1314_SO,C6:1314_SA" "C2:1314_OA,C1:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C9:1314_SO,C6:1314_SA" "NA:1314_OA,C3:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C0:1314_SA" "C9:1314_OA,C6:1314_SO,NA:1314_SA" "C8:1314_OA,C5:1314_SO,C10:1314_SA" "NA:1314_OA,C7:1314_SO,C7:1314_SA" "C5:1314_OA,C9:1314_SO,NA:1314_SA" "C0:1314_OA,C1:1314_SO,C5:1314_SA" "NA:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C1:1314_SA" "C8:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C0:1314_SA" "C4:1314_OA,C7:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C4:1314_SO,C1:1314_SA" "C4:1314_OA,NA:1314_SO,C8:1314_SA" "C10:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C7:1314_SA" "NA:1314_OA,C0:1314_SO,C7:1314_SA" "C1:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C6:1314_SO,C9:1314_SA" "C9:1314_OA,C11:1314_SO,NA:1314_SA" "C5:1314_OA,C2:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C12:1314_SA" "NA:1314_OA,C3:1314_SO,C1:1314_SA" "C9:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C11:1314_SA" "C4:1314_OA,NA:1314_SO,C7:1314_SA" "C1:1314_OA,C0:1314_SO,C5:1314_SA" "C10:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C7:1314_SO,C8:1314_SA" "C9:1314_OA,C3:1314_SO,NA:1314_SA" "C11:1314_OA,C4:1314_SO,NA:1314_SA" "C11:1314_OA,C2:1314_SO,NA:1314_SA"; do
	pattern=$(echo $i | sed 's/:/-/g' | sed 's/,/_/g' | sed 's/-/_/g')
	echo "Sample,Genes,1,3,7,11" > $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/clusterdata_1314_$pattern\.csv
	grep -e $i $filelocation/identification_final_cluster_matrix_1314.csv | awk -F ',' '{print $1}' > $filelocation/1314_temp_genelist/temp_pattern_genelist.csv &&
	# (2) find the Clust-derived datapoints for 1314
	while read line; do
		grep -e $line  $filelocation/identification_final_Clust_pattern_1314.csv >> $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/clusterdata_1314_$pattern\.csv;
	done < $filelocation/1314_temp_genelist/temp_pattern_genelist.csv;
done
rm $filelocation/1314_temp_genelist/temp_pattern_genelist.csv
# a long-form of this data is also made for use in R.
cd $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314
mkdir $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/long_data
for files in *.csv ; do
	echo 'Sample,Genes,dpi,value' > long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "01", $3}' $files | tail -n +2  >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "03", $4}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "07", $5}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "11", $6}' $files | tail -n +2 >> long_data/long_$files;
done

# build the R code for making the pdf file with these images:
cd $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/long_data

filelocation_longdata="$filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/long_data"
R_plotfile="Rplot_comparative_cluster_patterns_1314"

# write all the foreword for the Rplot
# load relevant packages
echo "library(readr)" > $filelocation_longdata/$R_plotfile.R &&
echo "library(reshape2)" >> $filelocation_longdata/$R_plotfile.R &&
echo "library(ggplot2)" >> $filelocation_longdata/$R_plotfile.R &&
echo "library(ggpubr)" >> $filelocation_longdata/$R_plotfile.R  &&
# read the files to make the relevant dataframes
echo "filenames <- list.files(path=\""$filelocation_longdata"\", pattern=\"long_clusterdata+.*csv\")" >> $filelocation_longdata/$R_plotfile.R &&
echo "names <- substr(filenames,18,nchar(filenames)-4)" >> $filelocation_longdata/$R_plotfile.R &&
echo "for(i in names){ filepath <- file.path(\""$filelocation_longdata"\",paste(\"long_clusterdata_\",i,\".csv\", sep=\"\"))" >> $filelocation_longdata/$R_plotfile.R &&
echo "assign(paste0(\"x\",i), read.delim(filepath, colClasses=c(rep(\"factor\",2),rep(\"numeric\",2)), sep=\",\"))}" >> $filelocation_longdata/$R_plotfile.R &&
echo "dataframes <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))" >> $filelocation_longdata/$R_plotfile.R  &&
# have an appropriate colourscheme for plots
echo "library(RColorBrewer)" >> $filelocation_longdata/$R_plotfile.R &&
echo "irisColors <- setNames( c(\"#A6CEE3\", \"#1F78B4\", \"#B2DF8A\", \"#33A02C\", \"#FB9A99\", \"#E31A1C\"), c(\"1314_SO\", \"F22_SO\", \"1314_SA\", \"F22_SA\", \"1314_OA\", \"F22_OA\"))" >> $filelocation_longdata/$R_plotfile.R &&
echo "plot.new()" >> $filelocation_longdata/$R_plotfile.R &&
echo "pdf(\""$filelocation_longdata/$R_plotfile".pdf\",height=11, width=8.5)" >> $filelocation_longdata/$R_plotfile.R &&
echo "plot.new()" >> $filelocation_longdata/$R_plotfile.R &&
# make a loop to make the plots
count="0" &&
for files in *.csv; do
	dataframe=$(echo $files | sed 's/^1314_/^x1314_/g' |sed 's/long_clusterdata_1314_/1314_/g' | sed 's/1314_SA.csv/1314_SA/g')
	pattern=$(echo $dataframe | sed 's/^1314_/"1314_/g' | sed 's/1314_OA_/1314_OAn/g' | sed 's/1314_SO_/1314_SOn/g' | sed 's/1314_SA/1314_SA/g')
	count=`expr $count + 1`
	echo "plot1314_"$count "<- ggplot() + geom_line(data=x"$dataframe", aes(x = dpi, y=value, lineshape = Genes, colour=Sample)) +ggtitle("$pattern"ngenes:"$(tail -n +2 $files | awk -F ',' 'BEGIN{OFS=",";}{print $2}' | sort -u | wc -l)"\") + theme(axis.title = element_text(size=8)) + xlab(\"days post-inoculation\") + ylab(\"Clust value\") + labs(fill = \"Sample\") +points(x=x"$dataframe"$dpi) + scale_x_continuous(breaks = c(1, 3, 7, 11)) + scale_colour_manual(values = irisColors)+ theme(legend.position = \"none\")" >> $filelocation_Rplot/$R_plotfile.R;
	if [ $count -eq 16 ]; then echo "ggarrange(plot1314_1, plot1314_2, plot1314_3, plot1314_4, plot1314_5, plot1314_6, plot1314_7, plot1314_8, plot1314_9, plot1314_10, plot1314_11, plot1314_12, plot1314_13, plot1314_14, plot1314_15, plot1314_16, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R;fi;
	if [ $count -eq 32 ]; then echo "ggarrange(plot1314_17, plot1314_18, plot1314_19, plot1314_20, plot1314_21, plot1314_22, plot1314_23, plot1314_24, plot1314_25, plot1314_26, plot1314_27, plot1314_28, plot1314_29, plot1314_30, plot1314_31, plot1314_32, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	if [ $count -eq 48 ]; then echo "ggarrange(plot1314_33, plot1314_34, plot1314_35, plot1314_36, plot1314_37, plot1314_38, plot1314_39, plot1314_40, plot1314_41, plot1314_42, plot1314_43, plot1314_44, plot1314_45, plot1314_46, plot1314_47, plot1314_48, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	if [ $count -eq 64 ]; then echo "ggarrange(plot1314_49, plot1314_50, plot1314_51, plot1314_52, plot1314_53, plot1314_54, plot1314_55, plot1314_56, plot1314_57, plot1314_58, plot1314_59, plot1314_60, plot1314_61, plot1314_62, plot1314_63, plot1314_64, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	if [ $count -eq 80 ]; then echo "ggarrange(plot1314_65, plot1314_66, plot1314_67, plot1314_68, plot1314_69, plot1314_70, plot1314_71, plot1314_72, plot1314_73, plot1314_74, plot1314_75, plot1314_76, plot1314_77, plot1314_78, plot1314_79, plot1314_80, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	if [ $count -eq 96 ]; then echo "ggarrange(plot1314_81, plot1314_82, plot1314_83, plot1314_84, plot1314_85, plot1314_86, plot1314_87, plot1314_88, plot1314_89, plot1314_90, plot1314_91, plot1314_92, plot1314_93, plot1314_94, plot1314_95, plot1314_96, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	if [ $count -eq 112 ]; then echo "ggarrange(plot1314_97, plot1314_98, plot1314_99, plot1314_100, plot1314_101, plot1314_102, plot1314_103, plot1314_104, plot1314_105, plot1314_106, plot1314_107, plot1314_108, plot1314_109, plot1314_110, plot1314_111, plot1314_112, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R; fi
	
done &&
echo "dev.off()" >> $filelocation_longdata/$R_plotfile.R
# open R, for '1314_OAn', 1314_SOn' change to 1314_OA\n', '1314_SOn', 
# 1314_OAn -> 1314_OA\n
# 1314_SOn -> 1314_SO\n
# ggtitle("1314_ -> ggtitle("
# ngenes: ->  \ngenes:


##########################################################################
######### MOVE TO R TO MAKE GRAPH ########################################
######### Use R_Script: ~/Desktop/data2/R_scripts2/Clustgraphs_1314.R##########
##########################################################################

##### GOannotation ####
mkdir $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/GOannotation
mkdir $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/GOannotation/GOannotation_table
mkdir $filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/GOannotation/GOannotation_table_pfdr0.01
clusterdatalocation="$filelocation/1314_temp_genelist/comparative_cluster_patterns_1314"
GOannotationlocation="$filelocation/1314_temp_genelist/comparative_cluster_patterns_1314/GOannotation"
#destinationlocation="/Users/rbadgami/Desktop/data2/Cluster_matrix/clustergraph/GOenrichment/output_GOenrichment"
#pattern="C0_1314_OA_C0_1314_SO_C9_1314_SA"
# get genelist for that pattern
for i in "NA:1314_OA,C0:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C0:1314_SA" "C0:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,C4:1314_SO,C0:1314_SA" "C9:1314_OA,C4:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C1:1314_SO,NA:1314_SA" "C8:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,NA:1314_SO,C7:1314_SA" "C0:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,C0:1314_SO,NA:1314_SA" "NA:1314_OA,C2:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C0:1314_SA" "NA:1314_OA,NA:1314_SO,C3:1314_SA" "C0:1314_OA,C0:1314_SO,C6:1314_SA" "C11:1314_OA,NA:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C3:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C4:1314_SA" "C4:1314_OA,NA:1314_SO,NA:1314_SA" "C10:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C9:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C12:1314_SA" "C7:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C6:1314_SO,NA:1314_SA" "NA:1314_OA,C7:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C6:1314_SA" "NA:1314_OA,NA:1314_SO,C8:1314_SA" "C9:1314_OA,C5:1314_SO,NA:1314_SA" "C1:1314_OA,NA:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,NA:1314_SO,C9:1314_SA" "C2:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C11:1314_SO,NA:1314_SA" "C6:1314_OA,NA:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C6:1314_SA" "NA:1314_OA,C10:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C2:1314_SA" "NA:1314_OA,C0:1314_SO,C4:1314_SA" "C8:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,C13:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C11:1314_SA" "NA:1314_OA,C1:1314_SO,C3:1314_SA" "NA:1314_OA,C8:1314_SO,NA:1314_SA" "C9:1314_OA,C5:1314_SO,C10:1314_SA" "C3:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,NA:1314_SO,C4:1314_SA" "NA:1314_OA,C9:1314_SO,C7:1314_SA" "C8:1314_OA,C6:1314_SO,NA:1314_SA" "C9:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,C1:1314_SO,NA:1314_SA" "C5:1314_OA,C0:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C3:1314_SA" "C8:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,C10:1314_SA" "C9:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C2:1314_SO,C1:1314_SA" "C0:1314_OA,C0:1314_SO,C4:1314_SA" "NA:1314_OA,C1:1314_SO,C5:1314_SA" "C1:1314_OA,C0:1314_SO,NA:1314_SA" "C8:1314_OA,C4:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C11:1314_SO,C0:1314_SA" "C3:1314_OA,NA:1314_SO,C6:1314_SA" "C2:1314_OA,C1:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C9:1314_SO,C6:1314_SA" "NA:1314_OA,C3:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C0:1314_SA" "C9:1314_OA,C6:1314_SO,NA:1314_SA" "C8:1314_OA,C5:1314_SO,C10:1314_SA" "NA:1314_OA,C7:1314_SO,C7:1314_SA" "C5:1314_OA,C9:1314_SO,NA:1314_SA" "C0:1314_OA,C1:1314_SO,C5:1314_SA" "NA:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C1:1314_SA" "C8:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C0:1314_SA" "C4:1314_OA,C7:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C4:1314_SO,C1:1314_SA" "C4:1314_OA,NA:1314_SO,C8:1314_SA" "C10:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C7:1314_SA" "NA:1314_OA,C0:1314_SO,C7:1314_SA" "C1:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C6:1314_SO,C9:1314_SA" "C9:1314_OA,C11:1314_SO,NA:1314_SA" "C5:1314_OA,C2:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C12:1314_SA" "NA:1314_OA,C3:1314_SO,C1:1314_SA" "C9:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C11:1314_SA" "C4:1314_OA,NA:1314_SO,C7:1314_SA" "C1:1314_OA,C0:1314_SO,C5:1314_SA" "C10:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C7:1314_SO,C8:1314_SA" "C9:1314_OA,C3:1314_SO,NA:1314_SA" "C11:1314_OA,C4:1314_SO,NA:1314_SA" "C11:1314_OA,C2:1314_SO,NA:1314_SA"; do
	pattern=$(echo $i | sed 's/:1314/_1314/;s/1314_OA,/1314_OA_/;s/:1314_SO,/_1314_SO_/;s/:1314_SA/_1314_SA/g');
	awk -F ',' 'BEGIN{OFS=",";}{print $2}' $clusterdatalocation/clusterdata_1314_$pattern\.csv | sed 's/=/ /g' | sort -u > $GOannotationlocation/temp_GOlist.txt && wc -l $GOannotationlocation/temp_GOlist.txt;
#in another terminal
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $GOannotationlocation/temp_GOlist.txt /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $GOannotationlocation/association_$pattern\.txt &&
# make table by removing the first 21 lines and the dots before GO
tail -n +21 $GOannotationlocation/association_$pattern\.txt | sed 's/^[^G]*G/G/' > $GOannotationlocation/GOannotation_table/association_table-$pattern\.txt; done
# make table to input into revigo containing "GO", "pfdr"(<0.01)
for i in "NA:1314_OA,C0:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C0:1314_SA" "C0:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,C4:1314_SO,C0:1314_SA" "C9:1314_OA,C4:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C1:1314_SO,NA:1314_SA" "C8:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,NA:1314_SO,C7:1314_SA" "C0:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,C0:1314_SO,NA:1314_SA" "NA:1314_OA,C2:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C0:1314_SA" "NA:1314_OA,NA:1314_SO,C3:1314_SA" "C0:1314_OA,C0:1314_SO,C6:1314_SA" "C11:1314_OA,NA:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C6:1314_SA" "C9:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C3:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C5:1314_SA" "NA:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C4:1314_SA" "C4:1314_OA,NA:1314_SO,NA:1314_SA" "C10:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C9:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C12:1314_SA" "C7:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C6:1314_SO,NA:1314_SA" "NA:1314_OA,C7:1314_SO,NA:1314_SA" "NA:1314_OA,C0:1314_SO,C6:1314_SA" "NA:1314_OA,NA:1314_SO,C8:1314_SA" "C9:1314_OA,C5:1314_SO,NA:1314_SA" "C1:1314_OA,NA:1314_SO,NA:1314_SA" "C9:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,NA:1314_SO,C9:1314_SA" "C2:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C11:1314_SO,NA:1314_SA" "C6:1314_OA,NA:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C6:1314_SA" "NA:1314_OA,C10:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C2:1314_SA" "NA:1314_OA,C0:1314_SO,C4:1314_SA" "C8:1314_OA,C5:1314_SO,NA:1314_SA" "NA:1314_OA,C13:1314_SO,NA:1314_SA" "NA:1314_OA,NA:1314_SO,C11:1314_SA" "NA:1314_OA,C1:1314_SO,C3:1314_SA" "NA:1314_OA,C8:1314_SO,NA:1314_SA" "C9:1314_OA,C5:1314_SO,C10:1314_SA" "C3:1314_OA,NA:1314_SO,NA:1314_SA" "NA:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,NA:1314_SO,C4:1314_SA" "NA:1314_OA,C9:1314_SO,C7:1314_SA" "C8:1314_OA,C6:1314_SO,NA:1314_SA" "C9:1314_OA,C4:1314_SO,C10:1314_SA" "C0:1314_OA,C1:1314_SO,NA:1314_SA" "C5:1314_OA,C0:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C3:1314_SA" "C8:1314_OA,NA:1314_SO,C10:1314_SA" "NA:1314_OA,C5:1314_SO,C10:1314_SA" "C9:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C2:1314_SO,C1:1314_SA" "C0:1314_OA,C0:1314_SO,C4:1314_SA" "NA:1314_OA,C1:1314_SO,C5:1314_SA" "C1:1314_OA,C0:1314_SO,NA:1314_SA" "C8:1314_OA,C4:1314_SO,NA:1314_SA" "C5:1314_OA,NA:1314_SO,C5:1314_SA" "NA:1314_OA,C11:1314_SO,C0:1314_SA" "C3:1314_OA,NA:1314_SO,C6:1314_SA" "C2:1314_OA,C1:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C9:1314_SO,C6:1314_SA" "NA:1314_OA,C3:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C0:1314_SA" "C9:1314_OA,C6:1314_SO,NA:1314_SA" "C8:1314_OA,C5:1314_SO,C10:1314_SA" "NA:1314_OA,C7:1314_SO,C7:1314_SA" "C5:1314_OA,C9:1314_SO,NA:1314_SA" "C0:1314_OA,C1:1314_SO,C5:1314_SA" "NA:1314_OA,C5:1314_SO,C0:1314_SA" "NA:1314_OA,C0:1314_SO,C1:1314_SA" "C8:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C0:1314_SA" "C4:1314_OA,C7:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C0:1314_SA" "NA:1314_OA,C4:1314_SO,C1:1314_SA" "C4:1314_OA,NA:1314_SO,C8:1314_SA" "C10:1314_OA,C4:1314_SO,NA:1314_SA" "C0:1314_OA,NA:1314_SO,C7:1314_SA" "NA:1314_OA,C0:1314_SO,C7:1314_SA" "C1:1314_OA,NA:1314_SO,C5:1314_SA" "C0:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C6:1314_SO,C9:1314_SA" "C9:1314_OA,C11:1314_SO,NA:1314_SA" "C5:1314_OA,C2:1314_SO,NA:1314_SA" "C11:1314_OA,NA:1314_SO,C12:1314_SA" "NA:1314_OA,C3:1314_SO,C1:1314_SA" "C9:1314_OA,NA:1314_SO,C9:1314_SA" "C8:1314_OA,NA:1314_SO,C11:1314_SA" "C4:1314_OA,NA:1314_SO,C7:1314_SA" "C1:1314_OA,C0:1314_SO,C5:1314_SA" "C10:1314_OA,NA:1314_SO,C1:1314_SA" "NA:1314_OA,C7:1314_SO,C8:1314_SA" "C9:1314_OA,C3:1314_SO,NA:1314_SA" "C11:1314_OA,C4:1314_SO,NA:1314_SA" "C11:1314_OA,C2:1314_SO,NA:1314_SA"; do
	pattern=$(echo $i | sed 's/:1314/_1314/;s/1314_OA,/1314_OA_/;s/:1314_SO,/_1314_SO_/;s/:1314_SA/_1314_SA/g');
	head -1 $GOannotationlocation/GOannotation_table/association_table-$pattern\.txt > $GOannotationlocation/GOannotation_table_pfdr0.01/pfdr0.01_table-$pattern\.txt &&
awk -F '\t' '$13 < 0.01' $GOannotationlocation/GOannotation_table/association_table-$pattern\.txt >> $GOannotationlocation/GOannotation_table_pfdr0.01/pfdr0.01_table-$pattern\.txt

