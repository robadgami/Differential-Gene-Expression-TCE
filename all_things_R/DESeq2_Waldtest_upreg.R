

DESeq2_Wald <- read_excel("/Volumes/RBADGAMI/control_sig.xlsx", 
                               sheet = "comparison")
View(DESeq2_Wald)
head(DESeq2_Wald)
DESeq2_Wald$gene_number=as.numeric(DESeq2_Wald$gene_number)


library(ggplot2)

ggplot(DESeq2_Wald, aes(x=concat, y=gene_number, fill=upreg)) + geom_bar(stat="identity") +theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
 ylab("number significant DEGs") +xlab("cultivar comparison") +theme_linedraw() +
  geom_text(aes(label = gene_number), size = 3, hjust = 1, angle=90, position = "stack")
+
  scale_x_discrete(limits=c("F22_01_SAvOA","F22_01_SAvSO","F22_01_SOvOA",
                            "F22_03_SAvOA","F22_03_SAvSO","F22_03_SOvOA",
                            "F22_07_SAvOA","F22_07_SAvSO","F22_07_SOvOA",
                            "F22_11_SAvOA","F22_11_SAvSO","F22_11_SOvOA",
                            "1314_01_SAvOA","1314_01_SAvSO","1314_01_SOvOA",
                            "1314_03_SAvOA"," 1314_03_SAvSO","1314_03_SOvOA",
                            "1314_07_SAvOA","1314_07_SAvSO"," 1314_07_SOvOA",
                            "1314_11_SAvOA","1314_11_SAvSO","1314_11_SOvOA"))

plot.new()
VennDiagram::draw.pairwise.venn(
  area1 = 23225,
  area2 = 11569,
  cross.area = 7442,
  category = c("F22", "1314"))                          


  
  