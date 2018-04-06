library(GeneOverlap)

#Input .gmt formated user-defined gene/protein lists. 
list1 <- scan("DGE.gmt", what="", sep="\n")
list1a <- strsplit(list1, "[[:space:]]+")
names(list1a) <- sapply(list1a, `[[`, 1)
list1a <- lapply(list1a, `[`, -1)

#Input .gmt formated gene-sets for comparison. 
list2 <- scan("GO_Biological_Process_2017.gmt", what="", sep="\n") #GO_Cellular_Component_2017.gmt, GO_Molecular_Function_2017.gmt etc...
list2a <- strsplit(list2, "[[:space:]]+")
names(list2a) <- sapply(list2a, `[[`, 1)
list2a <- lapply(list2a, `[`, -1)

DEGSetCounts=sapply(list1a, length) #obtain the number of genes/proteins in each user list
GenesinGeneSet=sapply(list2a, length) #obtain the number of genes in each gene-set

go.obj <- newGeneOverlap(list1a,list2a,genome.size=24000) #Constructor for the GeneOverlap class
go.obj <- testGeneOverlap(go.obj) #Test function for th GeneOverlap Class - perform Fisher's exact test based on information supplied in GeneOverlap object. This function also calculates the Jaccard index. 
gom.obj <- newGOM(list1a, list2a, 24000) #Constructor for the GeneOverlap class
 
ptab=getMatrix(gom.obj, name="pval") # print p-values for all overlaps
otab=getMatrix(gom.obj, "odds.ratio") # print odds-ratios for all overlaps
itab=getMatrix(gom.obj, "intersection") # print the number of intersecting gene for all overlaps

#Transpose
ptab=t(ptab)
otab=t(otab)
colnames(otab)=c("Odds-Ratio.list1Down","Odds-Ratio.list1Up","Odds-Ratio.list2Down","Odds-Ratio.list2Up")
itab=t(itab)
colnames(itab)=c("Intersect.list1Down","Intersect.list1Up","Intersect.list2Down","Intersect.list2Up")

#BH multiple test correction for each user-defined list
ptab=as.data.frame(ptab)
AdjustedP_list1Down=p.adjust(ptab$List1Down, method="BH") #List1 down-regulated genes
AdjustedP_list1Up=p.adjust(ptab$List1Up, method="BH")  #List1 up-regulated genes
AdjustedP_list2Down=p.adjust(ptab$List2Down, method="BH") #List2 down-regulated genes
AdjustedP_list2Up=p.adjust(ptab$List2Up, method="BH") #List2 up-regulated genes

#Organize the output files
ptab=cbind(AdjustedP_list1Down,AdjustedP_list1Up, AdjustedP_list2Down, AdjustedP_list2Up)
GeneRatio=(itab/GenesinGeneSet)
colnames(GeneRatio)=c("GeneRatio.list1Down","GeneRatio.list1Up","GeneRatio.list2Down","GeneRatio.list2Up")
matrix=cbind(ptab, otab, itab, GeneRatio,GenesinGeneSet)
dim(matrix)

#Remove genesets with FDR p-value > 0.1
filter<-apply(ptab,1, function(x) length(x[x<0.1])>=1) 
filtered <- matrix[filter,]
dim(filtered)
write.table(filtered, "GeneSetresults.txt", sep="\t")
 
 
#OPTIONAL - pull out the overlapping gene/protein names for a specified gene list
#Here we pull overlapping genes for List1 upregulated genes. 
overlapping=lapply(list1a, function(x) lapply(list2a, function(y) intersect(x,y)))
list1upoverlap=gsub("\"", "", overlapping$List1Up)
list1upoverlap=gsub("c","",list1upoverlap)
list1upoverlap=gsub("harater","NA",list1upoverlap)

matrix=cbind(matrix,list1upoverlap)
filter<-apply(ptab,1, function(x) length(x[x<0.1])>=1) 
filtered <- matrix[filter,]
dim(filtered)
write.table(filtered, "GeneSetresults2.txt", sep="\t")