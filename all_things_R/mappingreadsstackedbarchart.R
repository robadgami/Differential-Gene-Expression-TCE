X20190529_readsmappedtowheat <- read_excel("/Volumes/RBADGAMI 1/20190529_readsmappedtowheat.xlsx", 
                                                                             sheet = "Me_wheat")
head(X20190529_readsmappedtowheat)

ID_order <- c("CON-0-OA1", "CON-0-OA2", "CON-0-OA3", "CON-0-SO1", "CON-0-SO2", "CON-0-SO3", "CON-0-SA1", "CON-0-SA2", "CON-0-SA3",
              "F22-1-OA1", "F22-1-OA2", "F22-1-OA3", "F22-1-SO1", "F22-1-SO2", "F22-1-SO3", "F22-1-SA1", "F22-1-SA2", "F22-1-SA3",
              "F22-3-OA1", "F22-3-OA2", "F22-3-OA3", "F22-3-SO1", "F22-3-SO2", "F22-3-SO3", "F22-3-SA1", "F22-3-SA2", "F22-3-SA3",
              "F22-7-OA1", "F22-7-OA2", "F22-7-OA3", "F22-7-SO1", "F22-7-SO2", "F22-7-SO3", "F22-7-SA1", "F22-7-SA2", "F22-7-SA3",
              "F22-11-OA1", "F22-11-OA2", "F22-11-OA3", "F22-11-SO1", "F22-11-SO2", "F22-11-SO3", "F22-11-SA1", "F22-11-SA2", "F22-11-SA3",
              "1314-1-OA1", "1314-1-OA2", "1314-1-OA3", "1314-1-SO1", "1314-1-SO2", "1314-1-SO3", "1314-1-SA1", "1314-1-SA2", "1314-1-SA3",
              "1314-3-OA1", "1314-3-OA2", "1314-3-OA3", "1314-3-SO1", "1314-3-SO2", "1314-3-SO3", "1314-3-SA1", "1314-3-SA2", "1314-3-SA3",
              "1314-7-OA1", "1314-7-OA2", "1314-7-OA3", "1314-7-SO1", "1314-7-SO2", "1314-7-SO3", "1314-7-SA1", "1314-7-SA2", "1314-7-SA3",
              "1314-11-OA1", "1314-11-OA2", "1314-11-OA3", "1314-11-SO1", "1314-11-SO2", "1314-11-SO3", "1314-11-SA1", "1314-11-SA2", "1314-11-SA3")


# get appropriate colour scheme
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#A6CEE3", "#B2DF8A", "#FB9A99"),
                       c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA", "CON_SO", "CON_SA", "CON_OA"))

# boxplot version of reads mapped to wheat

ggplot(X20190529_readsmappedtowheat, aes(x = as.factor(ORDER), y = round(as.numeric(X20190529_readsmappedtowheat$percent_mapped),2))) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("percent reads mapped to wheat (%)") +xlab("sample")

# barchart of reads mapped to wheat
library(ggplot2)
ggplot(data=X20190529_readsmappedtowheat, aes(x=ID, y=round(as.numeric(X20190529_readsmappedtowheat$percent_mapped),2), fill=isolate_cultivar)) + scale_fill_manual(values = irisColors) +
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  labs(fill = "isolate-cultivar") + ylab("percent reads mapped to wheat (%)") +xlab("samples") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_text(aes(label=round(as.numeric(X20190529_readsmappedtowheat$percent_mapped),2)), vjust=0.5, hjust=1.25, color="black", size=3, angle=90) +
  scale_x_discrete(limits=ID_order) + ylim(0, 100)
  
  

X20190529_readsmappedtoisolate <- read_excel("/Volumes/RBADGAMI 1/20190529_readsmappedtowheat.xlsx", 
                                                sheet = "easier_Pst")
