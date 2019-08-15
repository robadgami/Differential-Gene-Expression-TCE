dir.create("data")
dir.create("output")
##### F22_OA_depth2 ####
library(dplyr)
table_neglog10_F22_OA_relevant_depth2 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_OA/table_neglog10_F22_OA_relevant_depth2.xlsx")
View(table_neglog10_F22_OA_relevant_depth2)

names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C0)"] <- "-log10(F22_OA_C00)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C1)"] <- "-log10(F22_OA_C01)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C2)"] <- "-log10(F22_OA_C02)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C3)"] <- "-log10(F22_OA_C03)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C4)"] <- "-log10(F22_OA_C04)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C5)"] <- "-log10(F22_OA_C05)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C6)"] <- "-log10(F22_OA_C06)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C7)"] <- "-log10(F22_OA_C07)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C8)"] <- "-log10(F22_OA_C08)"
names(table_neglog10_F22_OA_relevant_depth2)[names(table_neglog10_F22_OA_relevant_depth2)=="-log10(F22_OA_C9)"] <- "-log10(F22_OA_C09)"
colnames(table_neglog10_F22_OA_relevant_depth2)

str(table_neglog10_F22_OA_relevant_depth2)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_OA_relevant_depth2$relevant <- NULL
table_neglog10_F22_OA_relevant_depth2$depth <- NULL

table_neglog10_F22_OA_relevant_depth2 <- table_neglog10_F22_OA_relevant_depth2[c("name", "GO", "NS", "-log10(F22_OA_C00)" ,"-log10(F22_OA_C01)" , "-log10(F22_OA_C02)" , "-log10(F22_OA_C03)" , "-log10(F22_OA_C04)" ,"-log10(F22_OA_C05)" , "-log10(F22_OA_C06)" , "-log10(F22_OA_C07)" , "-log10(F22_OA_C08)" ,"-log10(F22_OA_C09)" , "-log10(F22_OA_C10)", "-log10(F22_OA_C11)", "-log10(F22_OA_C12)","-log10(F22_OA_C13)", "-log10(F22_OA_C14)", "-log10(F22_OA_C15)")]
#table_neglog10_F22_OA_relevant_depth2 <- table_neglog10_F22_OA_relevant_depth2[order(table_neglog10_F22_OA_relevant_depth2$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_OA_relevant_depth2.long <- gather(data=table_neglog10_F22_OA_relevant_depth2, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_OA_relevant_depth2.long <- gather(data=table_neglog10_F22_OA_relevant_depth2, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_OA_relevant_depth2.long)
table_neglog10_F22_OA_relevant_depth2.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_OA_relevant_depth2.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_OA_relevant_depth2.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_OA_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth2.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_OA at depth2") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_OA_relevant_depth2.long$Cluster))))


table_neglog10_F22_OA_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth2.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_OA at depth2") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_OA_relevant_depth2.long$Cluster)))

# draw plot
table_neglog10_F22_OA_relevant_depth2.heatmap

##### F22_SO_depth2 ####
library(dplyr)
table_neglog10_F22_SO_relevant_depth2 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SO/table_neglog10_F22_SO_relevant_depth2.xlsx")
View(table_neglog10_F22_SO_relevant_depth2)

names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C0)"] <- "-log10(F22_SO_C00)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C1)"] <- "-log10(F22_SO_C01)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C2)"] <- "-log10(F22_SO_C02)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C3)"] <- "-log10(F22_SO_C03)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C4)"] <- "-log10(F22_SO_C04)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C5)"] <- "-log10(F22_SO_C05)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C6)"] <- "-log10(F22_SO_C06)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C7)"] <- "-log10(F22_SO_C07)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C8)"] <- "-log10(F22_SO_C08)"
names(table_neglog10_F22_SO_relevant_depth2)[names(table_neglog10_F22_SO_relevant_depth2)=="-log10(F22_SO_C9)"] <- "-log10(F22_SO_C09)"
colnames(table_neglog10_F22_SO_relevant_depth2)

str(table_neglog10_F22_SO_relevant_depth2)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SO_relevant_depth2$relevant <- NULL
table_neglog10_F22_SO_relevant_depth2$depth <- NULL

