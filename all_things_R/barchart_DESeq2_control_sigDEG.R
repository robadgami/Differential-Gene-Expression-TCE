# input data
library(readxl)
control_sig <- read_excel("/Volumes/RBADGAMI/control_sig.xlsx")
colnames(control_sig)
control_sig$`pfdr<0.05`=as.numeric(control_sig$`pfdr<0.05`)
control_sig$`percent pfdr`=as.numeric(control_sig$`percent pfdr`)
control_sig$`percent pfdr`=round(control_sig$`percent pfdr`,2)

# get appropriate colour scheme
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C"), c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA"))

# plot barchart of ttotal DEGs
library(ggplot2)
ggplot(data=control_sig, aes(x=concat, y=`pfdr<0.05`, fill=isolate_cultivar)) + scale_fill_manual(values = irisColors) +
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "isolate-cultivar") + ylab("number significant DEGs") +xlab("concat") +
  geom_text(aes(label=`percent pfdr`), vjust=0.5, hjust=1.25, color="black", size=3, angle=90) +
  scale_x_discrete(limits=c("F22_OA_01", "F22_SO_01", "F22_SA_01",
                            "F22_OA_03", "F22_SO_03", "F22_SA_03",
                            "F22_OA_07", "F22_SO_07", "F22_SA_07",
                            "F22_OA_11", "F22_SO_11", "F22_SA_11",
                            "1314_OA_01", "1314_SO_01", "1314_SA_01",
                            "1314_OA_03", "1314_SO_03", "1314_SA_03",
                            "1314_OA_07", "1314_SO_07", "1314_SA_07",
                            "1314_OA_11", "1314_SO_11", "1314_SA_11"))

#+ ylim(c(0, 62692)) + geom_hline(yintercept=57637, linetype="dashed", color = "orange") + geom_hline(yintercept= 53312, linetype="dashed", color = "purple")
  

# Venn Diagram
plot.new()
VennDiagram::draw.pairwise.venn(
  area1 = 53312,
  area2 = 57637,
  cross.area = 48257,
  category = c("F22", "1314"))
