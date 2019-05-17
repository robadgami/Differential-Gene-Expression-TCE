filelocation="/Users/rbadgami/Desktop/data2/Cluster_matrix"

#### FOR each sample ####
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_F22_OA.tsv $filelocation/cluster_data/cluster_original_F22_OA.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_F22_SO.tsv $filelocation/cluster_data/cluster_original_F22_SO.tsv
cp /Users/rbadgami/Desktop/compare_clusters/cluster_gene_list/cluster_original_F22_SA.tsv $filelocation/cluster_data/cluster_original_F22_SA.tsv
# MANUALLY open in excel and save as .csv

echo "Genes,Cluster:Sample" > $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $1, ",C0:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $2, ",C1:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $3, ",C2:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $4, ",C3:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $5, ",C4:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $6, ",C5:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $7, ",C6:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $8, ",C7:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $9, ",C8:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $10, ",C9:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $11, ",C10:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $12, ",C11:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $13, ",C12:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $14, ",C13:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
awk -F ',' '{print $15, ",C14:F22_SO"}' $filelocation/cluster_data/cluster_original_F22_SO.csv >> $filelocation/cluster_matrix_F22_SO.txt
# I had trouble with last column so added this one separately:
awk -F ',' '{print $16}' $filelocation/cluster_data/cluster_original_F22_SO.csv > $filelocation/cluster_matrix_F22_SO_C15.csv
# MANUALLY add C15:F22_SO, a space after gene and convert to .txt format
sed 's/00,/00 ,/g' $filelocation/cluster_matrix_F22_SO_C15.csv | sed 's/LC,/LC ,/g' > $filelocation/cluster_matrix_F22_SO_C15.txt


awk '{print $0}' $filelocation/cluster_matrix_F22_SO_C15.txt >> $filelocation/cluster_matrix_F22_SO.txt &&
sort -u $filelocation/cluster_matrix_F22_SO.txt  > $filelocation/noblank_cluster_matrix_F22_SO.txt
# manually remove all non-gene-containing columns and check length is as expected.

rm $filelocation/cluster_matrix_F22_SO_C15.csv
rm $filelocation/cluster_matrix_F22_SO_C15.txt
rm $filelocation/cluster_matrix_F22_SO.txt 
#### FIN ####

# check total number genes is as expected:
wc -l $filelocation/noblank_cluster_matrix_F22_*.txt

##### Make list clust genes within F22 ####
for sample in "F22_OA" "F22_SO" "F22_SA"; do
cat $filelocation/noblank_cluster_matrix_$sample\.txt >> $filelocation/temp_noblank_matrix_F22.txt; done
awk -F ',' '{print $1}' $filelocation/temp_noblank_matrix_F22.txt | sort | uniq > $filelocation/final_noblank_cluster_matrix_F22.txt
# check length is as expected
rm $filelocation/temp_noblank_cluster_matrix_F22.txt

#####FIN #####

###MAKE CLUSTER MATRIX ####
for sample in "F22_OA" "F22_SO" "F22_SA"; do
while read line; do
if grep -qw $line $filelocation/noblank_cluster_matrix_$sample\.txt;
then echo $(grep -w $line $filelocation/noblank_cluster_matrix_$sample\.txt) >> $filelocation/final_cluster_matrix_$sample\.csv;
else echo $line ,"NA:"$sample >> $filelocation/final_cluster_matrix_$sample\.csv;
fi;
done < $filelocation/final_noblank_cluster_matrix_F22.txt;
done
# check final_cluster_matrix_$sample.txt same length as sorted_noblank_cluster_matrix_F22.txt
wc -l $final_noblank_cluster_matrix_F22.txt
wc -l $final_cluster_matrix_F22_*.csv
## MERGE IN R ##
library(readr)
final_cluster_matrix_F22_OA <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_F22_OA.csv")
final_cluster_matrix_F22_SA <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_F22_SA.csv")
final_cluster_matrix_F22_SO <- read_csv("~/Desktop/data2/Cluster_matrix/final_cluster_matrix_F22_SO.csv")
final_cluster_matrix_F22 <- data.frame(final_cluster_matrix_F22_OA$Gene, final_cluster_matrix_F22_OA$`NA:F22_OA`,
                                       final_cluster_matrix_F22_SO$`NA:F22_SO`,
                                       final_cluster_matrix_F22_SA$`NA:F22_SA`)
