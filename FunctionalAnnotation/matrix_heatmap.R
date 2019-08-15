library(readxl)
library(gplots)
library(RColorBrewer)
# install.packages("openxlsx")
library(openxlsx)


total_matrix_F22_OA_pfdr <- read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/total_matrix_F22_OA_pfdr.xlsx", 
                                                                        col_types = c("text", "text", "numeric", 
                                                                                                "text", "numeric", "numeric", "numeric", 
                                                                                                "numeric", "numeric", "numeric", 
                                                                                                "numeric", "numeric", "numeric", 
                                                                                                "numeric", "numeric", "numeric", 
                                                                                                "numeric", "numeric", "numeric", 
                                                                                                "numeric", "numeric"))
colnames(total_matrix_F22_OA_pfdr)
View(total_matrix_F22_OA_pfdr)

##### convert padj_bh to -log10(padj_bh) for better visualisation #####
total_matrix_F22_OA_pfdr$log10_F22_OA_C15 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C15)
total_matrix_F22_OA_pfdr$log10_F22_OA_C15[total_matrix_F22_OA_pfdr$log10_F22_OA_C15 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C14 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C14)
total_matrix_F22_OA_pfdr$log10_F22_OA_C14[total_matrix_F22_OA_pfdr$log10_F22_OA_C14 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C13 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C13)
total_matrix_F22_OA_pfdr$log10_F22_OA_C13[total_matrix_F22_OA_pfdr$log10_F22_OA_C13 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C12 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C12)
total_matrix_F22_OA_pfdr$log10_F22_OA_C12[total_matrix_F22_OA_pfdr$log10_F22_OA_C12 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C11 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C11)
total_matrix_F22_OA_pfdr$log10_F22_OA_C11[total_matrix_F22_OA_pfdr$log10_F22_OA_C11 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C10 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C10)
total_matrix_F22_OA_pfdr$log10_F22_OA_C10[total_matrix_F22_OA_pfdr$log10_F22_OA_C10 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C09 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C09)
total_matrix_F22_OA_pfdr$log10_F22_OA_C09[total_matrix_F22_OA_pfdr$log10_F22_OA_C09 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C08 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C08)
total_matrix_F22_OA_pfdr$log10_F22_OA_C08[total_matrix_F22_OA_pfdr$log10_F22_OA_C08 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C07 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C07)
total_matrix_F22_OA_pfdr$log10_F22_OA_C07[total_matrix_F22_OA_pfdr$log10_F22_OA_C07 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C06 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C06)
total_matrix_F22_OA_pfdr$log10_F22_OA_C06[total_matrix_F22_OA_pfdr$log10_F22_OA_C06 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C05 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C05)
total_matrix_F22_OA_pfdr$log10_F22_OA_C05[total_matrix_F22_OA_pfdr$log10_F22_OA_C05 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C04 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C04)
total_matrix_F22_OA_pfdr$log10_F22_OA_C04[total_matrix_F22_OA_pfdr$log10_F22_OA_C04 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C03 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C03)
total_matrix_F22_OA_pfdr$log10_F22_OA_C03[total_matrix_F22_OA_pfdr$log10_F22_OA_C03 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C02 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C02)
total_matrix_F22_OA_pfdr$log10_F22_OA_C02[total_matrix_F22_OA_pfdr$log10_F22_OA_C02 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C01 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C01)
total_matrix_F22_OA_pfdr$log10_F22_OA_C01[total_matrix_F22_OA_pfdr$log10_F22_OA_C01 == "Inf"] <- "0"
total_matrix_F22_OA_pfdr$log10_F22_OA_C00 <- -log10(total_matrix_F22_OA_pfdr$F22_OA_C00)
total_matrix_F22_OA_pfdr$log10_F22_OA_C00[total_matrix_F22_OA_pfdr$log10_F22_OA_C00 == "Inf"] <- "0"
View(total_matrix_F22_OA_pfdr)

table_logpfdr_F22_OA <- data.frame(total_matrix_F22_OA_pfdr$relevant, total_matrix_F22_OA_pfdr$GO, total_matrix_F22_OA_pfdr$NS, total_matrix_F22_OA_pfdr$depth, total_matrix_F22_OA_pfdr$name)
colnames(table_logpfdr_F22_OA) <- c("relevant", "GO", "NS", "depth", "name")

