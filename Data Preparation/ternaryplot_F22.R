# install.packages("xlsReadWrite")
library("xlsReadWrite")
library(readxl)
# install.packages("openxlsx")
library("openxlsx")
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
sigF22_TPMlist<- read_excel("~/Desktop/sigF22_TPMlist.xlsx")
View(sigF22_TPMlist)
colnames(sigF22_TPMlist)

#### sigF22_tpm_1dpi ####
sigF22_tpm_1dpi <- data.frame(sigF22_TPMlist$gene, sigF22_TPMlist$"F22_1_OA1", sigF22_TPMlist$"F22_1_OA2", sigF22_TPMlist$"F22_1_OA3", sigF22_TPMlist$"F22_1_SA1", sigF22_TPMlist$"F22_1_SA2", sigF22_TPMlist$"F22_1_SA3", sigF22_TPMlist$"F22_1_SO1", sigF22_TPMlist$"F22_1_SO2", sigF22_TPMlist$"F22_1_SO3")
View(sigF22_tpm_1dpi)
names(sigF22_tpm_1dpi) <- c("gene", "F22_1_OA1", "F22_1_OA2", "F22_1_OA3", "F22_1_SA1", "F22_1_SA2", "F22_1_SA3", "F22_1_SO1", "F22_1_SO2", "F22_1_SO3" )

sigF22_tpm_1dpi$av_F22_1_OA <- ((sigF22_tpm_1dpi$"F22_1_OA1" + sigF22_tpm_1dpi$"F22_1_OA2" + sigF22_tpm_1dpi$"F22_1_OA3")/3)
sigF22_tpm_1dpi$av_F22_1_SA <- ((sigF22_tpm_1dpi$"F22_1_SA1" + sigF22_tpm_1dpi$"F22_1_SA2" + sigF22_tpm_1dpi$"F22_1_SA3")/3)
sigF22_tpm_1dpi$av_F22_1_SO <- ((sigF22_tpm_1dpi$"F22_1_SO1" + sigF22_tpm_1dpi$"F22_1_SO2" + sigF22_tpm_1dpi$"F22_1_SO3")/3)

sigF22_tpm_1dpi$triadTPMsum <- (sigF22_tpm_1dpi$av_F22_1_OA + sigF22_tpm_1dpi$av_F22_1_SA + sigF22_tpm_1dpi$av_F22_1_SO)
sigF22_tpm_1dpi$percentTPM_OA <- ((sigF22_tpm_1dpi$av_F22_1_OA/sigF22_tpm_1dpi$triadTPMsum)*100)
sigF22_tpm_1dpi$percentTPM_SA <- ((sigF22_tpm_1dpi$av_F22_1_SA/sigF22_tpm_1dpi$triadTPMsum)*100)
sigF22_tpm_1dpi$percentTPM_SO <- ((sigF22_tpm_1dpi$av_F22_1_SO/sigF22_tpm_1dpi$triadTPMsum)*100)

sigF22_tpm_1dpi$percentTPM_check <- (sigF22_tpm_1dpi$percentTPM_OA+sigF22_tpm_1dpi$percentTPM_SA + sigF22_tpm_1dpi$percentTPM_SO)
summary(sigF22_tpm_1dpi$percentTPM_check)

