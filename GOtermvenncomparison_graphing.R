library(readxl)
GOcomparison_alltime <- read_excel("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA/GOcomparison_F22_OAnSA_alltime.xlsx")
colnames(GOcomparison_alltime)
GOcomparison_alltime$`-log10(pfdr)` <- (-1*log10(GOcomparison_alltime$sp_fdr_bh))
GOcomparison_alltime$isolate_cultivar_dpi <- paste0(GOcomparison_alltime$isolate_cultivar,GOcomparison_alltime$dpi)
GOcomparison_alltime$name_GO <- paste0(GOcomparison_alltime$name, " - ", GOcomparison_alltime$GO)

GOcomparison_alltime_depth2 <- GOcomparison_alltime[GOcomparison_alltime$depth == "2",]
GOcomparison_alltime_depth3 <- GOcomparison_alltime[GOcomparison_alltime$depth == "3",]

#### make a heatmap to get general idea ####
library(ggplot2)
# use unique(file$column) to get list of x-axis labels
pdf("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA/geomtile_heatmaps_venncomparisons_clustergroups.pdf", height=11, width=8.5)
GOcomparison_alltime_depth2_BP <- GOcomparison_alltime_depth2[GOcomparison_alltime_depth2$NS == "BP",]
ggplot(GOcomparison_alltime_depth2_BP, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth2 for BP") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                         "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                         "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                         "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))
GOcomparison_alltime_depth3_BP <- GOcomparison_alltime_depth3[GOcomparison_alltime_depth3$NS == "BP",]
ggplot(GOcomparison_alltime_depth3_BP, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth3 for BP") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                                          "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                                          "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                                          "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))

GOcomparison_alltime_depth2_CC <- GOcomparison_alltime_depth2[GOcomparison_alltime_depth2$NS == "CC",]
ggplot(GOcomparison_alltime_depth2_CC, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth2 for CC") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                         "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                         "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                         "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))
GOcomparison_alltime_depth3_CC <- GOcomparison_alltime_depth3[GOcomparison_alltime_depth3$NS == "CC",]
ggplot(GOcomparison_alltime_depth3_CC, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth3 for CC") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                                          "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                                          "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                                          "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))

GOcomparison_alltime_depth2_MF <- GOcomparison_alltime_depth2[GOcomparison_alltime_depth2$NS == "MF",]
ggplot(GOcomparison_alltime_depth2_MF, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth2 for MF") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                                           "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                                           "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                                           "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))
GOcomparison_alltime_depth3_MF <- GOcomparison_alltime_depth3[GOcomparison_alltime_depth3$NS == "MF",]
ggplot(GOcomparison_alltime_depth3_MF, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth3 for MF") + scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi",
                                                                                                                          "F22_OA_3dpi", "F22_SA_3dpi","1314_SA_3dpi",
                                                                                                                          "F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi",
                                                                                                                          "F22_OA_11dpi", "F22_SA_11dpi","1314_SA_11dpi"))

dev.off()
#####
GOcomparison_alltime_depth3_MF_7dpi <- GOcomparison_alltime_depth3_MF[GOcomparison_alltime_depth3_MF$dpi == "_7dpi",]
ggplot(GOcomparison_alltime_depth3_MF_7dpi, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of cultivar-specific upregulated genes at depth2 for BP") + scale_x_discrete(limits=c("F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi"))
View(GOcomparison_alltime_depth2_BP_7dpi)




##### heatmaps and barcharts of interest ####
GOcomparison_interest_1dpi <- read_excel("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA/refined_GOcomparison_F22_OAnSA_1dpi.xlsx")
GOcomparison_interest_1dpi$`-log10(pfdr)` <- (-1*log10(GOcomparison_interest_1dpi$sp_fdr_bh))
GOcomparison_interest_1dpi$isolate_cultivar_dpi <- paste0(GOcomparison_interest_1dpi$isolate_cultivar, "_1dpi")
GOcomparison_interest_1dpi$isolate_cultivar_dpi_category <- paste0(GOcomparison_interest_1dpi$category, "_1dpi_", GOcomparison_interest_1dpi$isolate_cultivar)
GOcomparison_interest_1dpi$name_GO <- paste0(GOcomparison_interest_1dpi$name, " - ", GOcomparison_interest_1dpi$GO)

GOcomparison_interest_1dpi_depth2 <- GOcomparison_interest_1dpi[GOcomparison_interest_1dpi$depth == "2",]
ggplot(GOcomparison_interest_1dpi_depth2, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOcomparison_interest_1dpi_depth2")+ scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi"))