table_logpfdr_F22_OA$"-log10(F22_OA_C0)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C00)
table_logpfdr_F22_OA$"-log10(F22_OA_C1)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C01)
table_logpfdr_F22_OA$"-log10(F22_OA_C2)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C02)
table_logpfdr_F22_OA$"-log10(F22_OA_C3)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C03)
table_logpfdr_F22_OA$"-log10(F22_OA_C4)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C04)
table_logpfdr_F22_OA$"-log10(F22_OA_C5)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C05)
table_logpfdr_F22_OA$"-log10(F22_OA_C6)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C06)
table_logpfdr_F22_OA$"-log10(F22_OA_C7)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C07)
table_logpfdr_F22_OA$"-log10(F22_OA_C8)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C08)
table_logpfdr_F22_OA$"-log10(F22_OA_C9)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C09)
table_logpfdr_F22_OA$"-log10(F22_OA_C10)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C10)
table_logpfdr_F22_OA$"-log10(F22_OA_C11)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C11)
table_logpfdr_F22_OA$"-log10(F22_OA_C12)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C12)
table_logpfdr_F22_OA$"-log10(F22_OA_C13)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C13)
table_logpfdr_F22_OA$"-log10(F22_OA_C14)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C14)
table_logpfdr_F22_OA$"-log10(F22_OA_C15)" <- as.numeric(total_matrix_F22_OA_pfdr$log10_F22_OA_C15)
View(table_logpfdr_F22_OA)
write.xlsx(table_logpfdr_F22_OA, "/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_OA_total.xlsx")

#### focus on only GO terms with significant asOAciation with values ####
table_logpfdr_F22_OA_relevant <- table_logpfdr_F22_OA[(table_logpfdr_F22_OA$relevant > 0), ]
View(table_logpfdr_F22_OA_relevant)
write.xlsx(table_logpfdr_F22_OA_relevant, "/Users/rbadgami/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10_F22_OA_relevant.xlsx")
##### focus on depth 3 and 4 - error in R OA do via excel - and specify which CC/MF/BP to look at ####
# table_logpfdr_F22_OA_relevant_depth3 <- table_logpfdr_F22_OA_relevant[(table_logpfdr_F22_OA_relevant$depth == 3) & (table_logpfdr_F22_OA_relevant$NS == "BP"),]
# View(table_logpfdr_F22_OA_relevant_depth3)
# colnames(table_logpfdr_F22_OA_relevant_depth3)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C0)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C0)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C1)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C1)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C2)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C2)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C3)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C3)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C4)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C4)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C5)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C5)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C6)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C6)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C7)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C7)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C8)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C8)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C9)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C9)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C10)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C10)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C11)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C11)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C12)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C12)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C13)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C13)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C14)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C14)`)
# table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C15)`=as.numeric(table_logpfdr_F22_OA_relevant_depth3$`-log10(F22_OA_C15)`)

##### BUILDING MATRIX FOR HEATMAP #####

focus="BP"

table_neglog10pfdr_F22_OA_relevant_depth3 <-read_excel("~/Desktop/GOenrichment/temp_matrix/temp_matrix_pfdr/pfdr_matrix/table_neglog10pfdr_F22_OA_relevant_depth3.xlsx",
                                                              sheet = "focus",
                                                               col_types = c("numeric", "text", "text", 
                                                                                       "numeric", "text", "numeric", "numeric", 
                                                                                       "numeric", "numeric", "numeric", 
                                                                                       "numeric", "numeric", "numeric", 
                                                                                       "numeric", "numeric", "numeric", 
                                                                                       "numeric", "numeric", "numeric", 
                                                                                       "numeric", "numeric"))

#### make the table into a matrix  -depth 3####
matrix_neglog10pfdr_F22_OA_relevant_depth3 <- data.frame(table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C0)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C1)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C2)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C3)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C4)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C5)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C6)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C7)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C8)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C9)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C10)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C11)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C12)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C13)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C14)",
                                                     table_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C15)")
colnames(matrix_neglog10pfdr_F22_OA_relevant_depth3)
colnames(matrix_neglog10pfdr_F22_OA_relevant_depth3) <- c("-log10(F22_OA_C0)", "-log10(F22_OA_C1)", "-log10(F22_OA_C2)", "-log10(F22_OA_C3)", "-log10(F22_OA_C4)", "-log10(F22_OA_C5)", "-log10(F22_OA_C6)", "-log10(F22_OA_C7)", "-log10(F22_OA_C8)", "-log10(F22_OA_C9)", "-log10(F22_OA_C10)", "-log10(F22_OA_C11)", "-log10(F22_OA_C12)", "-log10(F22_OA_C13)", "-log10(F22_OA_C14)", "-log10(F22_OA_C15)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C0)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C0)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C1)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C1)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C2)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C2)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C3)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C3)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C4)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C4)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C5)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C5)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C6)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C6)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C7)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C7)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C8)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C8)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C9)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C9)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C10)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C10)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C11)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C11)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C12)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C12)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C13)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C13)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C14)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C14)")
matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C15)"=as.numeric(matrix_neglog10pfdr_F22_OA_relevant_depth3$"-log10(F22_OA_C15)")

#### define the rowname ####
rownames(matrix_neglog10pfdr_F22_OA_relevant_depth3) <- table_neglog10pfdr_F22_OA_relevant_depth3$name

#### make heatmap ####
my_palette <- colorRampPalette(c("grey", "white", "red"))(n = 299)
heatmap.2(as.matrix(matrix_neglog10pfdr_F22_OA_relevant_depth3),
                    main="-log10(pfdr) for MF at depth 3 for F22_OA",
                     density.info = "none",
                     trace= "none",
                     margins=c(10,15),col=my_palette,
                     Rowv=FALSE, scale="column")