table_neglog10_F22_SO_relevant_depth2 <- table_neglog10_F22_SO_relevant_depth2[c("name", "GO", "NS", "-log10(F22_SO_C00)" ,"-log10(F22_SO_C01)" , "-log10(F22_SO_C02)" , "-log10(F22_SO_C03)" , "-log10(F22_SO_C04)" ,"-log10(F22_SO_C05)" , "-log10(F22_SO_C06)" , "-log10(F22_SO_C07)" , "-log10(F22_SO_C08)" ,"-log10(F22_SO_C09)" , "-log10(F22_SO_C10)", "-log10(F22_SO_C11)", "-log10(F22_SO_C12)","-log10(F22_SO_C13)", "-log10(F22_SO_C14)", "-log10(F22_SO_C15)")]
#table_neglog10_F22_SO_relevant_depth2 <- table_neglog10_F22_SO_relevant_depth2[order(table_neglog10_F22_SO_relevant_depth2$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SO_relevant_depth2.long <- gather(data=table_neglog10_F22_SO_relevant_depth2, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SO_relevant_depth2.long <- gather(data=table_neglog10_F22_SO_relevant_depth2, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SO_relevant_depth2.long)
table_neglog10_F22_SO_relevant_depth2.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SO_relevant_depth2.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SO_relevant_depth2.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SO_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth2.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SO at depth2") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SO_relevant_depth2.long$Cluster))))


table_neglog10_F22_SO_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth2.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SO at depth2") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SO_relevant_depth2.long$Cluster)))

# draw plot
table_neglog10_F22_SO_relevant_depth2.heatmap

##### F22_SA_depth2 ####
library(dplyr)
table_neglog10_F22_SA_relevant_depth2 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SA/table_neglog10_F22_SA_relevant_depth2.xlsx")
View(table_neglog10_F22_SA_relevant_depth2)

names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C0)"] <- "-log10(F22_SA_C00)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C1)"] <- "-log10(F22_SA_C01)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C2)"] <- "-log10(F22_SA_C02)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C3)"] <- "-log10(F22_SA_C03)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C4)"] <- "-log10(F22_SA_C04)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C5)"] <- "-log10(F22_SA_C05)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C6)"] <- "-log10(F22_SA_C06)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C7)"] <- "-log10(F22_SA_C07)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C8)"] <- "-log10(F22_SA_C08)"
names(table_neglog10_F22_SA_relevant_depth2)[names(table_neglog10_F22_SA_relevant_depth2)=="-log10(F22_SA_C9)"] <- "-log10(F22_SA_C09)"
colnames(table_neglog10_F22_SA_relevant_depth2)

str(table_neglog10_F22_SA_relevant_depth2)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SA_relevant_depth2$relevant <- NULL
table_neglog10_F22_SA_relevant_depth2$depth <- NULL

table_neglog10_F22_SA_relevant_depth2 <- table_neglog10_F22_SA_relevant_depth2[c("name", "GO", "NS", "-log10(F22_SA_C00)" ,"-log10(F22_SA_C01)" , "-log10(F22_SA_C02)" , "-log10(F22_SA_C03)" , "-log10(F22_SA_C04)" ,"-log10(F22_SA_C05)" , "-log10(F22_SA_C06)" , "-log10(F22_SA_C07)" , "-log10(F22_SA_C08)" ,"-log10(F22_SA_C09)" , "-log10(F22_SA_C10)", "-log10(F22_SA_C11)", "-log10(F22_SA_C12)","-log10(F22_SA_C13)", "-log10(F22_SA_C14)", "-log10(F22_SA_C15)")]
#table_neglog10_F22_SA_relevant_depth2 <- table_neglog10_F22_SA_relevant_depth2[order(table_neglog10_F22_SA_relevant_depth2$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SA_relevant_depth2.long <- gather(data=table_neglog10_F22_SA_relevant_depth2, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SA_relevant_depth2.long <- gather(data=table_neglog10_F22_SA_relevant_depth2, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SA_relevant_depth2.long)
table_neglog10_F22_SA_relevant_depth2.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SA_relevant_depth2.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SA_relevant_depth2.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SA_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth2.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SA at depth2") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SA_relevant_depth2.long$Cluster))))


