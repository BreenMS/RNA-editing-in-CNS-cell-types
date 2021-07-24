# Cellular and genetic drivers of RNA editing variation in the human brain
Ryn Cuddleston, Junhao Li, Xuanjia Fan, Alexy Kozenkov, Matthew Lalli, Stella Dracheva, Eran A. Mukamel, Michael S. Breen<br />

Posttranscriptional adenosine-to-inosine modifications amplify the functionality of RNA molecules in the brain, yet the cellular and genetic regulation of RNA editing is poorly described. We quantified base-specific RNA editing across three major cell populations from the human prefrontal cortex: glutamatergic neurons, medial ganglionic eminence GABAergic neurons, and oligodendrocytes. We found more selective editing and RNA hyper-editing in neurons relative to oligodendrocytes. The pattern of RNA editing was highly cell type-specific, with 189,229 cell type-associated sites. The cellular specificity for thousands of sites was confirmed by single nucleus RNA-sequencing. Importantly, cell type-associated sites were enriched in GTEx RNA-sequencing data, edited ∼twentyfold higher than all other sites, and variation in RNA editing was predominantly explained by neuronal proportions in bulk brain tissue. Finally, we discovered 661,791 cis-editing quantitative trait loci across thirteen brain regions, including hundreds with cell type-associated features. These data reveal an expansive repertoire of highly regulated RNA editing sites across human brain cell types and provide a resolved atlas linking cell types to editing variation and genetic regulatory effects.<br />

# This work entails four main levels of analysis:
1. Compute an Alu Editing Index (AEI) from a STAR mapped bam file  [(RNAEditingIndexer v1.0)](https://github.com/a2iEditing/RNAEditingIndexer)<br /> 
2. Quantifying RNA editing sites from STAR mapped bam files using de novo methods [(reditools v2.0)](https://github.com/tizianoflati/reditools2.0)<br /> 
3. Quantifying RNA editing from STAR mapped bam files using a list of predefined list of sites (code provided below)<br /> 
4. Quantifying RNA hyper-editing sites from STAR unmapped fastq files [(method based on Porath et al., 2017)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1315-y)<br /> 

# 1. Compute AEI from a STAR mapped bam file:
We used already available software from the [RNAEditingIndexer GitHub account](https://github.com/a2iEditing/RNAEditingIndexer) to compute an AEI based on a mapped bam file. The method is describe in the original publication, [Nat. Methods (2019)](https://pubmed.ncbi.nlm.nih.gov/31636457/). Here, we provide an example of bash shell script that executes the AEI on one sample. Requirements and parameters are described in full in the bash script.  <br /> 
 
```ruby
AEI.sh
```
<br />  

# 2. Quantify RNA editing sites from STAR mapped bam files using de novo methods:
We used already available software from the [reditools v2.0 GitHub account](https://github.com/tizianoflati/reditools2.0) to quantify de novo RNA editing sites based on a STAR mapped bam file. The method is describe in the original publication, [BMC Bioinformatics (2020)](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-020-03562-x). Here, we provide an example of bash shell script that executes reditools 2.0 on one sample. Requirements and parameters are described in full in the bash script.  <br /> 

```ruby
reditools_caller.sh
```

<br />  


# 3. Quantify RNA editing from STAR mapped bam files using a list of predefined list of sites (based on a predefined list of sites):
It is often of interest to quantify RNA editing sites based on a user defined list of sites. Samtools mpileup has the functionality to execute this task. Here we provide two perl scripts that will achieve this task. The only requirement is installing a recent version of samtools.  <br /> 


query_known_sites.pl= excute mpileup (samtools) to query a list of known editing sites.<br />
parse_pileup_query.pl = a requirement for query_known_sites.pl<br />  
Usage: perl query_known_sites.pl [A predefined list of known editing sites] [STAR mapped bam file] [Output file name]
```ruby
perl query_known_sites.pl CNS_A2G_events.txt SampleName.bam OutputFileName.txt
```
<br />  

# Helpful data files:
CNS_A2G_events.txt = A predefined list of 166,215 A-to-I RNA editing sites detected within each cell population.<br /> 
CNS_A2G_15221edits.txt = A matrix of 15,221 RNA editing sites we detected across all three cell populations.<br /> 

<br />  

# 4. Quantifying RNA hyper-editing sites from STAR unmapped fastq files:
We used already available software from the [RNA hyper-editing GitHub account](https://github.com/hagitpt/Hyper-editing) to quantify RNA hyper-editing sites based on a STAR unmapped fastq files. The method is describe in the original publication, [Genome Biology (2017)](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1315-y). We provide a detailed example of how we execute this pipeline providing all code, with minor modifications, at [Ryn Cuddleston's GitHub account](https://github.com/ryncuddleston/RNA-hyper-editing) .  <br /> 


<br />  

# All data are available through an interactive Rshiny interface
An Rshiny app enabling users to download sites based on a gene of interest:<br />
https://breenms.shinyapps.io/CNS_RNA_Editing<br /> 
Notably, all GTEx RNA editing matrices are downloadable through this Rshiny app.<br /> 

# Supplemental Data Tables 1-11:
Table S1. Alu editing index and hyper-editing across purified cortical cell populations.<br />
Table S2. Annotation of all 189,229 cell-specific RNA editing sites in the current study.<br />
Table S3. RNA editing sites as a function of ADAR expression and RBPs.<br />
Table S4. Differential RNA editing across cell types, plus pathway and disease enrichment.<br />
Table S5. RNA recoding events across cell types.<br />
Table S6. rhAmpSeq validation of recoding RNA-editing sites.<br /> 
Table S7. The number of RNA editing events by gene length.<br /> 
Table S8. Validation of RNA editing sites by snRNA-seq cellular pools.<br /> 
Table S9. Features of RNA editing in GTEx brain regions.<br />
Table S10. Total number of sites by genic region following sample thresholds  per brain region.<br /> 
Table S11. Max-edQTLs across bulk GTEx brain regions.<br /> 