colnames(final_cluster_matrix_F22) <- c("Genes", "Cluster:F22_OA", "Cluster:F22_SO", "Cluster:F22_SA")
write_csv(final_cluster_matrix_F22, "~/Desktop/data2/Cluster_matrix/final_cluster_matrix_F22.csv")

### FIN ####

for sample in "F22_OA" "F22_SO" "F22_SA"; do
rm /Users/rbadgami/Desktop/data2/Cluster_matrix/final_cluster_matrix_$sample\.csv;done

#### WORK OUT GENE COUNT FOR EACH COMPARATIVE CLUST PATTERN #####
head -1 $filelocation/final_cluster_matrix_F22.csv > $filelocation/final_cluster_matrix_F22_genecount.csv &&
awk -F ',' 'BEGIN{OFS=",";}{print $2, $3, $4}' $filelocation/final_cluster_matrix_F22.csv | sort | uniq -c | sort -r | sed 's/ /,/g' >> $filelocation/final_cluster_matrix_F22_genecount.csv
#manually sort the count list so it appears in columns


##### IMPROVED GENE IDENTIFICATION ####
### add '=' to cluster matrix ###
sed 's/00,/00=,/' $filelocation/final_cluster_matrix_F22.csv > $filelocation/identification_final_cluster_matrix_F22.csv
### and to clust datapoints SO ONLY obtain datapoints for genes within a cluster ####

for sample in "F22_OA" "F22_SO" "F22_SA"; do
sed 's/00 ,/00=,/' $filelocation/final_Clustpattern_$sample\.csv > $filelocation/temp_final_Clustpattern_$sample\.csv
sed 's/00 ,/00=,/' $filelocation/noblank_cluster_matrix_$sample\.txt > $filelocation/temp_noblank_cluster_matrix_$sample\.txt
awk -F ',' '{print $1}' $filelocation/temp_noblank_cluster_matrix_$sample\.txt | while read line; do
	grep -e $line $filelocation/temp_final_Clustpattern_$sample\.csv >> $filelocation/temp_final_final_Clust_pattern_$sample\.csv; done;
wc -l $filelocation/temp_noblank_cluster_matrix_$sample\.txt
wc -l $filelocation/temp_final_final_Clust_pattern_$sample\.csv;
done
# if length is as expecte then concatenate the within-cluster-datapoints into one large file
for sample in "F22_OA" "F22_SO" "F22_SA"; do
sed 's/00=,/00 ,/' $filelocation/temp_final_final_Clust_pattern_$sample\.csv > $filelocation/final_final_Clust_pattern_$sample\.csv
cat $filelocation/final_final_Clust_pattern_$sample\.csv >> $filelocation/identification_final_Clust_pattern_F22.csv

rm $filelocation/temp_*
rm $filelocation/final_final_Clust_pattern_*.csv


