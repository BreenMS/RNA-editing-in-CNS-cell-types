sampleID=',file_name1,'
BAM=/path/to/',file_name1,'.bam

INFILE=$BAM
OUTFILE=${sampleID}.rediout.gz
REF=/sc/arion/projects/H_PBG/REFERENCES/GRCh38/FASTA/GRCh38.chrom.fa
REFINDEX=/sc/arion/projects/H_PBG/REFERENCES/GRCh38/FASTA/GRCh38.chrom.fa.fai
PROC=40
HOMPOL=/sc/arion/projects/buxbaj01a/enrico/homopolymeric_sites_hg38.txt

#### Sort and index BAM file using samtools

module load samtools

samtools sort -o ${sampleID}_sorted.bam -@ $PROC $INFILE
samtools index ${sampleID}_sorted.bam -@ $PROC

module purge

module load reditools
### create temp directory
mkdir temp_cov
mkdir temp_results

######## REDITOOLS ################
## generate coverage file for multi-threading (~1h)

/hpc/packages/minerva-centos7/reditools/2.0/reditools2.0/extract_coverage_dynamic.sh ${sampleID}_sorted.bam temp_cov/ $REFINDEX

# Run parallel reditools
mpirun -np 40 /hpc/packages/minerva-centos7/reditools/2.0/reditools2.0/src/cineca/parallel_reditools.py -f ${sampleID}_sorted.bam -r $REF -S -s 1 -ss 5 -mrl 50 -q 10 -bq 20 -C -T 2 -m $HOMPOL -os 5 -t temp_results/ -Z $REFINDEX -G temp_cov/${sampleID}*.cov -D temp_cov/ -o ${sampleID}_out

# Merge outputs in a single file
module load htslib/1.7

/hpc/packages/minerva-centos7/reditools/2.0/reditools2.0/merge.sh temp_results $OUTFILE 40

bgzip -d  ${sampleID}.rediout.gz

#remove temp folders and files
rm -fr temp_cov
rm -fr temp_results
rm ${sampleID}_sorted.bam ${sampleID}_sorted.bam.bai