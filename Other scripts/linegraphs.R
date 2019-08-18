Clust_F22_1dpi_SAonly <- read_excel("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/Clust_F22_1dpi_SAonly.xlsx", 
                                         col_types = c("text", "numeric", "numeric", 
                                                                "numeric", "numeric", "text", "text"))
View(Clust_F22_1dpi_SAonly)

colnames(Clust_F22_1dpi_SAonly)
Clust_F22_1dpi_SAonly$genes=as.factor(Clust_F22_1dpi_SAonly$genes)
Clust_F22_1dpi_SAonly$F22_cultivar=as.factor(Clust_F22_1dpi_SAonly$F22_cultivar)
Clust_F22_1dpi_SAonly$`1314_criteria`=as.factor(Clust_F22_1dpi_SAonly$`1314_criteria`)
colnames(Clust_F22_1dpi_SAonly) <- c("genes", "01", "03", "07", "11", "F22_cultivar", "1314_criteria")

#make into long-format for table
library(tidyr)
long.Clust_F22_1dpi_SAonly <- gather(Clust_F22_1dpi_SAonly, dpi, normalised_tpm, `01`:`11`)
head(long.Clust_F22_1dpi_SAonly)
long.Clust_F22_1dpi_SAonly$dpi=as.numeric(long.Clust_F22_1dpi_SAonly$dpi)

library(tidyverse)
long.F22_SA.Clust_F22_1dpi_SAonly <- long.Clust_F22_1dpi_SAonly %>% filter(long.Clust_F22_1dpi_SAonly$F22_cultivar == "F22_SA")
head(long.F22_SA.Clust_F22_1dpi_SAonly)
long.F22_SA.Clust_F22_1dpi_SAonly$dpi=as.numeric(long.F22_SA.Clust_F22_1dpi_SAonly$dpi)
long.F22_SA.Clust_F22_1dpi_SAonly$normalised_tpm=as.numeric(long.F22_SA.Clust_F22_1dpi_SAonly$normalised_tpm)

library(ggplot2)
ggplot(data=long.F22_SA.Clust_F22_1dpi_SAonly, mapping=aes(x=dpi, y=normalised_tpm, group=genes, colour=1314_criteria)) +
  geom_line()

ggplot() +
  geom_line(data=long.F22_SA.Clust_F22_1dpi_SAonly, aes(x=dpi, y=normalised_tpm, lineshape=genes, colour=`1314_criteria`)) +
  ggtitle("Clust patterns of F22_1dpi_SAonly") + scale_x_continuous(breaks = c(1, 3, 7, 11))
  

 theme(axis.title = element_text(size=8)) + xlab("days post-inoculation") + ylab("Clust value") + labs(fill = "Sample") +
   points(x=x1314_C0_F22_OA_C0_F22_SO_C0_F22_SA) + scale_colour_manual(values = irisColors)+ theme(legend.position = "none")