table_neglog10_F22_SA_relevant_depth2.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth2.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SA at depth2") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SA_relevant_depth2.long$Cluster)))

# draw plot
table_neglog10_F22_SA_relevant_depth2.heatmap

###### export as pdf #####
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_depth2.pdf", height=11, width=8.5)
table_neglog10_F22_OA_relevant_depth2.heatmap
table_neglog10_F22_SO_relevant_depth2.heatmap
table_neglog10_F22_SA_relevant_depth2.heatmap
dev.off()



##### F22_OA_depth3 ####
library(dplyr)
table_neglog10_F22_OA_relevant_depth3 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_OA/table_neglog10_F22_OA_relevant_depth3.xlsx")
View(table_neglog10_F22_OA_relevant_depth3)

names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C0)"] <- "-log10(F22_OA_C00)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C1)"] <- "-log10(F22_OA_C01)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C2)"] <- "-log10(F22_OA_C02)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C3)"] <- "-log10(F22_OA_C03)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C4)"] <- "-log10(F22_OA_C04)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C5)"] <- "-log10(F22_OA_C05)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C6)"] <- "-log10(F22_OA_C06)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C7)"] <- "-log10(F22_OA_C07)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C8)"] <- "-log10(F22_OA_C08)"
names(table_neglog10_F22_OA_relevant_depth3)[names(table_neglog10_F22_OA_relevant_depth3)=="-log10(F22_OA_C9)"] <- "-log10(F22_OA_C09)"
colnames(table_neglog10_F22_OA_relevant_depth3)

str(table_neglog10_F22_OA_relevant_depth3)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_OA_relevant_depth3$relevant <- NULL
table_neglog10_F22_OA_relevant_depth3$depth <- NULL

table_neglog10_F22_OA_relevant_depth3 <- table_neglog10_F22_OA_relevant_depth3[c("name", "GO", "NS", "-log10(F22_OA_C00)" ,"-log10(F22_OA_C01)" , "-log10(F22_OA_C02)" , "-log10(F22_OA_C03)" , "-log10(F22_OA_C04)" ,"-log10(F22_OA_C05)" , "-log10(F22_OA_C06)" , "-log10(F22_OA_C07)" , "-log10(F22_OA_C08)" ,"-log10(F22_OA_C09)" , "-log10(F22_OA_C10)", "-log10(F22_OA_C11)", "-log10(F22_OA_C12)","-log10(F22_OA_C13)", "-log10(F22_OA_C14)", "-log10(F22_OA_C15)")]
#table_neglog10_F22_OA_relevant_depth3 <- table_neglog10_F22_OA_relevant_depth3[order(table_neglog10_F22_OA_relevant_depth3$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_OA_relevant_depth3.long <- gather(data=table_neglog10_F22_OA_relevant_depth3, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_OA_relevant_depth3.long <- gather(data=table_neglog10_F22_OA_relevant_depth3, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_OA_relevant_depth3.long)
table_neglog10_F22_OA_relevant_depth3.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_OA_relevant_depth3.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_OA_relevant_depth3.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_OA_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth3.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_OA at depth3") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_OA_relevant_depth3.long$Cluster))))


table_neglog10_F22_OA_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth3.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_OA at depth3") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_OA_relevant_depth3.long$Cluster)))

# draw plot
table_neglog10_F22_OA_relevant_depth3.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_OA_depth3.pdf", height=11, width=8.5)
table_neglog10_F22_OA_relevant_depth3.heatmap
dev.off()

##### F22_SO_depth3 ####
library(dplyr)
table_neglog10_F22_SO_relevant_depth3 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SO/table_neglog10_F22_SO_relevant_depth3.xlsx")
View(table_neglog10_F22_SO_relevant_depth3)

names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C0)"] <- "-log10(F22_SO_C00)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C1)"] <- "-log10(F22_SO_C01)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C2)"] <- "-log10(F22_SO_C02)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C3)"] <- "-log10(F22_SO_C03)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C4)"] <- "-log10(F22_SO_C04)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C5)"] <- "-log10(F22_SO_C05)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C6)"] <- "-log10(F22_SO_C06)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C7)"] <- "-log10(F22_SO_C07)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C8)"] <- "-log10(F22_SO_C08)"
names(table_neglog10_F22_SO_relevant_depth3)[names(table_neglog10_F22_SO_relevant_depth3)=="-log10(F22_SO_C9)"] <- "-log10(F22_SO_C09)"
colnames(table_neglog10_F22_SO_relevant_depth3)

