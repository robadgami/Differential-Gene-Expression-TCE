## Explanation on Comparing Cluster graphs





All long-form data is present in one file with file title `long_clusterdata_[matrixpattern].csv`.

******



## Forming Comparative Cluster Graphs in R

> Raw R.script is present in Comparing_Clusters/Clustergraphs.R



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

