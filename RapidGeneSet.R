library(GeneOverlap)

sri=read.table("GMTFiles.txt", stringsAsFactors=FALSE)
files=basename(sri$V1)

#Input .gmt formated user-defined gene/protein lists. 
list1 <- scan("DGE.gmt", what="", sep="\n")
list1a <- strsplit(list1, "[[:space:]]+")
names(list1a) <- sapply(list1a, `[[`, 1)
list1a <- lapply(list1a, `[`, -1)

for(i in 1:length(files))
{
message(files[i]) #print gmt file currently under analysis

#Input .gmt formated gene-sets for comparison. 
list2 <- scan(files[i], what="", sep="\n") 
list2a <- strsplit(list2, "[[:space:]]+")
names(list2a) <- sapply(list2a, `[[`, 1)
list2a <- lapply(list2a, `[`, -1)

DEGSetCounts=sapply(list1a, length) #obtain the number of genes/proteins in each user list
GenesinGeneSet=sapply(list2a, length) #obtain the number of genes in each gene-set

go.obj <- newGeneOverlap(list1a,list2a,genome.size=24000) #Constructor for the GeneOverlap class
go.obj <- testGeneOverlap(go.obj) #Test function for th GeneOverlap Class - perform Fisher's exact test based on information supplied in GeneOverlap object. This function also calculates the Jaccard index. 
gom.obj <- newGOM(list1a, list2a, 24000) #Constructor for the GeneOverlap class
 
ptab=getMatrix(gom.obj, name="pval") #print p-values for all overlaps
otab=getMatrix(gom.obj, "odds.ratio") #print odds-ratios for all overlaps
itab=getMatrix(gom.obj, "intersection") # print the number of intersecting gene for all overlaps

#Transpose
ptab=t(ptab)
colnames(ptab) <- paste(colnames(ptab), "Pvalue", sep = "_")
otab=t(otab)
colnames(otab) <- paste(colnames(otab), "OddsRatio", sep = "_")
itab=t(itab)
colnames(itab) <- paste(colnames(itab), "Intersect", sep = "_")

#BH multiple test correction for each user-defined list
ptab=as.data.frame(ptab)
NumberGeneSets=length(ptab[,1])

AdjustedPvalues <- apply(ptab,2,p.adjust,method="BH", n = NumberGeneSets)
colnames(AdjustedPvalues) <- paste(colnames(AdjustedPvalues), "BHAdjusted", sep = "_")

#Calculate GeneRatio for each overlap
GeneRatio=(itab/GenesinGeneSet)
colnames(GeneRatio) <- paste(colnames(GeneRatio), "Ratio", sep = "_")

#Organize the output files
matrix=cbind(ptab, AdjustedPvalues, otab, itab, GeneRatio,GenesinGeneSet)
dim(matrix)
write.table(matrix, paste(files[i],"enrichmnt.txt", sep="."))
}
