library(readxl)
sigDEG_isolate_criteria <- read_excel("/Volumes/RBADGAMI 1/sigDEG_isolate_criteria.xlsx", sheet="sigCONandsigISO_long",
                                           col_types = c("text", "text", "numeric"))
colnames(sigDEG_isolate_criteria)
# get appropriate colour scheme
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#A6CEE3", "#B2DF8A", "#FB9A99"),
                       c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA", "CON_SO", "CON_SA", "CON_OA"))

# barchart of reads mapped to wheat
library(ggplot2)
colorCount = length(unique(sigDEG_isolate_criteria$criteria))
getPalette = colorRampPalette(brewer.pal(7, "Set2"))
ggplot(data=sigDEG_isolate_criteria, aes(x=isolate_dpi, y=as.numeric(number_sigDEG, levels=c("LFC_F22_01dpi",
                                                                                         "LFC_F22_03dpi",
                                                                                         "LFC_F22_07dpi",
                                                                                         "LFC_F22_11dpi",
                                                                                         "LFC_1314_01dpi",
                                                                                         "LFC_1314_03dpi",
                                                                                         "LFC_1314_07dpi",
                                                                                         "LFC_1314_11dpi")),
                                         fill=factor(criteria, levels=c("OA_only", "OA_and_SO", "SO_only", "SO_and_SA", "SA_only",
                                                                          "OA_and_SA",  "SO_and_SA_and_OA")))) + 
  scale_fill_manual(values=getPalette(colorCount)) +
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  labs(fill = "criteria") + ylab("number_sigDEGs_assigned to each criteria") +xlab("samples") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
