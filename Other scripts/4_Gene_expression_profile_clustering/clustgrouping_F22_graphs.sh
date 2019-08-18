cd /Users/rbadgami/Desktop/data2/Cluster_matrix
clustfile="/Users/rbadgami/Desktop/data2/data_clustgroupgraphs"

# F22-infected cultivars have been grouped into these clusters.
#group='group1'; COA="C6:F22_OA"; CSO="C12:F22_SO"; CSA="C6:F22_SA"
#group='group2'; COA="C12:F22_OA"; CSO="noSOhere"; CSA="C14:F22_SA"
#group='group3'; COA="C0:F22_OA"; CSO="C0:F22_SO"; CSA="C0:F22_SA"
#group='group4'; COA="C15:F22_OA"; CSO="C5:F22_SO"; CSA="noSAhere"
#group='group5'; COA="C7:F22_OA"; CSO="C4:F22_SO"; CSA="C7:F22_SA"
#group='group6'; COA="noOAhere"; CSO="C6:F22_SO"; CSA="C13:F22_SA"
#group='group7'; COA="noOAhere"; CSO="noSOhere"; CSA="C12:F22_SA"
#group='group8'; COA="C5:F22_OA"; CSO="noSOhere"; CSA="C15:F22_SA"
#group='group9'; COA="C4:F22_OA"; CSO="C11:F22_SO"; CSA="C5:F22_SA"
#group='group10'; COA="C9:F22_OA"; CSO="C2:F22_SO"; CSA="C9:F22_SA"
#group='group11'; COA="C2:F22_OA"; CSO="C9:F22_SO"; CSA="C3:F22_SA"
#group='group12'; COA="C1:F22_OA"; CSO="C7:F22_SO"; CSA="C1:F22_SA"
#group='group13'; COA="C8:F22_OA"; CSO="C3:F22_SO"; CSA="noSAhere"
#group='group14'; COA="C10:F22_OA"; CSO="noSOhere"; CSA="C10:F22_SA"
#group='group15'; COA="C4:F22_OA"; CSO="C10:F22_SO"; CSA="C4:F22_SA"
#group='group16'; COA="C13:F22_OA"; CSO="C8:F22_SO"; CSA="C2:F22_SA"
#group='group17'; COA="C14:F22_OA"; CSO="C13:F22_SO"; CSA="noSAhere"
#group='group18'; COA="noOAhere"; CSO="C1:F22_SO"; CSA="C11:F22_SA"
#group='group19'; COA="C11:F22_OA"; CSO="C15:F22_SO"; CSA="noSAhere"
# collate Clust-normalised tpm values from the identification_final_cluster_matrix file.
grep $COA identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' | while read line; do grep $line identification_final_Clust_pattern_F22.csv; done | grep 'F22_OA' > $clustfile/$group\_normalisedClusttpm.csv; grep $CSO identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' | while read line; do grep $line identification_final_Clust_pattern_F22.csv; done | grep 'F22_SO' >> $clustfile/$group\_normalisedClusttpm.csv; grep $CSA identification_final_cluster_matrix_F22.csv | awk -F ',' '{print $1}' | while read line; do grep $line identification_final_Clust_pattern_F22.csv; done | grep 'F22_SA' >> $clustfile/$group\_normalisedClusttpm.csv

# make graph into long-form
mkdir /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/long_data
cd $clustfile
for files in *.csv ; do
	echo 'Sample,Genes,dpi,value' > long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $6, $1, "01", $3}' $files | tail -n +2  >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $6, $1, "03", $4}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $6, $1, "07", $5}' $files | tail -n +2 >> long_data/long_$files &&
	awk -F ',' 'BEGIN{OFS=",";}{print $6, $1, "11", $6}' $files | tail -n +2 >> long_data/long_$files;
done


