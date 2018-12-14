# Rapid gene set enrichment analysis across multiple user-defined gene lists
When performing gene-set enrichment analysis, one often wishes to compare gene set enrichment results across multiple user-defined gene lists. This may include gene lists defined by different combinations of user-defined cutoffs (P-values and fold changes) or multiple gene lists gathered from independent/related studies. 

Here I provide R statistical code (RapidGeneSet.R) that performs rapid geneset enrichment analysis across multiple user lists. RapidGeneSet.R requires a text file in list format (GMT_file.txt) which should contain a list of .gmt libraries (i.e.  GO:CC, GO:MF, GO:BP, GTEx tissue specific genes etc...) stored in a local directory. 


Comments, questions or otherwise, feel free to contact me @ michael.breen@mssm.edu
