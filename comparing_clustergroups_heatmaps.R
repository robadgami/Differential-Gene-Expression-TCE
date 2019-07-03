library(readxl)
group1_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C6_SO_C12_OA_C6.xlsx")
group2_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C14_SO_NA_OA_C12.xlsx")
group3_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C0_SO_C0_OA_C0.xlsx")
group4_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_NA_SO_C15_OA_C5.xlsx")
group5_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C7_SO_C4_OA_C7.xlsx")
group6_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C13_SO_C6_OA_NA.xlsx")
group7_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C12_SO_NA_OA_NA.xlsx")
group8_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C15_SO_NA_OA_C5.xlsx")
group9_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C5_SO_C11_OA_C4.xlsx")
group10_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C9_SO_C2_OA_C9.xlsx")

# find -log10(pfdr)
group1_long$`-log10(pfdr)` <- -1*log10(group1_long$p_fdr_bh)
group2_long$`-log10(pfdr)` <- -1*log10(group2_long$p_fdr_bh)
group3_long$`-log10(pfdr)` <- -1*log10(group3_long$p_fdr_bh)
group4_long$`-log10(pfdr)` <- -1*log10(group4_long$p_fdr_bh)
group5_long$`-log10(pfdr)` <- -1*log10(group5_long$p_fdr_bh)
group6_long$`-log10(pfdr)` <- -1*log10(group6_long$p_fdr_bh)
group7_long$`-log10(pfdr)` <- -1*log10(group7_long$p_fdr_bh)
group8_long$`-log10(pfdr)` <- -1*log10(group8_long$p_fdr_bh)
group9_long$`-log10(pfdr)` <- -1*log10(group9_long$p_fdr_bh)
group10_long$`-log10(pfdr)` <- -1*log10(group10_long$p_fdr_bh)
# remove unnecessary columns
group1_long$p_fdr_bh <- NULL; group1_long$ratio_in_study <- NULL; group1_long$study_count <- NULL; group1_long$GO <- NULL; group1_long$name <-NULL
colnames(group1_long)
group2_long$p_fdr_bh <- NULL; group2_long$ratio_in_study <- NULL; group2_long$study_count <- NULL; group2_long$GO <- NULL; group2_long$name <-NULL
colnames(group2_long)
group3_long$p_fdr_bh <- NULL; group3_long$ratio_in_study <- NULL; group3_long$study_count <- NULL; group3_long$GO <- NULL; group3_long$name <-NULL
colnames(group3_long)
group4_long$p_fdr_bh <- NULL; group4_long$ratio_in_study <- NULL; group4_long$study_count <- NULL; group4_long$GO <- NULL; group4_long$name <-NULL
colnames(group4_long)
group5_long$p_fdr_bh <- NULL; group5_long$ratio_in_study <- NULL; group5_long$study_count <- NULL; group5_long$GO <- NULL; group5_long$name <-NULL
colnames(group5_long)
group6_long$p_fdr_bh <- NULL; group6_long$ratio_in_study <- NULL; group6_long$study_count <- NULL; group6_long$GO <- NULL; group6_long$name <-NULL
colnames(group6_long)
group7_long$p_fdr_bh <- NULL; group7_long$ratio_in_study <- NULL; group7_long$study_count <- NULL; group7_long$GO <- NULL; group7_long$name <-NULL
colnames(group7_long)
group8_long$p_fdr_bh <- NULL; group8_long$ratio_in_study <- NULL; group8_long$study_count <- NULL; group8_long$GO <- NULL; group8_long$name <-NULL
colnames(group8_long)
group9_long$p_fdr_bh <- NULL; group9_long$ratio_in_study <- NULL; group9_long$study_count <- NULL; group9_long$GO <- NULL; group9_long$name <-NULL
colnames(group9_long)
group10_long$p_fdr_bh <- NULL; group10_long$ratio_in_study <- NULL; group10_long$study_count <- NULL; group10_long$GO <- NULL; group10_long$name <-NULL
colnames(group10_long)
# make long to wide - if exact
#library(tidyr)
#group1_wide <- spread (group1_long, isolate_cultivar, `-log10(pfdr)`)
#View(group1_wide)

# Choosing colours
#library(RColorBrewer)
#display.brewer.all(colorblindFriendly = TRUE)
#display.brewer.pal(8, name = 'Oranges')
#brewer.pal(8, name = 'Oranges')

