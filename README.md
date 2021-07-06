# Dissecting epitranscriptional signatures by RNA editing in purified cortical cell types powers discovery and interpretation in bulk brain tissue
Ryn Cuddleston, Junhao Li, Xuanjia Fan, Alexy Kozenkov, Matthew Lalli, Stella Dracheva, Eran A. Mukamel, Michael S. Breen

Posttranscriptional modifications by RNA editing are pervasive in the brain, yet their cellular and genetic drivers remain poorly described. We quantified base-specific RNA editing across three major cell populations from the human prefrontal cortex: medial ganglionic eminence (MGE)-derived GABAergic neurons, glutamatergic neurons and oligodendrocytes. We uncovered a global increase in selective editing and RNA hyper-editing in neurons relative to oligodendrocytes. Bioinformatic analysis identified 189,229 bona fide cell type-associated sites spanning introns, 3’UTRs and exons, including sites implicated in neurodevelopment and neurological disorders. The cellular specificity for thousands of sites was confirmed by snRNA-sequencing. Importantly, cell type-associated sites were enriched in GTEx RNA-sequencing data, edited ~twentyfold higher than all other sites, and variation in RNA editing was predominately explained by neuronal proportions in bulk brain tissue. Finally, we discovered 661,791 cis-editing quantitative trait loci across thirteen brain regions, including hundreds with cell type-associated features. These data expand the repertoire of highly regulated RNA editing sites across cell types, brain regions and their genetic regulation. 

Here you can find:

Supplemental Tables 1-10:
Table S1. Alu editing index and hyper-editing across purified cortical cell populations.   
Table S2. Annotation of all 189,229 cell-specific RNA editing sites in the current study. 
Table S3. RNA editing sites as a function of ADAR expression and RBPs. 
Table S4. Differential RNA editing across cell types, plus pathway and disease enrichment.  
Table S5. RNA recoding events across cell types. 
Table S6. The number of RNA editing events by gene length. 
Table S7. Validation of RNA editing sites by snRNA-seq cellular pools. 
Table S8. Features of RNA editing in GTEx brain regions.   
Table S9. Total number of sites by genic region following sample thresholds  per brain region. 
Table S10. Max-edQTLs across bulk GTEx brain regions. 

Useful data files:
CNS_A2G_15221edits.txt = A matrix of 15,221 RNA editing sites detected across all cell populations. 
CNS_A2G_events.txt = Annotation of 166,215 A-to-I RNA editing sites detected within each cell population. 

Useful code:
query_known_sites.pl= perl script that excutes mpileup (samtools) to query a list of known RNA editing sites.
parse_pileup_query.pl = a requirement for query_known_sites.pl

GTEx RNA editing matrices per brain region:


An Rshiny app enabling users to download sites based on a gene of interest: https://breenms.shinyapps.io/CNS_RNA_Editing