sigF22_tpm_1dpi_ternary <- data.frame(sigF22_tpm_1dpi$gene, sigF22_tpm_1dpi$percentTPM_OA,sigF22_tpm_1dpi$percentTPM_SA,sigF22_tpm_1dpi$percentTPM_SO)
colnames(sigF22_tpm_1dpi_ternary)
colnames(sigF22_tpm_1dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")

write.xlsx(sigF22_tpm_1dpi_ternary, "~/Desktop/ternary_plots/sigF22_percenttpm_1dpi.xlsx")

ternaryplot_F22_1dpi <- ggtern(data=sigF22_tpm_1dpi_ternary,aes(percentTPM_OA, percentTPM_SA, percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for F22 at 1dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_F22_1dpi


#### sigF22_tpm_3dpi ####
sigF22_tpm_3dpi <- data.frame(sigF22_TPMlist$gene, sigF22_TPMlist$"F22_3_OA1", sigF22_TPMlist$"F22_3_OA2", sigF22_TPMlist$"F22_3_OA3", sigF22_TPMlist$"F22_3_SA1", sigF22_TPMlist$"F22_3_SA2", sigF22_TPMlist$"F22_3_SA3", sigF22_TPMlist$"F22_3_SO1", sigF22_TPMlist$"F22_3_SO2", sigF22_TPMlist$"F22_3_SO3")
View(sigF22_tpm_3dpi)
names(sigF22_tpm_3dpi) <- c("gene", "F22_3_OA1", "F22_3_OA2", "F22_3_OA3", "F22_3_SA1", "F22_3_SA2", "F22_3_SA3", "F22_3_SO1", "F22_3_SO2", "F22_3_SO3" )

sigF22_tpm_3dpi$av_F22_3_OA <- ((sigF22_tpm_3dpi$"F22_3_OA1" + sigF22_tpm_3dpi$"F22_3_OA2" + sigF22_tpm_3dpi$"F22_3_OA3")/3)
sigF22_tpm_3dpi$av_F22_3_SA <- ((sigF22_tpm_3dpi$"F22_3_SA1" + sigF22_tpm_3dpi$"F22_3_SA2" + sigF22_tpm_3dpi$"F22_3_SA3")/3)
sigF22_tpm_3dpi$av_F22_3_SO <- ((sigF22_tpm_3dpi$"F22_3_SO1" + sigF22_tpm_3dpi$"F22_3_SO2" + sigF22_tpm_3dpi$"F22_3_SO3")/3)

sigF22_tpm_3dpi$triadTPMsum <- (sigF22_tpm_3dpi$av_F22_3_OA + sigF22_tpm_3dpi$av_F22_3_SA + sigF22_tpm_3dpi$av_F22_3_SO)
sigF22_tpm_3dpi$percentTPM_OA <- ((sigF22_tpm_3dpi$av_F22_3_OA/sigF22_tpm_3dpi$triadTPMsum)*100)
sigF22_tpm_3dpi$percentTPM_SA <- ((sigF22_tpm_3dpi$av_F22_3_SA/sigF22_tpm_3dpi$triadTPMsum)*100)
sigF22_tpm_3dpi$percentTPM_SO <- ((sigF22_tpm_3dpi$av_F22_3_SO/sigF22_tpm_3dpi$triadTPMsum)*100)

sigF22_tpm_3dpi$percentTPM_check <- (sigF22_tpm_3dpi$percentTPM_OA+sigF22_tpm_3dpi$percentTPM_SA + sigF22_tpm_3dpi$percentTPM_SO)
summary(sigF22_tpm_3dpi$percentTPM_check)

sigF22_tpm_3dpi_ternary <- data.frame(sigF22_tpm_3dpi$gene, sigF22_tpm_3dpi$percentTPM_OA,sigF22_tpm_3dpi$percentTPM_SA,sigF22_tpm_3dpi$percentTPM_SO)
colnames(sigF22_tpm_3dpi_ternary)

colnames(sigF22_tpm_3dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")

write.xlsx(sigF22_tpm_3dpi_ternary, "~/Desktop/ternary_plots/sigF22_percenttpm_3dpi.xlsx")


ternaryplot_F22_3dpi <- ggtern(data=sigF22_tpm_3dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for F22 at 3dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_F22_3dpi

### sigF22_tpm_7dpi ####
sigF22_tpm_7dpi <- data.frame(sigF22_TPMlist$gene, sigF22_TPMlist$"F22_7_OA1", sigF22_TPMlist$"F22_7_OA2", sigF22_TPMlist$"F22_7_OA3", sigF22_TPMlist$"F22_7_SA1", sigF22_TPMlist$"F22_7_SA2", sigF22_TPMlist$"F22_7_SA3", sigF22_TPMlist$"F22_7_SO1", sigF22_TPMlist$"F22_7_SO2", sigF22_TPMlist$"F22_7_SO3")
View(sigF22_tpm_7dpi)
names(sigF22_tpm_7dpi) <- c("gene", "F22_7_OA1", "F22_7_OA2", "F22_7_OA3", "F22_7_SA1", "F22_7_SA2", "F22_7_SA3", "F22_7_SO1", "F22_7_SO2", "F22_7_SO3" )

sigF22_tpm_7dpi$av_F22_7_OA <- ((sigF22_tpm_7dpi$"F22_7_OA1" + sigF22_tpm_7dpi$"F22_7_OA2" + sigF22_tpm_7dpi$"F22_7_OA3")/3)
sigF22_tpm_7dpi$av_F22_7_SA <- ((sigF22_tpm_7dpi$"F22_7_SA1" + sigF22_tpm_7dpi$"F22_7_SA2" + sigF22_tpm_7dpi$"F22_7_SA3")/3)
sigF22_tpm_7dpi$av_F22_7_SO <- ((sigF22_tpm_7dpi$"F22_7_SO1" + sigF22_tpm_7dpi$"F22_7_SO2" + sigF22_tpm_7dpi$"F22_7_SO3")/3)

sigF22_tpm_7dpi$triadTPMsum <- (sigF22_tpm_7dpi$av_F22_7_OA + sigF22_tpm_7dpi$av_F22_7_SA + sigF22_tpm_7dpi$av_F22_7_SO)

sigF22_tpm_7dpi$percentTPM_OA <- ((sigF22_tpm_7dpi$av_F22_7_OA/sigF22_tpm_7dpi$triadTPMsum)*100)
sigF22_tpm_7dpi$percentTPM_SA <- ((sigF22_tpm_7dpi$av_F22_7_SA/sigF22_tpm_7dpi$triadTPMsum)*100)
sigF22_tpm_7dpi$percentTPM_SO <- ((sigF22_tpm_7dpi$av_F22_7_SO/sigF22_tpm_7dpi$triadTPMsum)*100)

sigF22_tpm_7dpi$percentTPM_check <- (sigF22_tpm_7dpi$percentTPM_OA+sigF22_tpm_7dpi$percentTPM_SA + sigF22_tpm_7dpi$percentTPM_SO)
summary(sigF22_tpm_7dpi$percentTPM_check)

sigF22_tpm_7dpi_ternary <- data.frame(sigF22_tpm_7dpi$gene, sigF22_tpm_7dpi$percentTPM_OA,sigF22_tpm_7dpi$percentTPM_SA,sigF22_tpm_7dpi$percentTPM_SO)
colnames(sigF22_tpm_7dpi_ternary)

colnames(sigF22_tpm_7dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")

write.xlsx(sigF22_tpm_7dpi_ternary, "~/Desktop/ternary_plots/sigF22_percenttpm_7dpi.xlsx")


ternaryplot_F22_7dpi <- ggtern(data=sigF22_tpm_7dpi_ternary,aes(sigF22_tpm_7dpi.percentTPM_OA,sigF22_tpm_7dpi.percentTPM_SA,sigF22_tpm_7dpi.percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for F22 at 7dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_F22_7dpi

### sigF22_tpm_11dpi ###
sigF22_tpm_11dpi <- data.frame(sigF22_TPMlist$gene, sigF22_TPMlist$"F22_11_OA1", sigF22_TPMlist$"F22_11_OA2", sigF22_TPMlist$"F22_11_OA3", sigF22_TPMlist$"F22_11_SA1", sigF22_TPMlist$"F22_11_SA2", sigF22_TPMlist$"F22_11_SA3", sigF22_TPMlist$"F22_11_SO1", sigF22_TPMlist$"F22_11_SO2", sigF22_TPMlist$"F22_11_SO3")
View(sigF22_tpm_11dpi)
names(sigF22_tpm_11dpi) <- c("gene", "F22_11_OA1", "F22_11_OA2", "F22_11_OA3", "F22_11_SA1", "F22_11_SA2", "F22_11_SA3", "F22_11_SO1", "F22_11_SO2", "F22_11_SO3" )

sigF22_tpm_11dpi$av_F22_11_OA <- ((sigF22_tpm_11dpi$"F22_11_OA1" + sigF22_tpm_11dpi$"F22_11_OA2" + sigF22_tpm_11dpi$"F22_11_OA3")/3)
sigF22_tpm_11dpi$av_F22_11_SA <- ((sigF22_tpm_11dpi$"F22_11_SA1" + sigF22_tpm_11dpi$"F22_11_SA2" + sigF22_tpm_11dpi$"F22_11_SA3")/3)
sigF22_tpm_11dpi$av_F22_11_SO <- ((sigF22_tpm_11dpi$"F22_11_SO1" + sigF22_tpm_11dpi$"F22_11_SO2" + sigF22_tpm_11dpi$"F22_11_SO3")/3)

sigF22_tpm_11dpi$triadTPMsum <- (sigF22_tpm_11dpi$av_F22_11_OA + sigF22_tpm_11dpi$av_F22_11_SA + sigF22_tpm_11dpi$av_F22_11_SO)

sigF22_tpm_11dpi$percentTPM_OA <- ((sigF22_tpm_11dpi$av_F22_11_OA/sigF22_tpm_11dpi$triadTPMsum)*100)
sigF22_tpm_11dpi$percentTPM_SA <- ((sigF22_tpm_11dpi$av_F22_11_SA/sigF22_tpm_11dpi$triadTPMsum)*100)
sigF22_tpm_11dpi$percentTPM_SO <- ((sigF22_tpm_11dpi$av_F22_11_SO/sigF22_tpm_11dpi$triadTPMsum)*100)

sigF22_tpm_11dpi$percentTPM_check <- (sigF22_tpm_11dpi$percentTPM_OA+sigF22_tpm_11dpi$percentTPM_SA + sigF22_tpm_11dpi$percentTPM_SO)


sigF22_tpm_11dpi_ternary <- data.frame(sigF22_tpm_11dpi$gene, sigF22_tpm_11dpi$percentTPM_OA,sigF22_tpm_11dpi$percentTPM_SA,sigF22_tpm_11dpi$percentTPM_SO)
colnames(sigF22_tpm_11dpi_ternary)

colnames(sigF22_tpm_11dpi_ternary) <- c("gene", "percentTPM_OA", "percentTPM_SA", "percentTPM_SO")

write.xlsx(sigF22_tpm_11dpi_ternary, "~/Desktop/ternary_plots/sigF22_percenttpm_11dpi.xlsx")

ternaryplot_F22_11dpi <- ggtern(data=sigF22_tpm_11dpi_ternary,aes(percentTPM_OA,percentTPM_SA,percentTPM_SO)) + geom_point(alpha = 0.8, size =0.005, col="gray") +
  ggtitle("percentTPM for F22 at 11dpi") + theme_showarrows() + xlab("OA") + ylab("SA") + zlab("SO")
ternaryplot_F22_11dpi