str(table_neglog10_F22_SO_relevant_depth3)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SO_relevant_depth3$relevant <- NULL
table_neglog10_F22_SO_relevant_depth3$depth <- NULL

table_neglog10_F22_SO_relevant_depth3 <- table_neglog10_F22_SO_relevant_depth3[c("name", "GO", "NS", "-log10(F22_SO_C00)" ,"-log10(F22_SO_C01)" , "-log10(F22_SO_C02)" , "-log10(F22_SO_C03)" , "-log10(F22_SO_C04)" ,"-log10(F22_SO_C05)" , "-log10(F22_SO_C06)" , "-log10(F22_SO_C07)" , "-log10(F22_SO_C08)" ,"-log10(F22_SO_C09)" , "-log10(F22_SO_C10)", "-log10(F22_SO_C11)", "-log10(F22_SO_C12)","-log10(F22_SO_C13)", "-log10(F22_SO_C14)", "-log10(F22_SO_C15)")]
#table_neglog10_F22_SO_relevant_depth3 <- table_neglog10_F22_SO_relevant_depth3[order(table_neglog10_F22_SO_relevant_depth3$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SO_relevant_depth3.long <- gather(data=table_neglog10_F22_SO_relevant_depth3, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SO_relevant_depth3.long <- gather(data=table_neglog10_F22_SO_relevant_depth3, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SO_relevant_depth3.long)
table_neglog10_F22_SO_relevant_depth3.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SO_relevant_depth3.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SO_relevant_depth3.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SO_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth3.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SO at depth3") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SO_relevant_depth3.long$Cluster))))


table_neglog10_F22_SO_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth3.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SO at depth3") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SO_relevant_depth3.long$Cluster)))

# draw plot
table_neglog10_F22_SO_relevant_depth3.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_SO_depth3.pdf", height=11, width=8.5)
table_neglog10_F22_SO_relevant_depth3.heatmap
dev.off()

##### F22_SA_depth3 ####
library(dplyr)
table_neglog10_F22_SA_relevant_depth3 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SA/table_neglog10_F22_SA_relevant_depth3.xlsx")
View(table_neglog10_F22_SA_relevant_depth3)

names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C0)"] <- "-log10(F22_SA_C00)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C1)"] <- "-log10(F22_SA_C01)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C2)"] <- "-log10(F22_SA_C02)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C3)"] <- "-log10(F22_SA_C03)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C4)"] <- "-log10(F22_SA_C04)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C5)"] <- "-log10(F22_SA_C05)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C6)"] <- "-log10(F22_SA_C06)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C7)"] <- "-log10(F22_SA_C07)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C8)"] <- "-log10(F22_SA_C08)"
names(table_neglog10_F22_SA_relevant_depth3)[names(table_neglog10_F22_SA_relevant_depth3)=="-log10(F22_SA_C9)"] <- "-log10(F22_SA_C09)"
colnames(table_neglog10_F22_SA_relevant_depth3)

str(table_neglog10_F22_SA_relevant_depth3)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SA_relevant_depth3$relevant <- NULL
table_neglog10_F22_SA_relevant_depth3$depth <- NULL

table_neglog10_F22_SA_relevant_depth3 <- table_neglog10_F22_SA_relevant_depth3[c("name", "GO", "NS", "-log10(F22_SA_C00)" ,"-log10(F22_SA_C01)" , "-log10(F22_SA_C02)" , "-log10(F22_SA_C03)" , "-log10(F22_SA_C04)" ,"-log10(F22_SA_C05)" , "-log10(F22_SA_C06)" , "-log10(F22_SA_C07)" , "-log10(F22_SA_C08)" ,"-log10(F22_SA_C09)" , "-log10(F22_SA_C10)", "-log10(F22_SA_C11)", "-log10(F22_SA_C12)","-log10(F22_SA_C13)", "-log10(F22_SA_C14)", "-log10(F22_SA_C15)")]
#table_neglog10_F22_SA_relevant_depth3 <- table_neglog10_F22_SA_relevant_depth3[order(table_neglog10_F22_SA_relevant_depth3$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SA_relevant_depth3.long <- gather(data=table_neglog10_F22_SA_relevant_depth3, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SA_relevant_depth3.long <- gather(data=table_neglog10_F22_SA_relevant_depth3, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SA_relevant_depth3.long)
table_neglog10_F22_SA_relevant_depth3.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SA_relevant_depth3.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SA_relevant_depth3.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SA_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth3.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SA at depth3") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SA_relevant_depth3.long$Cluster))))


