## Explanation on Comparing Clust-derived Clusters

> Once Clust-derived clusters have been made I wanted to compare the DGE patterns of genes between hosts to help identify relevant processes. This can be done by collating and comparing Clusts.



##Construct datatables of Clust-derived host gene clusters

#### Construct Cluster matrix showing which sample cluster each gene assigns to

Clust-dervied gene lists were manually converted from `.tsv` to `.csv` files as each column corresponded to a cluster of genes for that sample. This layout was converted into an easier-to-process format using `awk ` with columns as "Genes","Cluster:Sample". The final column was added separately. To ensure no duplication, each sample's gene list was sorted `sort -u`.

Now, each sample has a gene list with the genes used by Clust and and its corresponding Cluster for that sample.

```sh
# make gene.list
echo "Genes,Cluster:Sample" > $filelocation/cluster_matrix_sample.txt
awk -F ',' '{print $[column.number], ", [Cluster:Sample]"}'$filelocation/inputfile.csv >> $filelocation/cluster_matrix_[Sample].txt

# sort gene.list layout
sort -u $filelocation/cluster_matrix_[Sample].txt  > $filelocation/noblank_cluster_matrix_[Sample].txt

```

These individual sample lists were then collated to form a cluster matrix. Not all samples had all the Clust-derived genes. Hence, firstly, `.csv` -formatted columns for each samples were made that encompassed all the genes - if the gene was present in a cluster, its Cluster was listed, else `"NA"` was written.

``` sh
# construct total gene.list for all samples
for sample in "[SampleA]" "[SampleB]" "[SampleC]"; do
cat $filelocation/noblank_cluster_matrix_$sample\.txt >> $filelocation/noblank_cluster_matrix_sample.txt; done &&
awk -F ',' '{print $1}' $filelocation/noblank_cluster_matrix_sample.txt | sort | uniq > $filelocation/final_noblank_cluster_matrix_F22.txt

# form relevant total gene.list column for each sample
for sample in "[SampleA]" "[SampleB]" "[SampleC]"; do
while read line; do
	if grep -qw $line $filelocation/noblank_cluster_matrix_$sample\.txt;
	then echo $(grep -w $line $filelocation/noblank_cluster_matrix_$sample\.txt) >> $filelocation/final_cluster_matrix_$sample\.csv;
	else echo $line ,"NA:"$sample >> $filelocation/final_cluster_matrix_$sample\.csv;
fi;
done < $filelocation/final_noblank_cluster_matrix_F22.txt;
done

# check file lengths are equal
wc -l $filelocation/final_noblank_cluster_matrix_F22.txt
wc -l $filelocation/final_cluster_matrix_*.csv
```

The sample columns were then joined together on R. Once the final cluster matrix was constructed, the total gene.list column for each sample could be removed `rm $filelocation/final_cluster_matrix_\$sample\.csv` and `rm $filelocation/final_noblank_cluster_matrix_F22.txt`.

```R
library(readr)
final_cluster_matrix_SampleA <- read_csv("~/file.location/final_cluster_matrix_SampleA.csv")
final_cluster_matrix_SampleB <- read_csv("~/file.location/final_cluster_matrix_SampleB.csv")
final_cluster_matrix_SampleC <- read_csv("~/file.location/final_cluster_matrix_SampleC.csv")
final_cluster_matrix_F22 <- data.frame(final_cluster_matrix_SampleA$Gene, final_cluster_matrix_SampleA$`Cluster:SampleA`,final_cluster_matrix_SampleB$`Cluster:SampleB`, final_cluster_matrix_SampleC$`Cluster:SampleC`)
colnames(final_cluster_matrix_Sample) <- c("Genes", "Cluster:SampleA", "Cluster:SampleB", "Cluster:SampleC")
write_csv(final_cluster_matrix_F22, "~/file.location/final_cluster_matrix_F22.csv")
```



#### Determine Gene Count for each comparative clust pattern

The number of genes that assign to each comparative clust pattern (e.g. matching genes with column `$2, $3, $4` equal to `Cluster1:SampleA,Cluster1:SampleB,NA:SampleC`) is determined. The column format should be *manually* checked.

