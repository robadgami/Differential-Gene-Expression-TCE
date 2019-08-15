library(readxl)

SA_F22v1314_LFC <- read_excel("/Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_LFC.xlsx", sheet='Sheet1')
View(SA_F22v1314_LFC)
colnames(SA_F22v1314_LFC)
SA_F22v1314_LFC[is.na(SA_F22v1314_LFC)] <- 0

library(ggplot2)
# across the three timepoints
ggplot(SA_F22v1314_LFC, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=5, aes(fill=dpi),colour="black",pch=21) + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey')

# at 1 dpi
SA_F22v1314_LFC_1dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '1dpi',]
View(SA_F22v1314_LFC_1dpi)
ggplot(SA_F22v1314_LFC_1dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=annotated, label=gene)) + geom_point(size=5, aes(fill=annotated),colour="black",pch=21) + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') + ggtitle('1 dpi')
geom_label_repel(aes(label=ifelse(SA_F22v1314_LFC_1dpi$annotated == 'GO', as.character(`gene`),'')),
                 box.padding = 0.35, point.padding=0.5,segment.color='grey50', size=10)

 # geom_text(aes(label=ifelse(SA_F22v1314_LFC_1dpi$annotated != '0',as.character(gene),'')),hjust=0.6,vjust=1.5, size=8, angle=10)
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 0.5,as.character(gene),'')),hjust=0.6,vjust=1.5, size=8, angle=10) +
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -0.5,as.character(gene),'')),hjust=0.6,vjust=1.5, size=8, angle=10)

SA_F22v1314_LFC_3dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '3dpi',]
View(SA_F22v1314_LFC_3dpi)
ggplot(SA_F22v1314_LFC_3dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=annotated, label=gene)) + geom_point(size=5, aes(fill=annotated),colour="black",pch=21) + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') +ggtitle('3 dpi') 
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 1,as.character(gene),'')),hjust=0.5,vjust=1.6, size=3, angle=10) +
  #geom_text(aes(label=ifelse(`log2FoldChange-SAvOA`> -1,as.character(gene),'')),hjust=0.5,vjust=1.6, size=3, angle=90)
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -1,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10)

SA_F22v1314_LFC_7dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '7dpi',]
View(SA_F22v1314_LFC_7dpi)
ggplot(SA_F22v1314_LFC_7dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=5, aes(fill=dpi),colour="black",pch=21) + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') +ggtitle('7 dpi')
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 4,as.character(gene),'')),hjust=0.5,vjust=1.5, size=8, angle=10, color='black') +
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 1 & `log2FoldChange-SAvOA`> 4,as.character(gene),'')),hjust=0.5,vjust=1.5, size=8, angle=10,color='black') +
  #geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -1,as.character(gene),'')),hjust=0.5,vjust=1.5, size=8, angle=10,color='black')

