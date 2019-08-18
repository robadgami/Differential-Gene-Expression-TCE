
library(readxl)
library(ggplot2)
library(ggrepel)

display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 8, name = 'Set2')
brewer.pal(n = 8, name = 'Set2')

#### import sheet and sort columns as appropriate ###
#rectifyingLFC_upregLFC <- read_excel('C:/Users/rbadg/OneDrive/Desktop/rectifyingLFC_upregLFC.xlsx', sheet ='Sheet3')
rectifyingLFC_upregLFC <- read_excel('/Users/rbadgami/Documents/Differential-expression/Differential-Gene-Expression-TCE/Functional Annotation/rectifyingLFC_upregLFC.xlsx', sheet ='Sheet3')
View(rectifyingLFC_upregLFC)
rectifyingLFC_upregLFC$`log2FoldChange-CON`<- as.numeric(rectifyingLFC_upregLFC$`log2FoldChange-CON`)
rectifyingLFC_upregLFC$`log2FoldChange-SAvOA` <- as.numeric(rectifyingLFC_upregLFC$`log2FoldChange-SAvOA`)
rectifyingLFC_upregLFC$GO_descriptioncriteria <- paste0(rectifyingLFC_upregLFC$GO, '-', rectifyingLFC_upregLFC$decsriptioncriteria)
rectifyingLFC_upregLFC[is.na(rectifyingLFC_upregLFC)] <- 0

#### quick overview of all point ####
ggplot(rectifyingLFC_upregLFC, aes(x=`log2FoldChange-CON`, y=`log2FoldChange-SAvOA`, colour=dpi, label=`gene`)) + geom_point(size=1) +
  theme_bw() +
  geom_vline(xintercept=0, colour='dark grey') + geom_hline(yintercept=0, colour='dark grey') +
    geom_label_repel(aes(label=ifelse((`log2FoldChange-SAvOA` > 5 & `log2FoldChange-CON` > 0) | (`log2FoldChange-CON` > 5 & `log2FoldChange-SAvOA` > 1), as.character(`gene`),'')), box.padding = 0.35,
                   point.padding=0.5,
                   segment.color='grey50')

#### LFC for 1 dpi ####
rectifyingLFC_upregLFC_1dpi <- rectifyingLFC_upregLFC[rectifyingLFC_upregLFC$dpi=='1 dpi',]
rectifyingLFC_upregLFC_1dpi_SA <- rectifyingLFC_upregLFC_1dpi[which(rectifyingLFC_upregLFC_1dpi$`log2FoldChange-SAvOA` >0), ]

ggplot(rectifyingLFC_upregLFC_1dpi_SA, aes(x=`log2FoldChange-CON`, y=`log2FoldChange-SAvOA`, colour=GO_descriptioncriteria, label=`gene`)) + geom_point(size=5, aes(fill=GO_descriptioncriteria),colour="black",pch=21) +
  theme_bw() + xlab('LFC of F22-SA vs CON-SA') + ylab('LFC of F22-SA vs F22-OA') +
  geom_vline(xintercept=0, colour='dark grey', linetype='dashed') + geom_hline(yintercept=0, colour='dark grey', linetype='dashed') +
geom_label_repel(aes(label=ifelse(rectifyingLFC_upregLFC_1dpi_SA$GO_descriptioncriteria != 'NA-NA', as.character(`gene`),'')), box.padding = 0.35, point.padding=0.5,segment.color='grey50', size=6)+ theme(
  axis.text=element_text(size=10))

#### LFC for 3 dpi ####
rectifyingLFC_upregLFC_3dpi <- rectifyingLFC_upregLFC[rectifyingLFC_upregLFC$dpi=='3 dpi',]
rectifyingLFC_upregLFC_3dpi_SA <- rectifyingLFC_upregLFC_3dpi[which(rectifyingLFC_upregLFC_3dpi$`log2FoldChange-SAvOA` >0), ]

ggplot(rectifyingLFC_upregLFC_3dpi_SA, aes(x=`log2FoldChange-CON`, y=`log2FoldChange-SAvOA`, colour=GO_descriptioncriteria, label=`gene`)) + geom_point(size=5, aes(fill=GO_descriptioncriteria),colour="black",pch=21) +
  theme_bw() + xlab('LFC of F22-SA vs CON-SA') + ylab('LFC of F22-SA vs F22-OA') +
  geom_vline(xintercept=0, colour='dark grey', linetype='dashed') + geom_hline(yintercept=0, colour='dark grey', linetype='dashed') +
  geom_label_repel(aes(label=ifelse(rectifyingLFC_upregLFC_3dpi_SA$GO != '0', as.character(`gene`),'')), box.padding = 0.35,
                   point.padding=0.5, force = 8,
                   segment.color='grey50', size=6) + theme(
                     axis.text=element_text(size=10))

