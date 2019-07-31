library(readxl)

SA_F22v1314_LFC <- read_excel("/Users/rbadgami/Desktop/rectifyingLFCerror/SA_F22v1314_LFC.xlsx", sheet='Sheet1')
View(SA_F22v1314_LFC)
colnames(SA_F22v1314_LFC)
SA_F22v1314_LFC[is.na(SA_F22v1314_LFC)] <- 0



SA_F22v1314_LFC_1dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '1dpi',]
ggplot(SA_F22v1314_LFC, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=1.5) + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey')

SA_F22v1314_LFC_1dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '1dpi',]
View(SA_F22v1314_LFC_1dpi)
ggplot(SA_F22v1314_LFC_1dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=1.5,color='brown2') + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') + ggtitle('1 dpi') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 0.5,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='brown2') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -0.5,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='brown2')

SA_F22v1314_LFC_3dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '3dpi',]
View(SA_F22v1314_LFC_3dpi)
ggplot(SA_F22v1314_LFC_3dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=1.5,color='steelblue1') + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') +ggtitle('3 dpi') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 1,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='steelblue1') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -1,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='steelblue1')

SA_F22v1314_LFC_7dpi <- SA_F22v1314_LFC[SA_F22v1314_LFC$dpi == '7dpi',]
ggplot(SA_F22v1314_LFC_7dpi, aes(y=`log2FoldChange-F22v1314`, x=`log2FoldChange-SAvOA`, color=dpi, label=gene)) + geom_point(size=1.5,color='seagreen4') + theme_bw() +
  xlab('LFC for F22-infected Santiago vs Oakley') + ylab('LFC for Santiago infected by F22 vs 13/14') +
  geom_vline(xintercept=0, color='dark grey') + geom_hline(yintercept=0, color='dark grey') +ggtitle('7 dpi') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 4,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='seagreen4') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`> 1 & `log2FoldChange-SAvOA`> 4,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='seagreen4') +
  geom_text(aes(label=ifelse(`log2FoldChange-F22v1314`< -1,as.character(gene),'')),hjust=0.5,vjust=1.5, size=3, angle=10,color='seagreen4')