table_neglog10_F22_SA_relevant_depth3.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth3.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SA at depth3") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SA_relevant_depth3.long$Cluster)))

# draw plot
table_neglog10_F22_SA_relevant_depth3.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_SA_depth3.pdf", height=11, width=8.5)
table_neglog10_F22_SA_relevant_depth3.heatmap
dev.off()

###### export as pdf #####
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_depth3.pdf", height=11, width=8.5)
table_neglog10_F22_OA_relevant_depth3.heatmap
table_neglog10_F22_SO_relevant_depth3.heatmap
table_neglog10_F22_SA_relevant_depth3.heatmap
dev.off()



##### F22_OA_depth4 ####
library(dplyr)
table_neglog10_F22_OA_relevant_depth4 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_OA/table_neglog10_F22_OA_relevant_depth4.xlsx")
View(table_neglog10_F22_OA_relevant_depth4)

names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C0)"] <- "-log10(F22_OA_C00)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C1)"] <- "-log10(F22_OA_C01)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C2)"] <- "-log10(F22_OA_C02)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C3)"] <- "-log10(F22_OA_C03)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C4)"] <- "-log10(F22_OA_C04)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C5)"] <- "-log10(F22_OA_C05)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C6)"] <- "-log10(F22_OA_C06)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C7)"] <- "-log10(F22_OA_C07)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C8)"] <- "-log10(F22_OA_C08)"
names(table_neglog10_F22_OA_relevant_depth4)[names(table_neglog10_F22_OA_relevant_depth4)=="-log10(F22_OA_C9)"] <- "-log10(F22_OA_C09)"
colnames(table_neglog10_F22_OA_relevant_depth4)

str(table_neglog10_F22_OA_relevant_depth4)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_OA_relevant_depth4$relevant <- NULL
table_neglog10_F22_OA_relevant_depth4$depth <- NULL

table_neglog10_F22_OA_relevant_depth4 <- table_neglog10_F22_OA_relevant_depth4[c("name", "GO", "NS", "-log10(F22_OA_C00)" ,"-log10(F22_OA_C01)" , "-log10(F22_OA_C02)" , "-log10(F22_OA_C03)" , "-log10(F22_OA_C04)" ,"-log10(F22_OA_C05)" , "-log10(F22_OA_C06)" , "-log10(F22_OA_C07)" , "-log10(F22_OA_C08)" ,"-log10(F22_OA_C09)" , "-log10(F22_OA_C10)", "-log10(F22_OA_C11)", "-log10(F22_OA_C12)","-log10(F22_OA_C13)", "-log10(F22_OA_C14)", "-log10(F22_OA_C15)")]
#table_neglog10_F22_OA_relevant_depth4 <- table_neglog10_F22_OA_relevant_depth4[order(table_neglog10_F22_OA_relevant_depth4$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_OA_relevant_depth4.long <- gather(data=table_neglog10_F22_OA_relevant_depth4, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_OA_relevant_depth4.long <- gather(data=table_neglog10_F22_OA_relevant_depth4, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_OA_relevant_depth4.long)
table_neglog10_F22_OA_relevant_depth4.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_OA_relevant_depth4.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_OA_relevant_depth4.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_OA_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth4.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_OA at depth4") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_OA_relevant_depth4.long$Cluster))))


table_neglog10_F22_OA_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_OA_relevant_depth4.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_OA at depth4") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_OA_relevant_depth4.long$Cluster)))

# draw plot
table_neglog10_F22_OA_relevant_depth4.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_OA_depth4.pdf", height=11, width=8.5)
table_neglog10_F22_OA_relevant_depth4.heatmap
dev.off()

