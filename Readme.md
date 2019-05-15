## Differential Gene Expression TCE - Readme.md



Project Summary: This project focuses on deciphering the host gene expression changes during a time-course experiment to further understand molecular process changes and potentially identify key candidates.

### Data Preparation

##### Clean raw reads and pseudoalign

Raw read data preparation was done using method in [Explanation-Data_Preparation.md](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Explanation%20on%20Comparing%20Cluster%20graphs.md). This involved cleaning raw reads and pseudoaligning to a reference transcriptome using kallisto to obtain raw read counts.





##### Comparing cluster patterns between hosts

Once cluster patterns over time for each host has been obtained, interesting molecular process differences can be investigated by comparing DGE pattern clusters between hosts. The method used to do this is explained in [Comparing_Clusters](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Comparing_Clusters/Explanation%20on%20Comparing%20Cluster%20graphs.md "Explanation on Comparing Cluster graphs.md"), along with the accompanying bash script [Clust_comparison.sh](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Comparing_Clusters/Clust_comparison.sh "Clust_comparison.sh") and R.script [Clustergraphs.R](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Comparing_Clusters/Clustgraphs.R "Clustergraphs.R").

