#We implemented code from the RNAEditingIndexer: https://github.com/a2iEditing/RNAEditingIndexer
#Note - our version of the pipeline would delete a mapped bam file after working on it, so we would always apply this method to a copy of the original mapped bam
#module load rnaeditingindexer
RNAEditingIndex -d .
-f H444_OLIG.Aligned.sortedByCoord.out.bam
-o .
--genes_expression /sc/arion/projects/breen_lab/AEI/GenesExpression/HomoSapiens/ucscHg38GTExGeneExpression.bed.gz
--refseq /sc/arion/projects/breen_lab/AEI/RefSeqAnnotations/HomoSapiens/ucscHg38RefSeqCurated.bed.gz
--snps /sc/arion/projects/breen_lab/AEI/SNPs/HomoSapiens/ucscHg38CommonGenomicSNPs150.bed.gz
-gf /sc/arion/projects/breen_lab/AEI/Genomes/HomoSapiens/ucscHg38Genome.fa
-rb /sc/arion/projects/breen_lab/AEI/Regions/HomoSapiens/ucscHg38Alu.bed.gz
--genome UserProvided
--paired_end
--stranded #this option was left as unstranded for GTEX data