##### SPECIFIC PATTERN CLUST DATAPOINTS #####
# to do individual clustdata:
#grep -e "NA:F22_OA,C2:F22_SO,NA:F22_SA" $filelocation/identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' | while read line; do
# grep -e $line /Users/rbadgami/Desktop/data2/Cluster_matrix/identification_final_Clust_pattern_F22.csv >> $filelocation/clustergraph/NA-F22_OA_C2-F22_SO_NA-F22_SA.csv; done
# to do group clustdata:
# get the datapoints for first 89 patterns
#head -n 90 temp_patternquotation.csv
# manually add " at start and end of line and make list into string to put after 'for i in '
for i in "NA:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,C12:F22_SO,C6:F22_SA" "C0:F22_OA,C0:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C10:F22_SO,NA:F22_SA" "NA:F22_OA,C0:F22_SO,NA:F22_SA" "NA:F22_OA,C4:F22_SO,C6:F22_SA" "C6:F22_OA,C12:F22_SO,C6:F22_SA" "NA:F22_OA,NA:F22_SO,C0:F22_SA" "NA:F22_OA,C4:F22_SO,NA:F22_SA" "NA:F22_OA,C0:F22_SO,C0:F22_SA" "NA:F22_OA,C9:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C6:F22_SA" "NA:F22_OA,C3:F22_SO,NA:F22_SA" "C0:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C7:F22_SO,C0:F22_SA" "C0:F22_OA,C0:F22_SO,C0:F22_SA" "NA:F22_OA,C1:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,NA:F22_SA" "C6:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,C7:F22_SO,NA:F22_SA" "NA:F22_OA,C5:F22_SO,NA:F22_SA" "C0:F22_OA,C0:F22_SO,C10:F22_SA" "NA:F22_OA,C3:F22_SO,C6:F22_SA" "C6:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C14:F22_SO,C1:F22_SA" "C0:F22_OA,C1:F22_SO,NA:F22_SA" "C10:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C1:F22_SA" "C0:F22_OA,NA:F22_SO,C0:F22_SA" "NA:F22_OA,C15:F22_SO,NA:F22_SA" "NA:F22_OA,C11:F22_SO,NA:F22_SA" "C3:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C9:F22_SO,C0:F22_SA" "C6:F22_OA,C10:F22_SO,NA:F22_SA" "C10:F22_OA,NA:F22_SO,NA:F22_SA"  "NA:F22_OA,NA:F22_SO,C12:F22_SA" "C3:F22_OA,C10:F22_SO,NA:F22_SA" "NA:F22_OA,C6:F22_SO,NA:F22_SA" "NA:F22_OA,C13:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C9:F22_SA" "C2:F22_OA,NA:F22_SO,NA:F22_SA" "C6:F22_OA,NA:F22_SO,C6:F22_SA" "C4:F22_OA,NA:F22_SO,NA:F22_SA" "C1:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C3:F22_SA" "NA:F22_OA,C0:F22_SO,C10:F22_SA" "NA:F22_OA,C7:F22_SO,C1:F22_SA" "NA:F22_OA,NA:F22_SO,C2:F22_SA" "NA:F22_OA,C10:F22_SO,C0:F22_SA" "C4:F22_OA,C9:F22_SO,NA:F22_SA" "C0:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C5:F22_SA" "C3:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C8:F22_SA" "C9:F22_OA,C2:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C10:F22_SA" "NA:F22_OA,C9:F22_SO,C1:F22_SA" "NA:F22_OA,C2:F22_SO,C6:F22_SA" "NA:F22_OA,C10:F22_SO,C3:F22_SA" "NA:F22_OA,C2:F22_SO,C0:F22_SA" "NA:F22_OA,C10:F22_SO,C5:F22_SA" "C4:F22_OA,C10:F22_SO,NA:F22_SA" "C8:F22_OA,C3:F22_SO,C6:F22_SA" "NA:F22_OA,C4:F22_SO,C8:F22_SA" "NA:F22_OA,C10:F22_SO,C6:F22_SA" "NA:F22_OA,C1:F22_SO,C10:F22_SA" "C3:F22_OA,C12:F22_SO,C6:F22_SA" "NA:F22_OA,C2:F22_SO,C9:F22_SA" "C13:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C5:F22_SO,C8:F22_SA" "NA:F22_OA,C5:F22_SO,C6:F22_SA" "NA:F22_OA,C2:F22_SO,C8:F22_SA" "NA:F22_OA,C12:F22_SO,C4:F22_SA" "C12:F22_OA,C14:F22_SO,C0:F22_SA" "NA:F22_OA,C8:F22_SO,NA:F22_SA" "C8:F22_OA,NA:F22_SO,NA:F22_SA" "C8:F22_OA,C12:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C4:F22_SA" "NA:F22_OA,C15:F22_SO,C0:F22_SA" "NA:F22_OA,C3:F22_SO,C8:F22_SA" "C0:F22_OA,C0:F22_SO,C9:F22_SA" "C8:F22_OA,NA:F22_SO,C6:F22_SA" "C6:F22_OA,C10:F22_SO,C6:F22_SA" "C1:F22_OA,C0:F22_SO,NA:F22_SA" ; do
#for i in "C0:F22_OA,C7:F22_SO,C0:F22_SA" "C9:F22_OA,C3:F22_SO,NA:F22_SA" "C6:F22_OA,C4:F22_SO,C6:F22_SA" "C13:F22_OA,NA:F22_SO,NA:F22_SA" "NA:F22_OA,C2:F22_SO,C12:F22_SA" "NA:F22_OA,C2:F22_SO,C10:F22_SA" "NA:F22_OA,C14:F22_SO,C14:F22_SA" "NA:F22_OA,C0:F22_SO,C1:F22_SA" "C0:F22_OA,C14:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C13:F22_SA" "C0:F22_OA,C1:F22_SO,C9:F22_SA" "C9:F22_OA,C3:F22_SO,C6:F22_SA" "C15:F22_OA,C3:F22_SO,C6:F22_SA" "NA:F22_OA,NA:F22_SO,C15:F22_SA" "C6:F22_OA,C9:F22_SO,NA:F22_SA" "C0:F22_OA,NA:F22_SO,C9:F22_SA" "C1:F22_OA,NA:F22_SO,C0:F22_SA" "NA:F22_OA,C9:F22_SO,C2:F22_SA" "C4:F22_OA,C7:F22_SO,C0:F22_SA" "C0:F22_OA,C6:F22_SO,NA:F22_SA" "NA:F22_OA,C1:F22_SO,C0:F22_SA" "NA:F22_OA,C0:F22_SO,C12:F22_SA" "C6:F22_OA,C4:F22_SO,NA:F22_SA" "C3:F22_OA,C9:F22_SO,NA:F22_SA" "C2:F22_OA,C12:F22_SO,NA:F22_SA" "C0:F22_OA,C1:F22_SO,C10:F22_SA" "C7:F22_OA,C12:F22_SO,C6:F22_SA" "C6:F22_OA,C11:F22_SO,NA:F22_SA" "C4:F22_OA,C9:F22_SO,C2:F22_SA" "C15:F22_OA,C3:F22_SO,NA:F22_SA" "C8:F22_OA,C3:F22_SO,NA:F22_SA" "C4:F22_OA,C9:F22_SO,C1:F22_SA" "C15:F22_OA,C4:F22_SO,NA:F22_SA" "C13:F22_OA,C7:F22_SO,C0:F22_SA" "C11:F22_OA,NA:F22_SO,NA:F22_SA" "C0:F22_OA,C7:F22_SO,NA:F22_SA" "NA:F22_OA,NA:F22_SO,C7:F22_SA" "C7:F22_OA,C4:F22_SO,C6:F22_SA" "NA:F22_OA,C14:F22_SO,C2:F22_SA" "C1:F22_OA,C0:F22_SO,C0:F22_SA"; do
	pattern=$(echo $i | sed 's/:/-/g' | sed 's/,/_/g' | sed 's/-/_/g')
	echo "Genes,1,3,7,11,Sample" > $filelocation/temp_genelist/clusterdata_$pattern\.csv
	grep -e $i $filelocation/identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' > $filelocation/temp_genelist/temp_$pattern\_genelist.csv &&
	while read line; do
	grep -e $line  $filelocation/identification_final_Clust_pattern_F22.csv >> $filelocation/temp_genelist/clusterdata_$pattern\.csv;
