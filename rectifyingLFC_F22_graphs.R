library(readxl)
GOcomparison_rectifyingLFC <- read_excel("/Users/rbadgami/Desktop/rectifyingLFCerror/GOannotation/table_p0.05_depth3_collated.xlsx")
head(GOcomparison_rectifyingLFC)

GOcomparison_rectifyingLFC$`-log10(respective p-value)` <- (-1*log10(GOcomparison_rectifyingLFC$`p-to-use`))
GOcomparison_rectifyingLFC$isolate_cultivar_dpi <- paste0("F22_",GOcomparison_rectifyingLFC$cultivar,"_",GOcomparison_rectifyingLFC$dpi)
GOcomparison_rectifyingLFC$isolate_cultivar <- paste0("F22_",GOcomparison_rectifyingLFC$cultivar)
GOcomparison_rectifyingLFC$name_GO <- paste0(GOcomparison_rectifyingLFC$name, " - ", GOcomparison_rectifyingLFC$GO)
GOcomparison_rectifyingLFC$NS_name_GO <- paste0(GOcomparison_rectifyingLFC$NS, ": ",GOcomparison_rectifyingLFC$name, " - ", GOcomparison_rectifyingLFC$GO)
GOcomparison_rectifyingLFC$percentage_assigned_genes <- (GOcomparison_rectifyingLFC$assigned_genes/GOcomparison_rectifyingLFC$total_genes*100)



library(ggplot2)
ggplot(GOcomparison_rectifyingLFC, mapping = aes(x=isolate_cultivar_dpi,y=NS_name_GO, fill=`-log10(respective p-value)`)) + geom_tile() +
  facet_grid(criteria ~ dpi, scales ="free", space = "free") + scale_fill_gradient(name = "-log10(respective p-value)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() +
    theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm fitting criteria")

GOcomparison_rectifyingLFC_1dpi <- GOcomparison_rectifyingLFC[GOcomparison_rectifyingLFC$dpi == "1dpi",]
ggplot(GOcomparison_rectifyingLFC_1dpi, mapping = aes(x=isolate_cultivar_dpi,y=NS_name_GO, fill=`-log10(respective p-value)`)) + geom_tile() +
  facet_grid(criteria ~ dpi, scales ="free", space = "free") + scale_fill_gradient(name = "-log10(respective p-value)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm fitting criteria at 1dpi")
ggplot(GOcomparison_rectifyingLFC_1dpi, aes(y=percentage_assigned_genes,x=reorder(name_GO,assigned_genes),fill=isolate_cultivar)) + geom_bar(stat='identity',,position = "dodge") + coord_flip() +
  facet_grid(criteria + NS~ ., scales ="free", space = "free") + theme_bw() +
  ggtitle(label = "GOterm fitting criteria at 1dpi")

GOcomparison_rectifyingLFC_3dpi <- GOcomparison_rectifyingLFC[GOcomparison_rectifyingLFC$dpi == "3dpi",]
ggplot(GOcomparison_rectifyingLFC_3dpi, mapping = aes(x=isolate_cultivar_dpi,y=NS_name_GO, fill=`-log10(respective p-value)`)) + geom_tile() +
  facet_grid(criteria ~ dpi, scales ="free", space = "free") + scale_fill_gradient(name = "-log10(respective p-value)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm fitting criteria at 3dpi")
ggplot(GOcomparison_rectifyingLFC_3dpi, aes(y=percentage_assigned_genes,x=reorder(name_GO,assigned_genes),fill=isolate_cultivar)) + geom_bar(stat='identity',,position = "dodge") + coord_flip() +
  facet_grid(criteria + NS~ ., scales ="free", space = "free") + theme_bw() +
  ggtitle(label = "GOterm fitting criteria at 3dpi") + xlab('percentage assigned genes , %')

GOcomparison_rectifyingLFC_7dpi <- GOcomparison_rectifyingLFC[GOcomparison_rectifyingLFC$dpi == "7dpi",]
ggplot(GOcomparison_rectifyingLFC_7dpi, mapping = aes(x=isolate_cultivar_dpi,y=NS_name_GO, fill=`-log10(respective p-value)`)) + geom_tile() +
  facet_grid(criteria ~ dpi, scales ="free", space = "free") + scale_fill_gradient(name = "-log10(respective p-value)", low = "#FEE6CE",high = "#8C2D04") + theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),axis.title.y = element_blank(),strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"), axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm fitting criteria at 7dpi")
ggplot(GOcomparison_rectifyingLFC_7dpi, aes(y=percentage_assigned_genes,x=reorder(name_GO,assigned_genes),fill=isolate_cultivar)) + geom_bar(stat='identity',,position = "dodge") + coord_flip() +
  facet_grid(criteria + NS~ ., scales ="free", space = "free") + theme_bw() +
  ggtitle(label = "GOterm fitting criteria at 7dpi")
