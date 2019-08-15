install.packages("xlsReadWrite")
library("xlsReadWrite")

library(ggplot2)

#install.packages("curl")
#library("curl")
#curl("http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2")
# in terminal: sudo tar fvxj gfortran-4.8.2-darwin13.tar.bz2 -C
#install.packages("robustbase")
#library('robustbase')

#install.packages("ggtern")
library("ggtern")
citation("ggtern")


### import TPM list ###
sig1314_TPMlist<- read_excel("~/Desktop/sig1314_TPMlist.xlsx")
View(sig1314_TPMlist)
colnames(sig1314_TPMlist)

#### sig1314_tpm_1dpi ####
sig1314_tpm_1dpi <- data.frame(sig1314_TPMlist$gene, sig1314_TPMlist$"1314_1_OA1", sig1314_TPMlist$"1314_1_OA2", sig1314_TPMlist$"1314_1_OA3", sig1314_TPMlist$"1314_1_SA1", sig1314_TPMlist$"1314_1_SA2", sig1314_TPMlist$"1314_1_SA3", sig1314_TPMlist$"1314_1_SO1", sig1314_TPMlist$"1314_1_SO2", sig1314_TPMlist$"1314_1_SO3")
View(sig1314_tpm_1dpi)
names(sig1314_tpm_1dpi) <- c("gene", "1314_1_OA1", "1314_1_OA2", "1314_1_OA3", "1314_1_SA1", "1314_1_SA2", "1314_1_SA3", "1314_1_SO1", "1314_1_SO2", "1314_1_SO3" )

sig1314_tpm_1dpi$av_1314_1_OA <- ((sig1314_tpm_1dpi$"1314_1_OA1" + sig1314_tpm_1dpi$"1314_1_OA2" + sig1314_tpm_1dpi$"1314_1_OA3")/3)
sig1314_tpm_1dpi$av_1314_1_SA <- ((sig1314_tpm_1dpi$"1314_1_SA1" + sig1314_tpm_1dpi$"1314_1_SA2" + sig1314_tpm_1dpi$"1314_1_SA3")/3)
sig1314_tpm_1dpi$av_1314_1_SO <- ((sig1314_tpm_1dpi$"1314_1_SO1" + sig1314_tpm_1dpi$"1314_1_SO2" + sig1314_tpm_1dpi$"1314_1_SO3")/3)

sig1314_tpm_1dpi$triadTPMsum <- (sig1314_tpm_1dpi$av_1314_1_OA + sig1314_tpm_1dpi$av_1314_1_SA + sig1314_tpm_1dpi$av_1314_1_SO)
sig1314_tpm_1dpi$percentTPM_OA <- ((sig1314_tpm_1dpi$av_1314_1_OA/sig1314_tpm_1dpi$triadTPMsum)*100)
sig1314_tpm_1dpi$percentTPM_SA <- ((sig1314_tpm_1dpi$av_1314_1_SA/sig1314_tpm_1dpi$triadTPMsum)*100)
sig1314_tpm_1dpi$percentTPM_SO <- ((sig1314_tpm_1dpi$av_1314_1_SO/sig1314_tpm_1dpi$triadTPMsum)*100)

sig1314_tpm_1dpi$percentTPM_check <- (sig1314_tpm_1dpi$percentTPM_OA+sig1314_tpm_1dpi$percentTPM_SA + sig1314_tpm_1dpi$percentTPM_SO)
summary(sig1314_tpm_1dpi$percentTPM_check)