##### F22_SO_depth4 ####
library(dplyr)
table_neglog10_F22_SO_relevant_depth4 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SO/table_neglog10_F22_SO_relevant_depth4.xlsx")
View(table_neglog10_F22_SO_relevant_depth4)

names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C0)"] <- "-log10(F22_SO_C00)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C1)"] <- "-log10(F22_SO_C01)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C2)"] <- "-log10(F22_SO_C02)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C3)"] <- "-log10(F22_SO_C03)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C4)"] <- "-log10(F22_SO_C04)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C5)"] <- "-log10(F22_SO_C05)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C6)"] <- "-log10(F22_SO_C06)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C7)"] <- "-log10(F22_SO_C07)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C8)"] <- "-log10(F22_SO_C08)"
names(table_neglog10_F22_SO_relevant_depth4)[names(table_neglog10_F22_SO_relevant_depth4)=="-log10(F22_SO_C9)"] <- "-log10(F22_SO_C09)"
colnames(table_neglog10_F22_SO_relevant_depth4)

str(table_neglog10_F22_SO_relevant_depth4)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SO_relevant_depth4$relevant <- NULL
table_neglog10_F22_SO_relevant_depth4$depth <- NULL

table_neglog10_F22_SO_relevant_depth4 <- table_neglog10_F22_SO_relevant_depth4[c("name", "GO", "NS", "-log10(F22_SO_C00)" ,"-log10(F22_SO_C01)" , "-log10(F22_SO_C02)" , "-log10(F22_SO_C03)" , "-log10(F22_SO_C04)" ,"-log10(F22_SO_C05)" , "-log10(F22_SO_C06)" , "-log10(F22_SO_C07)" , "-log10(F22_SO_C08)" ,"-log10(F22_SO_C09)" , "-log10(F22_SO_C10)", "-log10(F22_SO_C11)", "-log10(F22_SO_C12)","-log10(F22_SO_C13)", "-log10(F22_SO_C14)", "-log10(F22_SO_C15)")]
#table_neglog10_F22_SO_relevant_depth4 <- table_neglog10_F22_SO_relevant_depth4[order(table_neglog10_F22_SO_relevant_depth4$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SO_relevant_depth4.long <- gather(data=table_neglog10_F22_SO_relevant_depth4, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SO_relevant_depth4.long <- gather(data=table_neglog10_F22_SO_relevant_depth4, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SO_relevant_depth4.long)
table_neglog10_F22_SO_relevant_depth4.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SO_relevant_depth4.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SO_relevant_depth4.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SO_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth4.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SO at depth4") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SO_relevant_depth4.long$Cluster))))


table_neglog10_F22_SO_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_SO_relevant_depth4.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SO at depth4") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SO_relevant_depth4.long$Cluster)))

# draw plot
table_neglog10_F22_SO_relevant_depth4.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_SO_depth4.pdf", height=11, width=8.5)
table_neglog10_F22_SO_relevant_depth4.heatmap
dev.off()

##### F22_SA_depth4 ####
library(dplyr)
table_neglog10_F22_SA_relevant_depth4 <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_SA/table_neglog10_F22_SA_relevant_depth4.xlsx")
View(table_neglog10_F22_SA_relevant_depth4)

names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C0)"] <- "-log10(F22_SA_C00)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C1)"] <- "-log10(F22_SA_C01)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C2)"] <- "-log10(F22_SA_C02)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C3)"] <- "-log10(F22_SA_C03)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C4)"] <- "-log10(F22_SA_C04)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C5)"] <- "-log10(F22_SA_C05)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C6)"] <- "-log10(F22_SA_C06)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C7)"] <- "-log10(F22_SA_C07)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C8)"] <- "-log10(F22_SA_C08)"
names(table_neglog10_F22_SA_relevant_depth4)[names(table_neglog10_F22_SA_relevant_depth4)=="-log10(F22_SA_C9)"] <- "-log10(F22_SA_C09)"
colnames(table_neglog10_F22_SA_relevant_depth4)

str(table_neglog10_F22_SA_relevant_depth4)

# reorder columns so first column has the information of interest and by NS
table_neglog10_F22_SA_relevant_depth4$relevant <- NULL
table_neglog10_F22_SA_relevant_depth4$depth <- NULL

