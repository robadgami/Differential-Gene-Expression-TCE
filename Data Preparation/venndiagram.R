#install.packages('eulerr')
library('eulerr')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#A6CEE3", "#B2DF8A", "#FB9A99"),
                       c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA", "CON_SO", "CON_SA", "CON_OA"))

F22_1dpi <- euler(c('F22_OA'=1194,
              "F22_OA&F22_SO"=68,
              "F22_SO"=1249,
              "F22_SO&F22_SA"=119,
              "F22_SA"=743,
              "F22_SA&F22_OA"=259
              #"F22_SA&F22_OA&F22_SO"=7432
              ), shape="ellipse")
F22_3dpi <- euler(c('F22_OA'=680,
                    "F22_OA&F22_SO"=41,
                    "F22_SO"=769,
                    "F22_SO&F22_SA"=35,
                    "F22_SA"=264,
                    "F22_SA&F22_OA"=142
                    #"F22_SA&F22_OA&F22_SO"=9133
                    ), shape="ellipse")
F22_7dpi <- euler(c('F22_OA'=1885,
                    "F22_OA&F22_SO"=88,
                    "F22_SO"=695,
                    "F22_SO&F22_SA"=212,
                    "F22_SA"=2859,
                    "F22_SA&F22_OA"=251
                    #"F22_SA&F22_OA&F22_SO"=5074
), shape="ellipse")
F22_11dpi <- euler(c('F22_OA'=3221,
                    "F22_OA&F22_SO"=64,
                    "F22_SO"=345,
                    "F22_SO&F22_SA"=18,
                    "F22_SA"=708,
                    "F22_SA&F22_OA"=81
                    #"F22_SA&F22_OA&F22_SO"=6627
), shape="ellipse")

library(ggpubr)
x1314_1dpi <- euler(c('1314_OA'=1398,
                    '1314_OA&1314_SO'=109,
                    '1314_SO'=763,
                    '1314_SO&1314_SA'=96,
                    '1314_SA'=1398,
                    '1314_SA&1314_OA'=318), shape="ellipse")
                    #"1314_SA&1314_OA&1314_SO"=9285

x1314_3dpi <- euler(c('1314_OA'=450,
                    "1314_OA&1314_SO"=61,
                    "1314_SO"=322,
                    "1314_SO&1314_SA"=25,
                    "1314_SA"=342,
                    "1314_SA&1314_OA"=148
                    #"1314_SA&1314_OA&1314_SO"=9133
), shape="ellipse")
x1314_7dpi <- euler(c('1314_OA'=710,
                    "1314_OA&1314_SO"=50,
                    "1314_SO"=293,
                    "1314_SO&1314_SA"=32,
                    "1314_SA"=1581,
                    "1314_SA&1314_OA"=141
                    #"1314_SA&1314_OA&1314_SO"=5074
), shape="ellipse")
x1314_11dpi <- euler(c('1314_OA'=451,
                     "1314_OA&1314_SO"=34,
                     "1314_SO"=336,
                     "1314_SO&1314_SA"=35,
                     "1314_SA"=722,
                     "1314_SA&1314_OA"=201
                     #"1314_SA&1314_OA&1314_SO"=6627
), shape="ellipse")

venn.F22_1dpi<- plot(F22_1dpi, main="F22_1dpi", quantities=TRUE, fills= list(fill= c("#E31A1C","#1F78B4","#33A02C")))
venn.F22_3dpi<- plot(F22_3dpi, main="F22_3dpi", quantities=TRUE, fills= list(fill= c("#E31A1C","#1F78B4","#33A02C")))
venn.F22_7dpi<- plot(F22_7dpi, main="F22_7dpi", quantities=TRUE, fills= list(fill= c("#E31A1C","#1F78B4","#33A02C")))
venn.F22_11dpi<- plot(F22_11dpi, main="F22_11dpi", quantities=TRUE, fills= list(fill= c("#E31A1C","#1F78B4","#33A02C")))
venn.x1314_1dpi <- plot(x1314_1dpi, main="1314_1dpi", quantities=TRUE, fills= list(fill= c("#FB9A99","#A6CEE3","#B2DF8A")))
venn.x1314_3dpi <- plot(x1314_3dpi, main="1314_3dpi", quantities=TRUE, fills= list(fill= c("#FB9A99","#A6CEE3","#B2DF8A")))
venn.x1314_7dpi <- plot(x1314_7dpi, main="1314_7dpi", quantities=TRUE, fills= list(fill= c("#FB9A99","#A6CEE3","#B2DF8A")))
venn.x1314_11dpi <- plot(x1314_11dpi, main="1314_11dpi", quantities=TRUE, fills= list(fill= c("#FB9A99","#A6CEE3","#B2DF8A")))
ggarrange(venn.F22_1dpi,venn.x1314_1dpi, venn.F22_3dpi,venn.x1314_3dpi, labels = c("A", "B", "C", "D"), ncol=2, nrow=2)
ggarrange(venn.F22_7dpi,venn.x1314_7dpi, venn.F22_11dpi,  venn.x1314_11dpi, labels = c("E", "F", "G", "H"),ncol = 2, nrow = 2)