cd /Users/rbadgami/Desktop/data2/data_clustgroupgraphs/long_data
filelocation_longdata="/Users/rbadgami/Desktop/data2/data_clustgroupgraphs/long_data"
R_plotfile="Rplot_data_clustgraphs"
# write all the foreword for the Rplot
# load relevant packages
echo "library(readr)" > $filelocation_longdata/$R_plotfile.R &&
echo "library(reshape2)" >> $filelocation_longdata/$R_plotfile.R &&
echo "library(ggplot2)" >> $filelocation_longdata/$R_plotfile.R &&
echo "library(ggpubr)" >> $filelocation_longdata/$R_plotfile.R  &&
# read the files to make the relevant dataframes
echo "filenames <- list.files(path=\""$filelocation_longdata"\", pattern=\"long_group+.*csv\")" >> $filelocation_longdata/$R_plotfile.R &&
echo "names <- substr(filenames,6,nchar(filenames)-4)" >> $filelocation_longdata/$R_plotfile.R &&
echo "for(i in names){ filepath <- file.path(\""$filelocation_longdata"\",paste(\"long_clusterdata_\",i,\".csv\", sep=\"\"))" >> $filelocation_longdata/$R_plotfile.R &&
echo "assign(paste0(\"x\",i), read.delim(filepath, colClasses=c(rep(\"factor\",2),rep(\"numeric\",2)), sep=\",\"))}" >> $filelocation_longdata/$R_plotfile.R &&
echo "dataframes <- names(which(unlist(eapply(.GlobalEnv,is.data.frame))))" >> $filelocation_longdata/$R_plotfile.R  &&
# have an appropriate colourscheme for plots
echo "library(RColorBrewer)" >> $filelocation_longdata/$R_plotfile.R &&
echo "irisColors <- setNames( c(\"#A6CEE3\", \"#1F78B4\", \"#B2DF8A\", \"#33A02C\", \"#FB9A99\", \"#E31A1C\"), c(\"1314_SO\", \"F22_SO\", \"1314_SA\", \"F22_SA\", \"1314_OA\", \"F22_OA\"))" >> $filelocation_longdata/$R_plotfile.R &&
echo "plot.new()" >> $filelocation_longdata/$R_plotfile.R &&
echo "pdf(\""$filelocation_longdata/$R_plotfile".pdf\",height=11, width=8.5)" >> $filelocation_longdata/$R_plotfile.R &&
echo "plot.new()" >> $filelocation_longdata/$R_plotfile.R &&
# make a loop to make the plots
count="0" &&
for files in *.csv; do
	dataframe=$(echo $files | sed 's/^F22_/^F22_/g' |sed 's/long_clusterdata_F22_/1314_/g' | sed 's/1314_SA.csv/1314_SA/g')
	pattern=$(echo $dataframe | sed 's/^1314_/"1314_/g' | sed 's/1314_OA_/1314_OAn/g' | sed 's/1314_SO_/1314_SOn/g' | sed 's/1314_SA/1314_SA/g')
	count=`expr $count + 1`
	echo "plot1314_"$count "<- ggplot() + geom_line(data=x"$dataframe", aes(x = dpi, y=value, lineshape = Genes, colour=Sample)) +ggtitle("$pattern"ngenes:"$(tail -n +2 $files | awk -F ',' 'BEGIN{OFS=",";}{print $2}' | sort -u | wc -l)"\") + theme(axis.title = element_text(size=8)) + xlab(\"days post-inoculation\") + ylab(\"Clust value\") + labs(fill = \"Sample\") +points(x=x"$dataframe"$dpi) + scale_x_continuous(breaks = c(1, 3, 7, 11)) + scale_colour_manual(values = irisColors)+ theme(legend.position = \"none\")" >> $filelocation_Rplot/$R_plotfile.R;
	if [ $count -eq 10 ]; then echo "ggarrange(plot1314_1, plot1314_2, plot1314_3, plot1314_4, plot1314_5, plot1314_6, plot1314_7, plot1314_8, plot1314_9, plot1314_10, plot1314_11, plot1314_12, plot1314_13, plot1314_14, plot1314_15, plot1314_16, ncol = 4, nrow = 4)" >> $filelocation_longdata/$R_plotfile.R;fi;
