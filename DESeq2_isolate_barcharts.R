#import dataset
library(readxl)
isolate_long <- read_excel("/Volumes/RBADGAMI 1/control_sig.xlsx", sheet = "isolate_long")
colnames(isolate_long)
isolate_long$LFC_gene_number = as.numeric(isolate_long$LFC_gene_number)

# get appropriate colour scheme
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#A6CEE3", "#B2DF8A", "#FB9A99"),
                       c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA", "CON_SO", "CON_SA", "CON_OA"))

#
library(ggplot2)


col=c(
"#FB9A99", "#FB9A99", "#A6CEE3", "#FB9A99", "#FB9A99", "#A6CEE3", "#FB9A99", "#FB9A99", "#A6CEE3", "#FB9A99", "#FB9A99", "#A6CEE3",
"#E31A1C", "#E31A1C", "#1F78B4", "#E31A1C", "#E31A1C", "#1F78B4", "#E31A1C", "#E31A1C", "#1F78B4", "#E31A1C", "#E31A1C", "#1F78B4",
"#B2DF8A","#A6CEE3","#B2DF8A", "#B2DF8A","#A6CEE3","#B2DF8A", "#B2DF8A","#A6CEE3","#B2DF8A", "#B2DF8A","#A6CEE3","#B2DF8A",
"#33A02C", "#1F78B4", "#B2DF8A", "#33A02C", "#1F78B4", "#B2DF8A", "#33A02C", "#1F78B4", "#B2DF8A", "#33A02C", "#1F78B4", "#B2DF8A")




ggplot(isolate_long, aes(x=factor(isolate_comparison_dpi), y=LFC_gene_number, fill=factor(type)))  +
  geom_bar(stat="identity", fill=col) + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "type") + ylab("total number significant DEGs") +xlab("cultivar comparisons") +
  geom_text(aes(label=`LFC_gene_number`), vjust=0.5, hjust=1.25, color="black", size=3, inherit.aes = TRUE) +
  scale_x_discrete(limits=c("1314_11dpi_OAvSA","1314_11dpi_OAvSO","1314_11dpi_SOvSA",
                            "1314_7dpi_OAvSA","1314_7dpi_OAvSO","1314_7dpi_SOvSA",
                            "1314_3dpi_OAvSA","1314_3dpi_OAvSO","1314_3dpi_SOvSA",
                            "1314_1dpi_OAvSA","1314_1dpi_OAvSO","1314_1dpi_SOvSA",
                            "F22_11dpi_OAvSA","F22_11dpi_OAvSO","F22_11dpi_SOvSA",
                            "F22_7dpi_OAvSA", "F22_7dpi_OAvSO","F22_7dpi_SOvSA",
                            "F22_3dpi_OAvSA","F22_3dpi_OAvSO","F22_3dpi_SOvSA",
                            "F22_1dpi_OAvSA","F22_1dpi_OAvSO","F22_1dpi_SOvSA")) + coord_flip()

# Venn Diagram
plot.new()
VennDiagram::draw.pairwise.venn(
  area1 = 19046,
  area2 = 9439,
  cross.area = 6158,
  category = c("F22", "1314"))