# make heatmap
group1_long_depth2 <- group1_long[group1_long$depth == '2',]
group2_long_depth2 <- group2_long[group2_long$depth == '2',]
group3_long_depth2 <- group3_long[group3_long$depth == '2',]
group4_long_depth2 <- group4_long[group4_long$depth == '2',]
group5_long_depth2 <- group5_long[group5_long$depth == '2',]
group6_long_depth2 <- group6_long[group6_long$depth == '2',]
group7_long_depth2 <- group7_long[group7_long$depth == '2',]
group8_long_depth2 <- group7_long[group8_long$depth == '2',]
group9_long_depth2 <- group9_long[group9_long$depth == '2',]
group10_long_depth2 <- group10_long[group10_long$depth == '2',]

### but i want to make a heatmap that can cluster
library(ggplot2)
library(reshape2)
pdf("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/geomtile_heatmaps_depth2_clustergroups.pdf", height=11, width=8.5)
ggplot(group1_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group1 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group2_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group2 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SA"))

ggplot(group3_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group3 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group4_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group4 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group5_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group5 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group6_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group6 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group7_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group7 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group8_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group8 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group9_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group9 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group10_long_depth2, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group10 at depth2") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))
dev.off()

# make heatmap
group1_long_depth3 <- group1_long[group1_long$depth == '3',]
group2_long_depth3 <- group2_long[group2_long$depth == '3',]
group3_long_depth3 <- group3_long[group3_long$depth == '3',]
group4_long_depth3 <- group4_long[group4_long$depth == '3',]
group5_long_depth3 <- group5_long[group5_long$depth == '3',]
group6_long_depth3 <- group6_long[group6_long$depth == '3',]
group7_long_depth3 <- group7_long[group7_long$depth == '3',]
group8_long_depth3 <- group7_long[group8_long$depth == '3',]
group9_long_depth3 <- group9_long[group9_long$depth == '3',]
group10_long_depth3 <- group10_long[group10_long$depth == '3',]

### but i want to make a heatmap that can cluster
library(ggplot2)
library(reshape2)
pdf("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/geomtile_heatmaps_depth3_clustergroups.pdf", height=11, width=8.5)
ggplot(group1_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group1 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group2_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group2 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SA"))

ggplot(group3_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group3 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group4_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group4 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group5_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group5 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group6_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group6 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group7_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group7 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group8_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group8 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group9_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group9 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))

ggplot(group10_long_depth3, mapping = aes(x=isolate_cultivar,y=`name-GO`, fill=`-log10(pfdr)`)) + geom_tile() + xlab(label = "isolate_cultivar") + facet_grid(NS ~ ., scales ="free", space = "free") + scale_fill_gradient(name = "-log10(pfdr)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() + theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of group10 at depth3") + scale_x_discrete(limits=c("F22_OA","F22_SO","F22_SA"))
dev.off()

# make barcharts fpr depth3 for BP
group1_long <- read_excel("~/Desktop/data2/GOenrichment/comparing_cluster_graphing/GO_sigfdr_table_F22_SA_C6_SO_C12_OA_C6.xlsx")
group1_long_depth3 <- group1_long[group1_long$depth == '3',]
group1_long_depth3_BP <- group1_long_depth3[group1_long_depth3$NS == 'BP',]
colnames(group1_long_depth3_BP)
group1_long_depth3_BP$GO <- NULL; group1_long_depth3_BP$ratio_in_study <- NULL; group1_long_depth3_BP$study_count <- NULL; group1_long_depth3_BP$name <- NULL
group1_long_depth3_BP$`-log10(pfdr)` <- (-1*log10(group1_long_depth3_BP$p_fdr_bh))
group1_long_depth3_BP$sample_category <- paste0(group1_long_depth3_BP$isolate_cultivar,"-",group1_long_depth3_BP$category)
group1_long_depth3_BP$p_fdr_bh <- NULL
colnames(group1_long_depth3_BP)
View(group1_long_depth3_BP)
group1_long_depth3_BP_F22_OA <- group1_long_depth3_BP[group1_long_depth3_BP$isolate_cultivar == 'F22_OA',]
group1_long_depth3_BP_F22_SO <- group1_long_depth3_BP[group1_long_depth3_BP$isolate_cultivar == 'F22_SO',]
group1_long_depth3_BP_F22_SA <- group1_long_depth3_BP[group1_long_depth3_BP$isolate_cultivar == 'F22_SA',]
plot.new()
ggplot(group1_long_depth3_BP, aes(y=`-log10(pfdr)`, x=sample_category)) + geom_col(aes(fill=`name-GO`)) +
  theme(legend.title = element_blank()) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
        