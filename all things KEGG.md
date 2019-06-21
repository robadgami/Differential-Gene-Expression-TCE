# 21 June 2019

## To KEGG or not to KEGG

I want to work out how to do KEGG on the DEGs I've found for the sigCONsigISO and cluster_lists.

Looking at [KOBAS 3.0](http://kobas.cbi.pku.edu.cn/annotate.php), I think the wheat geneID needs to be converted to an available organism. Trawling through the [organism lists](https://www.genome.jp/kegg/catalog/org_list.html), the closest monocot grass may be `Oryza sativa japonica (Japanese rice) (RefSeq)`  or `Aegilops tauschii (wheat D)`. 

Heyooo, so...

(1) make a list of the genes releavant to that cultivar at that timepoint:

```sh
cd /Users/rbadgami/Desktop/data2/read_count_data/DESeq2_isolate/LFC/table_LFCisanumber/LFC_dpi_cultivar/sigCONandsigCULTIVAR/comparing_list

cat F22_1dpi_OA*.txt | sort | uniq > /Users/rbadgami/Desktop/genelist_F22_1dpi_OA.txt
```



(2) Go onto [plant ensembl biomart](https://plants.ensembl.org/biomart/martview/35431c23cb3cfb067a8e5d32e49cf4de) and find equivalent in rice:

Set the following parameters:

- 'Ensembl Plants Genes 43'
- Database: Triticum aestivum (IWGSC)
- Filters > Gene
  - Source (gene): IWGSC
  - Input external references ID list(Gene stable ID(s) [e.g. ENSRNA050007810]: [ID-list specified]): input file (as list of genes)
- Attributes
  - Features > Gene stable ID
  - Homologues > Orthologues > Oryza sativa Japonica Group gene stable ID

Click 'Results' > save as tsv file "rice_wheat_F22_1dpi_OA.txt"



(3) On plant ensembl biomart convert rice gene ID to NCBI gene ID:

- Dataset: Oryza sativa Japonica Group genes (IRGSP-1.0)
- Filters
  - Input external references ID list: Gene stable ID(s) [e.g. ENSRNA049440515]: [ID-list specified]
- Attributes > Filter
  - Gene stable ID
  - External References > KEGG Pathway and Enzyme ID; NCBI gene ID

(4) On  [KOBAS 3.0](http://kobas.cbi.pku.edu.cn/annotate.php), find enriched KEGG pathways:

Gene-list Enrichment

- Input:
  - Type: Entrez Gene ID (*its the NCBI list*)
  - Species: [Oryza sativa japonica (Japanese rice) (RefSeq)](http://kobas.cbi.pku.edu.cn/anno_iden.php)
  - Upload file of NCBI list
  - Database: Pathway > tick KEGG Pathway
  - Options for statistics:
    - Statistical method: hypergeometric test/Fisher's exact test
    - FDR correction method: Benjamini Hochbery (1995)

Click 'Run'

Save the results table: [rice_F22_1dpi_OA](http://kobas.cbi.pku.edu.cn/result_kobas.php?taskid=190621309837770) ) as an .xlsx file.

(5) Finding significant KEGG pathways.

- Open as .xlsx file "KEGG_rice_F22_1dpi_OA.xlsx"

- cut-off at 'Corrected P-Value' (*i.e. Benjamini Hochberg correction of p-value*) <= 0.05



For F22_1dpi_OA:

KEGG pathway suggests enrichment in F22_OA at 1dpi  show metbaolism changes, signalling nd protein metabolism

—> 'variation in metabolism and changes in characteristics'







Examples on writing methods:

'KEGG pathways for the DEGs were retrieved ([http://www.genome.jp/kegg/](http://www.genome.jp/kegg/)), and KOBAS software was used to test the statistical significance of the enrichment of DEGs in KEGG pathways.' [Xiong, H. et al (2017)](https://www.nature.com/articles/s41598-017-03024-0#Sec7).

https://www.nature.com/articles/s41598-017-03024-0

F22_1dpi_OAonly: http://kobas.cbi.pku.edu.cn/result_kobas.php?taskid=190621589191608

