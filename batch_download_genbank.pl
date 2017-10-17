#!/usr/bin/perl
#############################################
#Author: John Peacock
#email:  johnnpeacock@gmail.com
#############################################
use strict;
use warnings;

=pod

=head1 SYNOPSIS

Use NCBI etuils (efetch) to download each chromosome's annotation in genbank format of Cat genome.

=head1 USAGE

perl batch_download_genbank.pl

=head1 RESULTS

In your current working directory. There will generate 20 ChrXX.gb files.


=cut


## Script begin
# The chromosomes ids of Mus musculus comes from http://www.ncbi.nlm.nih.gov/genome/52
# Apply NCIB eutils to download genbank (full) format files of each chromosome

my $log="download.log";
while(<DATA>){
    next if (!/^Chr/);
    my ($chr,$name,$refseq,@other) = split /\s+/;
    print "[",scalar(localtime),"] Downloading ${chr}${name}|$refseq \n";
    my $comm = "wget \"https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=$refseq&rettype=gbwithparts&retmode=text\" -O ${chr}${name}.gb >>$log 2>&1 --no-check-certificate";
    
    #print $comm,"\n\n";
    
    # Due to interent, some of the donwloads may fail, thus, you could 
    #re-run the program without downloading the already downloaded ones.
    if(! -s "${chr}${name}.gb"){
        print "Yes\n";
        system($comm);
    }
}

__DATA__
Type	Name	RefSeq	INSDC	Size (Mb)	GC%	Protein	rRNA	tRNA	Other RNA	Gene	Pseudogene
Chr	1	NC_000067.6	CM000994.2	195.47	41.3	4,731	-	37	2,031	2,687	579
Chr	2	NC_000068.7	CM000995.2	182.11	42.2	6,282	-	8	2,783	3,491	609
Chr	3	NC_000069.6	CM000996.2	160.04	40.7	3,507	-	40	1,663	2,225	480
Chr	4	NC_000070.6	CM000997.2	156.51	42.5	4,710	-	8	1,991	2,622	497
Chr	5	NC_000071.6	CM000998.2	151.84	42.7	4,634	-	10	1,952	2,507	413
Chr	6	NC_000072.6	CM000999.2	149.74	41.6	3,844	1	53	1,572	2,597	555
Chr	7	NC_000073.6	CM001000.2	145.44	43.2	6,336	-	10	2,087	3,798	935
Chr	8	NC_000074.6	CM001001.2	129.4	42.6	3,653	32	7	1,673	2,177	376
Chr	9	NC_000075.6	CM001002.2	124.6	42.9	4,406	-	7	1,698	2,276	374
Chr	10	NC_000076.6	CM001003.2	130.7	41.6	3,546	-	11	1,546	2,086	391
Chr	11	NC_000077.6	CM001004.2	122.08	44.0	5,650	-	47	2,097	2,852	381
Chr	12	NC_000078.6	CM001005.2	120.13	42.0	2,621	-	3	1,593	2,002	516
Chr	13	NC_000079.6	CM001006.2	120.42	41.9	2,536	-	105	1,513	2,127	476
Chr	14	NC_000080.6	CM001007.2	124.9	41.4	3,007	-	12	1,538	2,111	455
Chr	15	NC_000081.6	CM001008.2	104.04	42.2	2,872	-	4	1,349	1,620	282
Chr	16	NC_000082.6	CM001009.2	98.21	41.2	2,486	-	2	1,081	1,367	257
Chr	17	NC_000083.6	CM001010.2	94.99	42.9	3,610	-	12	1,373	2,005	427
Chr	18	NC_000084.6	CM001011.2	90.7	41.7	1,855	-	-	966	1,218	264
Chr	19	NC_000085.6	CM001012.2	61.43	43.1	2,328	-	10	831	1,283	205
Chr	X	NC_000086.7	CM001013.2	171.03	39.7	3,010	-	17	933	2,291	912
Chr	Y	NC_000087.7	CM001014.2	91.74	39.3	335	-	-	119	423	85
MT	NC_005089.1	AY172335.1	0.02	36.7	13	2	22	-	37	-
Un	-	.	-	93.44	43.6	2,471	2	10	1,126	2,899	501
