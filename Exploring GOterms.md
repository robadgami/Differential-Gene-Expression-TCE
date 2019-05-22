# Exploring GO terms

A gene/set of genes within a GOannotation table has many GOterms assigned to it which are redundant. I want a way of quickly grouping similar GOterms/genes together for a more methodical way of investigating the BP/CC/MF associated with each comparative cluster pattern.

## TEST-RUNNING

I have copied a file `pfdr0.01_table-C9_1314_OA_C4_1314_SO_C0_1314_SA.txt` into directory path ` /Users/rbadgami/Desktop/data2/Cluster_matrix/1314_temp_genelist/comparative_cluster_patterns_1314/GOannotation/GOannotation_table_pfdr0.01/test/`. 



The GOannotation table columns are:

| GO   | NS   | enrichment | name | ratio_in_study | ratio_in_pop | p_uncorrected | depth | study_count | p_bonferroni | p_sidak | p_holm | p_fdr_bh | study_items |
| ---- | ---- | ---------- | ---- | -------------- | ------------ | ------------- | ----- | ----------- | ------------ | ------- | ------ | -------- | ----------- |
| $1   | $2   | $3         | $4   | $5             | $6           | $7            | $8    | $9          | $10          | $11     | $12    | $13      | $14         |

(1) make a new file with columns `study_items	depth|GO|NS|name` for terms deeper than level 1

``` sh
awk -F '\t' 'BEGIN{OFS="\t";}$8 > 2 && $8 < 9{print $14,$8 "|" $2 "|" $1	"|" $4}' pfdr0.01_table-C9_1314_OA_C4_1314_SO_C0_1314_SA.txt | sort -k2n > testfile.txt
```