done < $filelocation/temp_genelist/temp_$pattern\_genelist.csv; done
rm $filelocation/temp_genelist/temp_*_genelist.csv
# a long-form of this data is also made for use in R.
cd $filelocation/temp_genelist
for files in *.csv ; do
	echo 'Genes,value,dpi,Sample' > long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "1", $6}' $files | tail -n +2  >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $3, "3", $6}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print  $1, $4, "7", $6}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print  $1, $5,"11", $6}' $files | tail -n +2 >> long_data/long_$files; done

##########################################################################
######### MOVE TO R TO MAKE GRAPH ########################################
######### Use R_Script: ~/Desktop/data2/R_scripts2/Clustgraphs.R##########
##########################################################################

##### GOannotation ####

filelocation="/Users/rbadgami/Desktop/data2/Cluster_matrix"
destinationlocation="/Users/rbadgami/Desktop/data2/Cluster_matrix/clustergraph/GOenrichment/output_GOenrichment"
pattern="C0_F22_OA_C0_F22_SO_C9_F22_SA"
# get genelist for that pattern
awk -F ',' 'BEGIN{OFS=",";}{print $1}' $filelocation/temp_genelist/clusterdata_$pattern\.csv | sed 's/=/ /g' | sort -u > $filelocation/temp_GOlist.txt && wc -l $filelocation/temp_GOlist.txt
#in another terminal
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/temp_GOlist.txt /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $destinationlocation/association_$pattern\.txt &&
# make table by removing the first 21 lines and the dots before GO
tail -n +21 $destinationlocation/association_$pattern\.txt | sed 's/^[^G]*G/G/' > $destinationlocation\_table/association_table-$pattern\.txt &&
# make table to input into revigo containing "GO", "pfdr"(<0.01)
head -1 $destinationlocation\_table/association_table-$pattern\.txt > $destinationlocation\_table/pfdr0.01_table-$pattern\.txt &&
awk -F '\t' '$13 < 0.01' $destinationlocation\_table/association_table-$pattern\.txt >> $destinationlocation\_table/pfdr0.01_table-$pattern\.txt