``` sh
head -1 $filelocation/final_cluster_matrix_sample.csv > $filelocation/final_cluster_matrix_sample_genecount.csv &&
awk -F ',' 'BEGIN{OFS=",";}{print $2, $3, $4}' $filelocation/final_cluster_matrix_sample.csv | sort | uniq -c | sort -r | sed 's/ /,/g' >> $filelocation/final_cluster_matrix_sample_genecount.csv
```

`uniq -c` = gives the total number lines that are the same for that line content.

`sort -r` = sorts in reverse order (largest-to-smallest).

`sed 's/ /,/g'` = add comma after the gene count number



#### Construct Clust-derived datapoints for genes IN clusters

To recreate Clust graphs for Clust pattern comparisons, a dataset of points for only Clust-used genes must be formed. 

Since some genes are present in both high-confidence and low-confidence versions, an `=` will be added at the end to help differentiate HC/LC.

Do this for the comparative cluster pattern matrix...

``` sh
sed 's/00,/00=,/' $filelocation/final_cluster_matrix_sample.csv > $filelocation/identification_final_cluster_matrix_sample.csv
```

… and for each sample's cluster datapoints. If the length is as expected, a summative clust-derived data table is formed.

```sh
for sample in "[sampleA]" "[sampleB]" "[sampleC]"; do
sed 's/00 ,/00=,/' $filelocation/final_Clustpattern_$sample\.csv > $filelocation/temp_final_Clustpattern_$sample\.csv
sed 's/00 ,/00=,/' $filelocation/noblank_cluster_matrix_$sample\.txt > $filelocation/temp_noblank_cluster_matrix_$sample\.txt
awk -F ',' '{print $1}' $filelocation/temp_noblank_cluster_matrix_$sample\.txt | while read line; do
	grep -e $line $filelocation/temp_final_Clustpattern_$sample\.csv >> $filelocation/temp_final_Clust_pattern_$sample\.csv; done;
wc -l $filelocation/temp_noblank_cluster_matrix_$sample\.txt
wc -l $filelocation/temp_final_Clust_pattern_$sample\.csv;
done

# if length is as expecte then:
for sample in "[sampleA]" "[sampleB]" "[sampleC]"; do
sed 's/=,/ ,/' $filelocation/temp_final_Clust_pattern_$sample\.csv > $filelocation/final_Clust_pattern_$sample\.csv
cat $filelocation/final_Clust_pattern_$sample\.csv >> $filelocation/identification_final_Clust_pattern_sample.csv

rm $filelocation/temp_*
rm $filelocation/final_Clust_pattern_*.csv
```



## Make clust-value table for constructing comparative cluster pattern graphs for a specific pattern

For individual pattern investigation, the following code can be used. It searches for lines from the final comparative cluster pattern matrix for genes that match the pattern (e.g. `"NA:F22_OA,C2:F22_SO,NA:F22_SA"` )  and uses these gene IDs (with `=` after it) and the total clust-derived data table to form a table for graph generation.

``` sh
grep -e "[pattern]" $filelocation/identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' | while read line; do
 grep -e $line /Users/rbadgami/Desktop/data2/Cluster_matrix/identification_final_Clust_pattern_F22.csv >> $filelocation/clustergraph/NA-F22_OA_C2-F22_SO_NA-F22_SA.csv; done
```

To do this for multiple patterns a string of patterns is formed.