head(X20190529_readsmappedtoisolate)
# barchart of reads mapped to isolate
library(ggplot2)
ggplot(data=X20190529_readsmappedtoisolate, aes(x=ID, y=round(as.numeric(X20190529_readsmappedtoisolate$percent_mapped_isolate),2), fill=isolate_cultivar)) + scale_fill_manual(values = irisColors) +
  geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "isolate-cultivar") + ylab("percent reads mapped to isolate (%)") +xlab("samples") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_text(aes(label=round(as.numeric(X20190529_readsmappedtoisolate$percent_mapped_isolate),2)), vjust=0.5, hjust=-0.25, color="black", size=3, angle=90) +
  scale_x_discrete(limits=ID_order) + ylim(0, 50)



# make wide-to-long format
library(tidyr)
readvalue_long <- gather(X20190529_readsmappedtowheat, reads, value, reads_mapped,reads_unmapped)
readpercent_long <- gather(X20190529_readsmappedtowheat, reads_percent, percent, percent_unmapped:percent_mapped)
View(readvalue_long)
View(readpercent_long)
readvalue_long$percent <- readpercent_long$percent
readvalue_long$reads_percent <- readpercent_long$reads_percent
colnames(readvalue_long)
readvalue_long$reads_proc <- NULL
readvalue_long$percent_mapped <- NULL
readvalue_long$percent_unmapped <- NULL
rm(readpercent_long)
summary(readvalue_long$sample)
readvalue_long$perc <- ifelse(readvalue_long$reads_percent=="percent_mapped", readvalue_long$perc <-round(readvalue_long$percent,2), readvalue_long$perc <- "NA")

# make stacked barchart
library(ggplot2)
sample_order <- c("CON-OA-00", "CON-SO-00", "CON-SA-00",
                 "F22-OA-01", "F22-SO-01", "F22-SA-01",
                 "F22-OA-03", "F22-SO-03", "F22-SA-03",
                 "F22-OA-07", "F22-SO-07", "F22-SA-07",
                 "F22-OA-11", "F22-SO-11", "F22-SA-11",
                 "1314-OA-01", "1314-SO-01", "1314-SA-01",
                 "1314-OA-03", "1314-SO-03", "1314-SA-03",
                 "1314-OA-07", "1314-SO-07", "1314-SA-07",
                 "1314-OA-11", "1314-SO-11", "1314-SA-11")
ID_order <- c("CON-0-OA1", "CON-0-OA2", "CON-0-OA3", "CON-0-SO1", "CON-0-SO2", "CON-0-SO3", "CON-0-SA1", "CON-0-SA2", "CON-0-SA3",
              "F22-1-OA1", "F22-1-OA2", "F22-1-OA3", "F22-1-SO1", "F22-1-SO2", "F22-1-SO3", "F22-1-SA1", "F22-1-SA2", "F22-1-SA3",
              "F22-3-OA1", "F22-3-OA2", "F22-3-OA3", "F22-3-SO1", "F22-3-SO2", "F22-3-SO3", "F22-3-SA1", "F22-3-SA2", "F22-3-SA3",
              "F22-7-OA1", "F22-7-OA2", "F22-7-OA3", "F22-7-SO1", "F22-7-SO2", "F22-7-SO3", "F22-7-SA1", "F22-7-SA2", "F22-7-SA3",
              "F22-11-OA1", "F22-11-OA2", "F22-11-OA3", "F22-11-SO1", "F22-11-SO2", "F22-11-SO3", "F22-11-SA1", "F22-11-SA2", "F22-11-SA3",
              "1314-1-OA1", "1314-1-OA2", "1314-1-OA3", "1314-1-SO1", "1314-1-SO2", "1314-1-SO3", "1314-1-SA1", "1314-1-SA2", "1314-1-SA3",
              "1314-3-OA1", "1314-3-OA2", "1314-3-OA3", "1314-3-SO1", "1314-3-SO2", "1314-3-SO3", "1314-3-SA1", "1314-3-SA2", "1314-3-SA3",
              "1314-7-OA1", "1314-7-OA2", "1314-7-OA3", "1314-7-SO1", "1314-7-SO2", "1314-7-SO3", "1314-7-SA1", "1314-7-SA2", "1314-7-SA3",
              "1314-11-OA1", "1314-11-OA2", "1314-11-OA3", "1314-11-SO1", "1314-11-SO2", "1314-11-SO3", "1314-11-SA1", "1314-11-SA2", "1314-11-SA3")