(2) combine lines with **exact matching** study_items list [reference](https://stackoverflow.com/questions/46734615/combine-lines-with-matching-first-field)

``` sh
sort -r testfile.txt | awk -F '\t' 'BEGIN{OFS="\t";}{a[$1]=a[$1]"\t"$2;} END {for (x in a) print x "\t" substr(a[x],2);}' testfile.txt | sort > testfile2.txt
```

(3) combine lines with **90% similar matching** study_items list

> what i want to do:
>
> (1) focus on line1 i.e. study_items list
>
> (2) make string into separate fields (separate by deliminater ',')
>
> (3) calculate number of fields derived from line1
>
> (4) if any of those fields match then give





I want to do: If there is >=90% similarity of genes ($14) then merge the lines together i.e. its now in a line with column 'GOgroup' 'GOs' 'names' 'ratio in study' 'depths' 'study_count' 'study_items'

-  Do not care how often a gene appears (hence cannot use cosine similarity)
- Hence, could use Jaccard Similarity ('si')

(1) take list of genes from GOannotation table `awk -F '\t' '{print $14}'` 

(2) each GOterm is assigned its study_items list: i.e. 

``` sh
# make study_items string into list:
count='0';while read line; do
count=`expr $count + 1`
echo $line | awk -F '\t' '{print $1}' | tr ", " "\n" | sed '/^$/d' > array$count.txt; done < testfile2.txt
echo $count	# number of arrays

# compare array1 and array2:
array1count='0';array2count='0';samevalue='0';
while read line; do
array1count=`expr $array1count + 1`
	while read value; do
	array2count=`expr $array2count + 1`;
	if [ $line == $value ]; then
	samevalue=`expr $samevalue + 1`;
	fi;
	done < array2.txt;
done < array1.txt; array2count=`expr $array2count / $array1count`; uniquevalue=`expr $array1count + $array2count - $samevalue` 
# calculate percentage similarity (Jaccord Similarity) rounded to nearest integer
fractionsimilar=$(awk "BEGIN { pc=100*${samevalue}/${uniquevalue}; i=int(pc); print (pc-i<0.5)?i:i+1}")
#to three decimal places: fractionsimilar=$(echo "scale=1; $samevalue / $uniquevalue * 100" | bc)
wc -l array1.txt
echo $array1count
wc -l array2.txt
echo $array2count
echo $samevalue
echo $uniquevalue
echo $fractionsimilar

```

I want to find Jaccard similarity between array1 and all files

``` sh
for comparer in array*.txt; do
for files in array*.txt;do
array1count='0';array2count='0';samevalue='0';
while read line; do
array1count=`expr $array1count + 1`
	while read value; do
	array2count=`expr $array2count + 1`;
	if [ $line == $value ]; then
	samevalue=`expr $samevalue + 1`;
	fi;
	done < $files;
done < $comparer; array2count=`expr $array2count / $array1count`; uniquevalue=`expr $array1count + $array2count - $samevalue` 
fractionsimilar=$(awk "BEGIN { pc=100*${samevalue}/${uniquevalue}; i=int(pc); print (pc-i<0.5)?i:i+1}");
echo $comparer $files $fractionsimilar | tr ' ' '\t' >> matrix.txt
done;
echo "end $comparer"
rm $comparer
done
```

> What i want to do:
>
> (1) sort by largest Jaccard similarity to smallest (keep at >=80% similarity):
>
> cat matrix.txt | tr ' ' '\t' | grep -v "100" | awk '!/0/' | awk '($3 > 79)' | sort -r  -k3n > matrix_sorted2.txt
>
> (2) find highest number and put those lines together:
>
> mostsimilar=$(tail -1 copy_matrix_sorted2.txt )
>
> `tail -1 copy_matrix_sorted2.txt | awk -F '\t' '{print $1}' >lineA`
>
> 
>
> echo   $lineA >> similaritylist.txt
>
> lineB=$(awk -F '\t' '{print $2}' copy_matrix_sorted2.txt) 
>
> Echo $lineB >> similaritylist.txt
>
> grep $lineA



``` sh
cp matrix_sorted2.txt copy_matrix_sorted2.txt

#make a list of all the arrays
awk -F '\t' '{print $1}' copy_matrix_sorted2.txt | sort -u > temp2_list.txt
awk -F '\t' '{print $2}' copy_matrix_sorted2.txt | sort -u >> temp2_list.txt; sort -u temp2_list.txt > temp_list.txt; rm temp2_list.txt

# take first thing and grep it from the copy_matrix_sorted2.txt
#while read line; do
#grep $line copy_matrix_sorted2.txt >> order_matrix.txt; sed /$line/d #copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt #copy_matrix_sorted2.txt; done < temp_list.txt
#isn't quite what i want :(

# find the most similar and grep the first array:
arr=$(head -1 temp_list.txt);
grep $arr copy_matrix_sorted2.txt >> order_matrix_$arr;
# remove that $arr form the temp_list.txt and copy_matrix:
sed /$arr/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt;
sed /$arr/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt
# grep all matching that and put into that array file:
cut -d$'\t' -f2 order_matrix_$arr | while read line; do
grep $line copy_matrix_sorted2.txt >> order_matrix_$arr;
sed /$line/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt;
sed /$line/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt
done && 
cut -d$'\t' -f1 order_matrix_$arr | while read line; do
grep $line copy_matrix_sorted2.txt >> order_matrix_$arr;
sed /$line/d copy_matrix_sorted2.txt > temp_copy_matrix_sorted2.txt; mv temp_copy_matrix_sorted2.txt copy_matrix_sorted2.txt;
sed /$line/d temp_list.txt > temp_temp_list.txt; mv temp_temp_list.txt temp_list.txt
done
##### I NEED A WAY TO BE ABLE TO TELL WHEN IT IS NO LONGER SHORTENING THE copy_matrix_sorted2.txt; then it goes back to the arr="..."

#### THEN I need a way for it to recognise that temp_list.txt is empty and remove it and stop the loops.

### THEN I WANT TO MAKE THE ARRAYS INTO LISTS.txt
for files in order_matrix_array*.txt; do
awk -F '\t' '{print $1}' $files | sort -u > temp_list_$files.txt
awk -F '\t' '{print $2}' $files | sort -u >> temp_list_$files.txt; sort -u temp_list_$files.txt > list_$files.txt; rm temp_list_$files.txt; done

### THEN A WAY OF GREPPING THE LINE CORRESPONDING TO THE LIST SO IT IS PUT IN THIS ORDER WITH THE APPROPRIATE NAME GIVEN IN AN EXTRA COLUMN.

# i had a quick look at the processes and i think 80% is too stringent maybe try reducing it to 70%
```





So, now want to make a heatmap of sorts:

(1) sort each line by most to least similar

(2) convert long-form to wide-form data [reference](https://www.unix.com/shell-programming-and-scripting/241097-long-wide-format.html). 

``` sh
# sort each line by most to least similar - i can now see which are most similar to that line
cat matrix.txt | sort -r -k1,1 -k3n | tr ' ' '\t' | grep -v "100" | awk '!/0/' | awk '($3 > 79)' > matrix_sorted2.txt

```

``` sh
sort -k3n matrix_sorted2.txt | sed 's/array/line/g;s/.txt//g'
```





(2) convert long-format to wide-format data [info here](https://www.unix.com/shell-programming-and-scripting/241097-long-wide-format.html). 

``` sh
cat matrix.txt | tr ' ' '\t' | awk '{
  a[$2,$1]=a[$1,$2]=$3
  l[$1];l[$2]
 }
 END {
  for (i in l) {
   printf "%10s", i
  }
  printf "\n"
  for (i in l) {
   printf "%-10s", i
   for (j in l) {
    printf "%-10s", a[i,j]?a[i,j]:0
   }
   printf "\n"
  }
 }' | tr '.txt' '\t' | tr '         ' '\t'> matrix2.txt
```







I now want to put this percentage from this comparison into an array.

Indexed arrays (-a) have ordered integers while associative arrays (-A)are strings.

`declare -a percentage_array1`

Percentage_array1=()





``` sh
n=0; awk -F '\t' '{print $1}' pfdr0.01_table-C10_1314_OA_NA_1314_SO_NA_1314_SA.txt | while read line; do
n=$((n + 1))
echo line$n
done

awk -F '\t' '$14==last {printf ":%s",$1; next} NR>1 {print "";} {last=$1; printf "%s",$0;} END{print "";}' pfdr0.01_table-C10_1314_OA_NA_1314_SO_NA_1314_SA.txt > testfile.txt
```



(2) if lines are more than 90% similar then merge lines together 

` if 