sig1314_tpm_1dpi_ternary <- data.frame(sig1314_tpm_1dpi$gene, sig1314_tpm_1dpi$percentTPM_OA,sig1314_tpm_1dpi$percentTPM_SA,sig1314_tpm_1dpi$percentTPM_SO)
colnames(sig1314_tpm_1dpi_ternary)
colnames(sig1314_tpm_1dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")
write.xlsx(sig1314_tpm_1dpi_ternary, "~/Desktop/ternary_plots/sig1314_percenttpm_1dpi.xlsx")

ternaryplot_1314_1dpi <- ggtern(data=sig1314_tpm_1dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
ggtitle("percentTPM for 1314 at 1dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_1314_1dpi


#### sig1314_tpm_3dpi ####
sig1314_tpm_3dpi <- data.frame(sig1314_TPMlist$gene, sig1314_TPMlist$"1314_3_OA1", sig1314_TPMlist$"1314_3_OA2", sig1314_TPMlist$"1314_3_OA3", sig1314_TPMlist$"1314_3_SA1", sig1314_TPMlist$"1314_3_SA2", sig1314_TPMlist$"1314_3_SA3", sig1314_TPMlist$"1314_3_SO1", sig1314_TPMlist$"1314_3_SO2", sig1314_TPMlist$"1314_3_SO3")
View(sig1314_tpm_3dpi)
names(sig1314_tpm_3dpi) <- c("gene", "1314_3_OA1", "1314_3_OA2", "1314_3_OA3", "1314_3_SA1", "1314_3_SA2", "1314_3_SA3", "1314_3_SO1", "1314_3_SO2", "1314_3_SO3" )

sig1314_tpm_3dpi$av_1314_3_OA <- ((sig1314_tpm_3dpi$"1314_3_OA1" + sig1314_tpm_3dpi$"1314_3_OA2" + sig1314_tpm_3dpi$"1314_3_OA3")/3)
sig1314_tpm_3dpi$av_1314_3_SA <- ((sig1314_tpm_3dpi$"1314_3_SA1" + sig1314_tpm_3dpi$"1314_3_SA2" + sig1314_tpm_3dpi$"1314_3_SA3")/3)
sig1314_tpm_3dpi$av_1314_3_SO <- ((sig1314_tpm_3dpi$"1314_3_SO1" + sig1314_tpm_3dpi$"1314_3_SO2" + sig1314_tpm_3dpi$"1314_3_SO3")/3)

sig1314_tpm_3dpi$triadTPMsum <- (sig1314_tpm_3dpi$av_1314_3_OA + sig1314_tpm_3dpi$av_1314_3_SA + sig1314_tpm_3dpi$av_1314_3_SO)
sig1314_tpm_3dpi$percentTPM_OA <- ((sig1314_tpm_3dpi$av_1314_3_OA/sig1314_tpm_3dpi$triadTPMsum)*100)
sig1314_tpm_3dpi$percentTPM_SA <- ((sig1314_tpm_3dpi$av_1314_3_SA/sig1314_tpm_3dpi$triadTPMsum)*100)
sig1314_tpm_3dpi$percentTPM_SO <- ((sig1314_tpm_3dpi$av_1314_3_SO/sig1314_tpm_3dpi$triadTPMsum)*100)

sig1314_tpm_3dpi$percentTPM_check <- (sig1314_tpm_3dpi$percentTPM_OA+sig1314_tpm_3dpi$percentTPM_SA + sig1314_tpm_3dpi$percentTPM_SO)
summary(sig1314_tpm_3dpi$percentTPM_check)

sig1314_tpm_3dpi_ternary <- data.frame(sig1314_tpm_3dpi$gene, sig1314_tpm_3dpi$percentTPM_OA,sig1314_tpm_3dpi$percentTPM_SA,sig1314_tpm_3dpi$percentTPM_SO)
colnames(sig1314_tpm_3dpi_ternary)
colnames(sig1314_tpm_3dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")
write.xlsx(sig1314_tpm_3dpi_ternary, "~/Desktop/ternary_plots/sig1314_percenttpm_3dpi.xlsx")

ternaryplot_1314_3dpi <- ggtern(data=sig1314_tpm_3dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
ggtitle("percentTPM for 1314 at 3dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_1314_3dpi

### sig1314_tpm_7dpi ####
sig1314_tpm_7dpi <- data.frame(sig1314_TPMlist$gene, sig1314_TPMlist$"1314_7_OA1", sig1314_TPMlist$"1314_7_OA2", sig1314_TPMlist$"1314_7_OA3", sig1314_TPMlist$"1314_7_SA1", sig1314_TPMlist$"1314_7_SA2", sig1314_TPMlist$"1314_7_SA3", sig1314_TPMlist$"1314_7_SO1", sig1314_TPMlist$"1314_7_SO2", sig1314_TPMlist$"1314_7_SO3")
View(sig1314_tpm_7dpi)
names(sig1314_tpm_7dpi) <- c("gene", "1314_7_OA1", "1314_7_OA2", "1314_7_OA3", "1314_7_SA1", "1314_7_SA2", "1314_7_SA3", "1314_7_SO1", "1314_7_SO2", "1314_7_SO3" )

sig1314_tpm_7dpi$av_1314_7_OA <- ((sig1314_tpm_7dpi$"1314_7_OA1" + sig1314_tpm_7dpi$"1314_7_OA2" + sig1314_tpm_7dpi$"1314_7_OA3")/3)
sig1314_tpm_7dpi$av_1314_7_SA <- ((sig1314_tpm_7dpi$"1314_7_SA1" + sig1314_tpm_7dpi$"1314_7_SA2" + sig1314_tpm_7dpi$"1314_7_SA3")/3)
sig1314_tpm_7dpi$av_1314_7_SO <- ((sig1314_tpm_7dpi$"1314_7_SO1" + sig1314_tpm_7dpi$"1314_7_SO2" + sig1314_tpm_7dpi$"1314_7_SO3")/3)

sig1314_tpm_7dpi$triadTPMsum <- (sig1314_tpm_7dpi$av_1314_7_OA + sig1314_tpm_7dpi$av_1314_7_SA + sig1314_tpm_7dpi$av_1314_7_SO)

sig1314_tpm_7dpi$percentTPM_OA <- ((sig1314_tpm_7dpi$av_1314_7_OA/sig1314_tpm_7dpi$triadTPMsum)*100)
sig1314_tpm_7dpi$percentTPM_SA <- ((sig1314_tpm_7dpi$av_1314_7_SA/sig1314_tpm_7dpi$triadTPMsum)*100)
sig1314_tpm_7dpi$percentTPM_SO <- ((sig1314_tpm_7dpi$av_1314_7_SO/sig1314_tpm_7dpi$triadTPMsum)*100)

sig1314_tpm_7dpi$percentTPM_check <- (sig1314_tpm_7dpi$percentTPM_OA+sig1314_tpm_7dpi$percentTPM_SA + sig1314_tpm_7dpi$percentTPM_SO)
summary(sig1314_tpm_7dpi$percentTPM_check)

sig1314_tpm_7dpi_ternary <- data.frame(sig1314_tpm_7dpi$gene, sig1314_tpm_7dpi$percentTPM_OA,sig1314_tpm_7dpi$percentTPM_SA,sig1314_tpm_7dpi$percentTPM_SO)
colnames(sig1314_tpm_7dpi_ternary)
colnames(sig1314_tpm_7dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")
write.xlsx(sig1314_tpm_7dpi_ternary, "~/Desktop/ternary_plots/sig1314_percenttpm_7dpi.xlsx")

ternaryplot_1314_7dpi <- ggtern(data=sig1314_tpm_7dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for 1314 at 7dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_1314_7dpi

### sig1314_tpm_11dpi ###
sig1314_tpm_11dpi <- data.frame(sig1314_TPMlist$gene, sig1314_TPMlist$"1314_11_OA1", sig1314_TPMlist$"1314_11_OA2", sig1314_TPMlist$"1314_11_OA3", sig1314_TPMlist$"1314_11_SA1", sig1314_TPMlist$"1314_11_SA2", sig1314_TPMlist$"1314_11_SA3", sig1314_TPMlist$"1314_11_SO1", sig1314_TPMlist$"1314_11_SO2", sig1314_TPMlist$"1314_11_SO3")
View(sig1314_tpm_11dpi)
names(sig1314_tpm_11dpi) <- c("gene", "1314_11_OA1", "1314_11_OA2", "1314_11_OA3", "1314_11_SA1", "1314_11_SA2", "1314_11_SA3", "1314_11_SO1", "1314_11_SO2", "1314_11_SO3" )

sig1314_tpm_11dpi$av_1314_11_OA <- ((sig1314_tpm_11dpi$"1314_11_OA1" + sig1314_tpm_11dpi$"1314_11_OA2" + sig1314_tpm_11dpi$"1314_11_OA3")/3)
sig1314_tpm_11dpi$av_1314_11_SA <- ((sig1314_tpm_11dpi$"1314_11_SA1" + sig1314_tpm_11dpi$"1314_11_SA2" + sig1314_tpm_11dpi$"1314_11_SA3")/3)
sig1314_tpm_11dpi$av_1314_11_SO <- ((sig1314_tpm_11dpi$"1314_11_SO1" + sig1314_tpm_11dpi$"1314_11_SO2" + sig1314_tpm_11dpi$"1314_11_SO3")/3)

sig1314_tpm_11dpi$triadTPMsum <- (sig1314_tpm_11dpi$av_1314_11_OA + sig1314_tpm_11dpi$av_1314_11_SA + sig1314_tpm_11dpi$av_1314_11_SO)

sig1314_tpm_11dpi$percentTPM_OA <- ((sig1314_tpm_11dpi$av_1314_11_OA/sig1314_tpm_11dpi$triadTPMsum)*100)
sig1314_tpm_11dpi$percentTPM_SA <- ((sig1314_tpm_11dpi$av_1314_11_SA/sig1314_tpm_11dpi$triadTPMsum)*100)
sig1314_tpm_11dpi$percentTPM_SO <- ((sig1314_tpm_11dpi$av_1314_11_SO/sig1314_tpm_11dpi$triadTPMsum)*100)

sig1314_tpm_11dpi$percentTPM_check <- (sig1314_tpm_11dpi$percentTPM_OA+sig1314_tpm_11dpi$percentTPM_SA + sig1314_tpm_11dpi$percentTPM_SO)


sig1314_tpm_11dpi_ternary <- data.frame(sig1314_tpm_11dpi$gene, sig1314_tpm_11dpi$percentTPM_OA,sig1314_tpm_11dpi$percentTPM_SA,sig1314_tpm_11dpi$percentTPM_SO)
colnames(sig1314_tpm_11dpi_ternary)
colnames(sig1314_tpm_11dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")
write.xlsx(sig1314_tpm_11dpi_ternary, "~/Desktop/ternary_plots/sig1314_percenttpm_11dpi.xlsx")


ternaryplot_1314_11dpi <- ggtern(data=sig1314_tpm_11dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for 1314 at 11dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_1314_11dpi