head(readvalue_long)
pdf("/Users/rbadgami/Desktop/data2/readsmappedstackedbarchart.pdf", onefile=T,paper='a4r')
plot.new()
ggplot(readvalue_long, aes(x=factor(ID, level=ID_order), y=value, fill=factor(reads, levels=c("reads_unmapped", "reads_mapped")))) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "reads") + ylab("number reads") +xlab("ID")

ggplot(readvalue_long, aes(x=factor(ID, level=ID_order), y=percent, fill=factor(reads_percent, levels=c("percent_unmapped", "percent_mapped")), labels(reads_percent))) +
    geom_bar(stat="identity") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    labs(fill = "reads") + ylab("percent reads") +xlab("ID")

ggplot(readvalue_long, aes(x=factor(ID, level=ID_order), y=percent, fill=factor(reads_percent, levels=c("percent_unmapped", "percent_mapped")))) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(fill = "reads") + ylab("percent reads") +xlab("ID") +
  geom_text(aes(label = perc), size = 3, hjust = 1, angle=90, position = "stack")
dev.off()

### NOW FOR PILAR's Pst READS ###
library(readxl)
X20190529_readsmappedtoisolate <- read_excel("/Volumes/RBADGAMI 1/20190529_readsmappedtowheat.xlsx", 
                                                sheet = "easier_Pst")

head(X20190529_readsmappedtoisolate)
X20190529_readsmappedtoisolate$`%mapped`=as.numeric(X20190529_readsmappedtoisolate$`%mapped`)
X20190529_readsmappedtoisolate$`%mapped`=round(X20190529_readsmappedtoisolate$`%mapped`,2)
library(RColorBrewer)
display.brewer.all(colorblindFriendly = TRUE)
display.brewer.pal(n = 10, name = 'Paired')
brewer.pal(n = 10, name = 'Paired')
irisColors <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C"), c("1314_SO", "F22_SO", "1314_SA", "F22_SA", "1314_OA", "F22_OA"))






X20190529_readsmappedtoisolate <- read_excel("/Volumes/RBADGAMI/20190529_readsmappedtowheat.xlsx", 
                                                  sheet = "Pilar_Pst")
View(X20190529_readsmappedtoisolate)
head(X20190529_readsmappedtoisolate)
meanFunction <- function(x){
  return(data.frame(y=round(mean(x),2),label=round(mean(x,na.rm=T),2)))}

# make wide-to-long format
library(ggplot2)
sample_order <- c("CON-OA-00", "CON-SO-00", "CON-SA-00",
                  "F22-OA-01", "F22-SO-01", "F22-SA-01",
                  "F22-OA-03", "F22-SO-03", "F22-SA-03",
                  "F22-OA-07", "F22-SO-07", "F22-SA-07",
                  "F22-OA-11", "F22-SO-11", "F22-SA-11",
                  "1314-OA-01", "1314-SO-01", "1314-SA-01",
                  "1314-OA-03", "1314-SO-03", "1314-SA-03",
                  "1314-OA-07", "1314-SO-07", "1314-SA-07",
                  "1314-OA-11", "1314-SO-11", "1314-SA-11")
ggplot(X20190529_readsmappedtoisolate, aes(x = as.factor(ORDER), y = round(as.numeric(X20190529_readsmappedtoisolate$`%mapped`),2))) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("percent reads mapped to Pst (%)") +xlab("sample")


  

