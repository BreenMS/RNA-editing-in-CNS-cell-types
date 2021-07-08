use warnings;
use strict;
require "parse_pileup_query.pl"; 

if (@ARGV != 3) {
	die "need to provide 3 input:\n\n
	1. List of RNA editing sites from REDIportal\n
	2. INDEXED BAM alignment file (STAR alignment preferred)\n
	3. Output file name\n";
}
my ($inputfile, $bamfile, $outputfile) = ($ARGV[0], $ARGV[1], $ARGV[2]);

#GLOBAL VARIABLES

my $minbasequal = 20; # MINIMUM BASE QUALITY SCORE
my $minmapqual = 10; # MINIMUM READ MAPPING QUALITY SCORE
my $sampath = "samtools"; #PATH TO THE SAMTOOLS EXECUTABLE
my $genomepath = "/sc/arion/projects/breen_lab/COVID_hyperediting/HE_GenomeIndex_v3/GRCh38.primary_assembly.genome.fa"; #PATH TO REFERENCE GENOME
my $offset = 33; #BASE QUALITY SCORE OFFSET - 33 FOR SANGER SCALE, 64 FOR ILLUMINA SCALE


my $bedtemp = join '', $outputfile, '.bed';
system("awk \'\$1\!\=\"chromosome\"\{print \$1\"\t\"\$2-1\"\t\"\$2\}\' $inputfile \> $bedtemp");
my $piletemp = join '', $outputfile, '.pileup';
system("$sampath mpileup -A -B -I -d 1000000 -q $minmapqual -Q $minbasequal -f $genomepath -l $bedtemp $bamfile \> $piletemp");

my %sitehash;
open (my $PILEUP, "<", $piletemp);
while(<$PILEUP>) {
	chomp;
	my ($chr, $position, $refnuc, $coverage, $pile, $qual) = split;
	my $location = join '_', $chr, $position;
	my ($refnuccount, $acount, $tcount, $ccount, $gcount) = &parse_pileup($_, $minbasequal, $offset);# parse each line of pileup
	my $counts = join ',', $refnuccount, $ccount, $gcount;
	$sitehash{$location} = $counts;
}
system("rm $bedtemp");
system("rm $piletemp");

open (my $INPUT , "<", $inputfile) or die "error opening inputfile: $!\n";
open (my $OUTPUT, ">", $outputfile);
print $OUTPUT "#Chrom\tPosition\tGene\tStrand\tConversion\tAnnotation\tAlu\tCoverage\tEditedreads\tEditlevel\n";

while (<$INPUT>) {
	chomp;
	my @fields = split;
	next if ($fields[0] eq 'chromosome');
	my ($chr, $position) = ($fields[0], $fields[1]);
	my $location = join '_', $chr, $position;
	my ( $strand, $conversion, $novelty, $alu, $region, $gene, $group) = ($fields[2], $fields[3],$fields[4], $fields[5],$fields[6], $fields[7],$fields[8]);



	if ($sitehash{$location}) { #PRINT OUT RESULT
		my ($refcount, $ccount, $gcount) = split(/\,/,$sitehash{$location});
		my ($newcov, $newmismatch) = (0,0);
		if ($strand eq '+')
			{$newmismatch = $gcount;}
				else {$newmismatch = $ccount;}
				
		$newcov = $refcount + $newmismatch;
		
		if ($newcov > 5)
		{	my $varfreq = 0;
			$varfreq = sprintf("%.3f", $newmismatch/$newcov);
			print $OUTPUT "$fields[0]\t$fields[1]\t$gene\t$strand\t$conversion\t$novelty\t$alu\t$region\t$group\t$newcov\t$newmismatch\t$varfreq\n";
		}
			#else {print $OUTPUT "$fields[0]\t$fields[1]\t$gene\t$strand\t$conversion\t$novelty\t$alu\t$region\t$group\t0\t0\tN/A\n";}
	}
			#else {print $OUTPUT "$fields[0]\t$fields[1]\t$gene\t$strand\t$conversion\t$novelty\t$alu\t$region\t$group\t0\t0\tN/A\n";}
}
close $INPUT;	
close $OUTPUT;
