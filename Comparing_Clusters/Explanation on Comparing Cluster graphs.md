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









Since some genes are present in both high-confidence and low-confidence versions, an `=` will be added at the end to help differentiate.

```sh
for sample in "[sampleA]" "[sampleB]" "[sampleC]"; do
sed 's/ ,/=,/' $filelocation/final_Clustpattern_$sample\.csv > $filelocation/temp_final_Clustpattern_$sample\.csv
sed 's/ ,/=,/' $filelocation/noblank_cluster_matrix_$sample\.txt > $filelocation/temp_noblank_cluster_matrix_$sample\.txt
awk -F ',' '{print $1}' $filelocation/temp_noblank_cluster_matrix_$sample\.txt | while read line; do
	grep -e $line $filelocation/temp_final_Clustpattern_$sample\.csv >> $filelocation/temp_final_final_Clust_pattern_$sample\.csv; done;
wc -l $filelocation/temp_noblank_cluster_matrix_$sample\.txt
wc -l $filelocation/temp_final_final_Clust_pattern_$sample\.csv;
done

# if length is as expecte then:
sed 's/=,/ ,/' $filelocation/temp_final_final_Clust_pattern_$sample\.csv > $filelocation/final_final_Clust_pattern_$sample\.csv
cat $filelocation/final_final_Clust_pattern_F22_OA.csv $filelocation/final_final_Clust_pattern_F22_SO.csv $filelocation/final_final_Clust_pattern_F22_SA.csv >> $filelocation/identification_final_Clust_pattern_$sample\.csv

rm $filelocation/temp_*
rm $filelocation/final_final_Clust_pattern_*.csv

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

