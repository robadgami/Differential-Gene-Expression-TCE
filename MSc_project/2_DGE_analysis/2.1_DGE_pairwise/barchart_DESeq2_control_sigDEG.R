# input data
library(readxl)
control_sig <- read_excel("/Volumes/RBADGAMI 1/control_sig.xlsx", 
                               sheet = "control")
colnames(control_sig)
control_sig$"gene_number_pfdr<0.05"=as.numeric(control_sig$"gene_number_pfdr<0.05")
control_sig$"old_pfdr<0.05"=as.numeric(control_sig$"old_pfdr<0.05")

# get appropriate colour scheme
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C"), c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA"))

# plot barchart of ttotal DEGs
library(ggplot2)
ggplot(data=control_sig, aes(x=isolate_cultivar_dpi, y=`gene_number_pfdr<0.05`, fill=isolate_cultivar)) + scale_fill_manual(values = irisColors)+
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "isolate-cultivar") + ylab("number significant DEGs") +xlab("isolate_cultivar_dpi") +
  geom_text(aes(label=`gene_number_pfdr<0.05`), vjust=0.5, hjust=1.25, color="black", size=3, angle=90) +
  scale_x_discrete(limits=c("F22_OA_01dpi", "F22_SO_01dpi", "F22_SA_01dpi",
                            "F22_OA_03dpi", "F22_SO_03dpi", "F22_SA_03dpi",
                            "F22_OA_07dpi", "F22_SO_07dpi", "F22_SA_07dpi",
                            "F22_OA_11dpi", "F22_SO_11dpi", "F22_SA_11dpi",
                            "1314_OA_01dpi", "1314_SO_01dpi", "1314_SA_01dpi",
                            "1314_OA_03dpi", "1314_SO_03dpi", "1314_SA_03dpi",
                            "1314_OA_07dpi", "1314_SO_07dpi", "1314_SA_07dpi",
                            "1314_OA_11dpi", "1314_SO_11dpi", "1314_SA_11dpi"))

#+ ylim(c(0, 62692)) + geom_hline(yintercept=57637, linetype="dashed", color = "orange") + geom_hline(yintercept= 53312, linetype="dashed", color = "purple")
  

# Venn Diagram
plot.new()
VennDiagram::draw.pairwise.venn(
  area1 = 51422,
  area2 = 55241,
  cross.area = 44666,
  category = c("F22", "1314"))