``` sh
for i in [insert a string of patterns] ; do
	pattern=(echo i | sed 's/:/-/g' | sed 's/,//g' | sed 's/-//g');
	echo "Genes,1,3,7,11,Sample" > $filelocation/temp_genelist/clusterdatapattern\.csv;
	grep -e i $filelocation/identification_final_cluster_matrix_sample.csv | awk -F ',' '{print $1}' > $filelocation/temp_genelist/temppattern\_genelist.csv &&
	while read line; do
	grep -e line  $filelocation/identification_final_Clust_pattern_sample.csv >> $filelocation/temp_genelist/clusterdata_$pattern.csv;
done < $filelocation/temp_genelist/temp_$pattern_genelist.csv; done

# a long-form of this data is also made for use in R.
cd $filelocation/temp_genelist
for files in *.csv ; do
	echo 'Genes,value,dpi,Sample' > long_data/longfiles &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $2, "1", $6}' files | tail -n +2  >> long_data/longfiles &&
	awk -F ',' 'BEGIN{OFS=",";}{print $1, $3, "3", $6}' files | tail -n +2 >> long_data/longfiles &&
	awk -F ',' 'BEGIN{OFS=",";}{print  $1, $4, "7", $6}' files | tail -n +2 >> long_data/longfiles &&
	awk -F ',' 'BEGIN{OFS=",";}{print  $1, $5,"11", $6}' files | tail -n +2 >> $filelocation/temp_genelist/long_data/long_$files; done



```

All long-form data is present in one file with file title `long_clusterdata_[matrixpattern].csv`.

******



## Forming Comparative Cluster Graphs in R

> Raw R.script is present in [Differential-Gene-Expression-TCE/Comparing_Clusters](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Comparing_Clusters/Clustgraphs.R "Clustgraphs.R"). 



This whole file can be loaded into R as dataframes using a for loop, where `i` is the `[matrixpattern]` and resulting `[data.frame.name]`. Remember to check the `colClasses=c()` matches the column format.

```R
for(i in names){filepath <- file.path([insert/filepath/location]",paste("long_clusterdata_",i,".csv",sep=""))
assign(i, read.delim(filepath,
                     colClasses=c("factor",rep("numeric",2), "factor"),
                     sep = ","))
}
```

--------

 #### An example of code for comparative cluster line graph.

I'm unsure how to generate a for loop to construct all the comparative line graphs for the available dataframes so I have made each on manually.

```
plotx <- ggplot() + geom_line(data=[data.frame.name], aes(x=dpi, y=value, lineshape = Genes, colour=Sample)) +ggtitle("[data\nframe\nname]") + theme(axis.title = element_text(size=8))+ xlab("days post-inoculation") + ylab("Clust value") + labs(fill = "Sample") +points(x=[data.frame.name]$dpi) +scale_x_continuous(breaks = c(1, 3, 7, 11)) + scale_colour_manual(values = irisColors) + theme(legend.position = "none")
```

`geom_line(data=[data.frame.name], aes(x=dpi, y=value, lineshape = Genes, colour=Sample)` = line graph is plotted for each `Genes` BUT colour-coded according to the corresponding `Sample`. 

`ggtitle("[data\nframe\nname]") + theme(axis.title = element_text(size=8))` = new line can be added within the title via `\n` and formatted via `theme(…)`.

`xlab("...") + ylab("...") + labs(fill = "...")` = relabel x-axis, y-axis and figure legend

`scale_x_continuous(breaks = c(1, 3, 7, 11))` = alter x-axis points to match data.

`scale_colour_manual(values = irisColors)`  = data colours altered to match specified colour pattern.

Optional: `theme(legend.position = "none") ` = remove legend so more space on page for graph.

---------

For easy comparison between graphs, group colouring is kept the same between hosts.

```
irisColors <- setNames( c('lightcoral', 'steelblue', 'lightgreen'), c("F22_OA", "F22_SO", "F22_SA") )
```

Several graphs are plotted per plot.

```
ggarrange( plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, plot10, plot11, plot12, plot13, plot14, plot15, plot16, ncol = 4, nrow = 4)
```

The graphs were saved into a pdf file.

```
plot.new()
pdf("[filepath/to/storage/destination]", height=11, width=8.5)
....
list of plots
...
dev.off()

```



These graphs were visually inspected to find interesting comparative clusters between hosts. Due to the sheer number of comparative cluster patterns, only a small subset of patterns were investigated.

****



## Obtaining GOannotation of interesting Comparative Cluster patterns

Once a visually interesting cluster pattern has been selected, it's associated GOannotation can be determined. This step uses the cluster datapoints for each comparative cluster pattern.

First, define the following terms. For each pattern-of-interest, only the term `pattern="…"` needs to be altered.