table_neglog10_F22_SA_relevant_depth4 <- table_neglog10_F22_SA_relevant_depth4[c("name", "GO", "NS", "-log10(F22_SA_C00)" ,"-log10(F22_SA_C01)" , "-log10(F22_SA_C02)" , "-log10(F22_SA_C03)" , "-log10(F22_SA_C04)" ,"-log10(F22_SA_C05)" , "-log10(F22_SA_C06)" , "-log10(F22_SA_C07)" , "-log10(F22_SA_C08)" ,"-log10(F22_SA_C09)" , "-log10(F22_SA_C10)", "-log10(F22_SA_C11)", "-log10(F22_SA_C12)","-log10(F22_SA_C13)", "-log10(F22_SA_C14)", "-log10(F22_SA_C15)")]
#table_neglog10_F22_SA_relevant_depth4 <- table_neglog10_F22_SA_relevant_depth4[order(table_neglog10_F22_SA_relevant_depth4$NS), ]

#### convert to heatmap format - long form so column Class and "-log10(pfdr)"
# install.packages("tidyr")
library(tidyr)

table_neglog10_F22_SA_relevant_depth4.long <- gather(data=table_neglog10_F22_SA_relevant_depth4, key=Cluster, value="-log10(pfdr)", -c(1:3))
#table_neglog10_F22_SA_relevant_depth4.long <- gather(data=table_neglog10_F22_SA_relevant_depth4, key=Cluster, value="-log10(pfdr)", -name, -GO, -NS)
head(table_neglog10_F22_SA_relevant_depth4.long)
table_neglog10_F22_SA_relevant_depth4.long$"sqrt.-log10pfdr" <- sqrt(table_neglog10_F22_SA_relevant_depth4.long$`-log10(pfdr)`)
colnames(table_neglog10_F22_SA_relevant_depth4.long)
# plot data
library("ggplot2")

# create plot object
# table_neglog10_F22_SA_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth4.long, mapping = aes(x=name,y=Cluster, fill=`sqrt.-log10pfdr`)) +
#  geom_tile() +
#  xlab(label = "name") + 
#  facet_grid(~ NS, switch = "x", scales = "free_x", space = "free_x") +
#  scale_fill_gradient(name = "sqrt.-log10pfdr",
#                      low = "#FFFFFF",
#                      high = "#012345") +
#  theme_bw() +
#  theme(strip.placement = "outside",
#        plot.title = element_text(hjust = 0.5),
#       axis.title.x = element_blank(),
#        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
#                                        axis.text.x = element_text(angle=90, hjust = 1) )+
#  ggtitle(label = "GOterm diversity of F22_SA at depth4") +
#  scale_y_discrete(limits = rev(levels(as.factor(table_neglog10_F22_SA_relevant_depth4.long$Cluster))))


table_neglog10_F22_SA_relevant_depth4.heatmap <- ggplot(table_neglog10_F22_SA_relevant_depth4.long, mapping = aes(x=Cluster,y=name, fill=`sqrt.-log10pfdr`)) +
  geom_tile() +
  xlab(label = "Cluster") + 
  facet_grid(NS ~ ., scales ="free", space = "free") +
  scale_fill_gradient(name = "sqrt.-log10pfdr",
                      low = "#FFFFFF",
                      high = "#012345") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        strip.background = element_rect(fill = "#EEEEEE", color = "#FFFFFF"),
        axis.text.x = element_text(angle=90, hjust = 1)) +
  ggtitle(label = "GOterm diversity of F22_SA at depth4") +
  scale_x_discrete(limits = levels(as.factor(table_neglog10_F22_SA_relevant_depth4.long$Cluster)))

# draw plot
table_neglog10_F22_SA_relevant_depth4.heatmap
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_SA_depth4.pdf", height=11, width=8.5)
table_neglog10_F22_SA_relevant_depth4.heatmap
dev.off()

###### export as pdf #####
pdf("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/pfdr_matrix_figures/Geomtile_heatmap_F22_depth4.pdf", height=11, width=8.5)
table_neglog10_F22_OA_relevant_depth4.heatmap
table_neglog10_F22_SO_relevant_depth4.heatmap
table_neglog10_F22_SA_relevant_depth4.heatmap
dev.off()

