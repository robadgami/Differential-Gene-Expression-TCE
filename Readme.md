## Differential Gene Expression TCE - Readme.md



Project Summary: This project focuses on deciphering the host gene expression changes during a time-course experiment to further understand molecular process changes and potentially identify key candidates.





##### Comparing cluster patterns between hosts

Once cluster patterns over time for each host has been obtained, interesting molecular process differences can be investigated by comparing DGE pattern clusters between hosts.

The data is prepared following the script …….



The cluster datapoints are converted to long-format i.e. with column names "Genes", "value", dpi", "Sample" (this can be done via the terminal).

Then, the cluster graphs can be formed using the R script [Clustergraphs.R](https://github.com/robadgami/Differential-Gene-Expression-TCE/blob/master/Comparing_Clusters/Clustgraphs.R) . 