```sh
filelocation="/Users/rbadgami/Desktop/data2/Cluster_matrix"
destinationlocation="/Users/rbadgami/Desktop/data2/Cluster_matrix/clustergraph/GOenrichment/output_GOenrichment"
pattern="C0_F22_OA_C0_F22_SO_C9_F22_SA"
```

Then, the following code can be run in the terminal:

``` sh
# get gene lsit for that pattern
awk -F ',' 'BEGIN{OFS=",";}{print $1}' $filelocation/temp_genelist/clusterdata_$pattern\.csv | sed 's/=/ /g' | sort -u > $filelocation/temp_GOlist.txt &&
conda activate stan
cd anaconda3/lib/python3.7/site-packages/goatools
python  /Users/rbadgami/anaconda3/bin/find_enrichment.py  --obo /Users/rbadgami/go-basic.obo --pval=0.05  --indent $filelocation/temp_GOlist.txt /Users/rbadgami/Desktop/GOenrichment/refseq-ids-transcriptsclean_altered.txt /Users/rbadgami/Desktop/GOenrichment/GO-association-refseq-transcripts-only_altered.txt > $destinationlocation/association_$pattern\.txt &&
# make table by removing the first 21 lines and the dots before GO
tail -n +21 $destinationlocation/association_$pattern\.txt | sed 's/^[^G]*G/G/' > $destinationlocation\_table/association_table-$pattern\.txt &&
# make table to input into revigo containing "GO", "pfdr"(<0.01)
head -1 $destinationlocation\_table/association_table-$pattern\.txt > $destinationlocation\_table/pfdr0.01_table-$pattern\.txt &&
awk -F '\t' '$13 < 0.01' $destinationlocation\_table/association_table-$pattern\.txt >> $destinationlocation\_table/pfdr0.01_table-$pattern\.txt

```

Open `$filelocation/clustergraph/GOenrichment/output_GOenrichment_table/pfdr0.01_table-$pattern\.txt` in excel and copy columns "GO" and "pfdr" and input into [REViGO](http://revigo.irb.hr/). Use settings medium similarity (0.7), database wiith GO term sizes (whole UniProt (default)) semantic similarity measure (SimRel).

> More information on REVIGO at: Supek F, Bošnjak M, Škunca N, Šmuc T.  "*REVIGO summarizes and visualizes long lists of Gene Ontology terms"*  PLoS ONE 2011. [doi:10.1371/journal.pone.0021800](http://dx.doi.org/10.1371/journal.pone.0021800)



Copy REViGO output table into a second sheet in an excel version of the `pfdr0.01_table-$pattern\.txt` file.

Sort both sheet1 and sheet2 and concatenate into a third sheet and create a new column titled "hide" - the new column order should now be:

| GO         | NS       | enrichment                                 | name               | ratio_in_study        | ratio_in_pop            | p-uncorrrected | depth               | study_count           | p_bonferroni | p_sidak | p_holm | p_fdr_bh | term_ID | description | frequency          | plot_X | plot_Y | plot_size | log10 p-value   | uniqueness | dispensability | representative | eliminated                                   | hide                               | study_items            |
| ---------- | -------- | ------------------------------------------ | ------------------ | --------------------- | ----------------------- | -------------- | ------------------- | --------------------- | ------------ | ------- | ------ | -------- | ------- | ----------- | ------------------ | ------ | ------ | --------- | --------------- | ---------- | -------------- | -------------- | -------------------------------------------- | ---------------------------------- | ---------------------- |
| GO term ID | BP/CC/MF | is it enriched in the study vs population? | GOterm description | number genes assigned | number genes in general |                | Specificity of term | number genes assigned |              |         |        |          | see GO  | see name    | see ratio_in_study |        |        |           | log10(p_fdr_bh) |            |                |                | deemed similar to other GOterm by REViGO(=1) | manually decided to be ignored(=1) | Name of genes assigned |

Filter by NS and, with the visual help from REViGO, manually go through the list for that comparative cluster pattern and remove (hide=1) any GOterms that are redundant or uninformative. Whats left should give a general overview of what molecular functions/biological processes may be involved in that cluster.