GOcomparison_interest_1dpi_depth3 <- GOcomparison_interest_1dpi[GOcomparison_interest_1dpi$depth == "3",]
ggplot(GOcomparison_interest_1dpi_depth3, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOcomparison_interest_1dpi_depth3")+ scale_x_discrete(limits=c("F22_OA_1dpi", "F22_SA_1dpi", "1314_SA_1dpi"))

GOcomparison_interest_1dpi_depth3_BP <- GOcomparison_interest_1dpi_depth3[GOcomparison_interest_1dpi_depth3$NS == "BP",]
ggplot(GOcomparison_interest_1dpi_depth3_BP, aes(y=`-log10(pfdr)`, x=isolate_cultivar_dpi_category)) + ylab('-log10(pfdr)')+theme_bw()+
  geom_col(aes(fill=`name_GO`)) + theme(legend.title = element_blank())  +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#EEEEEE"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
scale_x_discrete(limits = c("metabolism_1dpi_F22_OA", "metabolism_1dpi_F22_SA", "metabolism_1dpi_1314_SA",
                            "photosynthesis_1dpi_F22_OA", "photosynthesis_1dpi_F22_SA", "photosynthesis_1dpi_1314_SA",
                            "response_1dpi_F22_OA", "response_1dpi_F22_SA", "response_1dpi_1314_SA") )

GOcomparison_interest_1dpi_depth3_MF <- GOcomparison_interest_1dpi_depth3[GOcomparison_interest_1dpi_depth3$NS == "MF",]
ggplot(GOcomparison_interest_1dpi_depth3_MF, aes(y=`-log10(pfdr)`, x=isolate_cultivar_dpi_category)) + ylab('-log10(pfdr)')+theme_bw()+
  geom_col(aes(fill=`name_GO`)) + theme(legend.title = element_blank())  +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#EEEEEE"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  scale_x_discrete(limits = c("metabolism_1dpi_F22_OA", "metabolism_1dpi_F22_SA", "metabolism_1dpi_1314_SA",
                              "photosynthesis_1dpi_F22_OA", "photosynthesis_1dpi_F22_SA", "photosynthesis_1dpi_1314_SA",
                              "response_1dpi_F22_OA", "response_1dpi_F22_SA", "response_1dpi_1314_SA") )

  
  GOcomparison_interest_3dpi <- read_excel("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA/refined_GOcomparison_F22_OAnSA_3dpi.xlsx")
  GOcomparison_interest_3dpi$`-log10(pfdr)` <- (-1*log10(GOcomparison_interest_3dpi$sp_fdr_bh))
  GOcomparison_interest_3dpi$isolate_cultivar_dpi <- paste0(GOcomparison_interest_3dpi$isolate_cultivar, "_3dpi")
  GOcomparison_interest_3dpi$isolate_cultivar_dpi_category <- paste0(GOcomparison_interest_3dpi$category, "_3dpi_", GOcomparison_interest_3dpi$isolate_cultivar)
  GOcomparison_interest_3dpi$name_GO <- paste0(GOcomparison_interest_3dpi$name, " - ", GOcomparison_interest_3dpi$GO)
  
  GOcomparison_interest_3dpi_depth2 <- GOcomparison_interest_3dpi[GOcomparison_interest_3dpi$depth == "2",]
  ggplot(GOcomparison_interest_3dpi_depth2, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
    ggtitle(label = "GOcomparison_interest_3dpi_depth2")+ scale_x_discrete(limits=c("F22_OA_3dpi", "F22_SA_3dpi", "1314_SA_3dpi"))
  
  GOcomparison_interest_3dpi_depth3 <- GOcomparison_interest_3dpi[GOcomparison_interest_3dpi$depth == "3",]
  ggplot(GOcomparison_interest_3dpi_depth3, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
    ggtitle(label = "GOcomparison_interest_3dpi_depth3")+ scale_x_discrete(limits=c("F22_OA_3dpi", "F22_SA_3dpi", "1314_SA_3dpi"))
  
  GOcomparison_interest_3dpi_depth3_BP <- GOcomparison_interest_3dpi_depth3[GOcomparison_interest_3dpi_depth3$NS == "BP",]
  ggplot(GOcomparison_interest_3dpi_depth3_BP, aes(y=`-log10(pfdr)`, x=isolate_cultivar_dpi_category)) + ylab('-log10(pfdr)')+theme_bw()+
    geom_col(aes(fill=`name_GO`)) + theme(legend.title = element_blank())  +
    theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#EEEEEE"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
    scale_x_discrete(limits = c("metabolism_3dpi_F22_OA", "metabolism_3dpi_F22_SA", "metabolism_3dpi_1314_SA",
                                "photosynthesis_3dpi_F22_OA", "photosynthesis_3dpi_F22_SA", "photosynthesis_3dpi_1314_SA",
                                "response_3dpi_F22_OA", "response_3dpi_F22_SA", "response_3dpi_1314_SA") )
  
GOcomparison_interest_7dpi <- read_excel("~/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list/GOannotation/GOannotation_comparison_F22_OAnSA/refined_GOcomparison_F22_OAnSA_7dpi.xlsx")
GOcomparison_interest_7dpi$`-log10(pfdr)` <- (-1*log10(GOcomparison_interest_7dpi$sp_fdr_bh))
GOcomparison_interest_7dpi$isolate_cultivar_dpi <- paste0(GOcomparison_interest_7dpi$isolate_cultivar, "_7dpi")
GOcomparison_interest_7dpi$isolate_cultivar_dpi_category <- paste0(GOcomparison_interest_7dpi$category, "_7dpi_", GOcomparison_interest_7dpi$isolate_cultivar)
GOcomparison_interest_7dpi$name_GO <- paste0(GOcomparison_interest_7dpi$name, " - ", GOcomparison_interest_7dpi$GO)
  
GOcomparison_interest_7dpi_depth2 <- GOcomparison_interest_7dpi[GOcomparison_interest_7dpi$depth == "2",]
ggplot(GOcomparison_interest_7dpi_depth2, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOcomparison_interest_7dpi_depth2")+ scale_x_discrete(limits=c("F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi"))
  
GOcomparison_interest_7dpi_depth3 <- GOcomparison_interest_7dpi[GOcomparison_interest_7dpi$depth == "3",]
ggplot(GOcomparison_interest_7dpi_depth3, mapping = aes(x=isolate_cultivar_dpi,y=name_GO, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar_dpi") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOcomparison_interest_7dpi_depth3")+ scale_x_discrete(limits=c("F22_OA_7dpi", "F22_SA_7dpi", "1314_SA_7dpi"))
  
GOcomparison_interest_7dpi_depth3_BP <- GOcomparison_interest_7dpi_depth3[GOcomparison_interest_7dpi_depth3$NS == "BP",]
ggplot(GOcomparison_interest_7dpi_depth3_BP, aes(y=`-log10(pfdr)`, x=isolate_cultivar_dpi_category)) + ylab('-log10(pfdr)')+theme_bw()+
  geom_col(aes(fill=`name_GO`)) + theme(legend.title = element_blank())  +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#EEEEEE"),axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
  scale_x_discrete(limits = c("metabolism_7dpi_F22_OA", "metabolism_7dpi_F22_SA", "metabolism_7dpi_1314_SA",
                              "photosynthesis_7dpi_F22_OA", "photosynthesis_7dpi_F22_SA", "photosynthesis_7dpi_1314_SA",
                              "response_7dpi_F22_OA", "response_7dpi_F22_SA", "response_7dpi_1314_SA") )
  