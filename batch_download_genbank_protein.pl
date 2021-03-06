#!/usr/bin/perl
#############################################
#Author: John Peacock
#email:  johnnpeacock@gmail.com
#############################################
use strict;
use warnings;

=pod

=head1 SYNOPSIS

Use NCBI etuils (efetch) to download information in genbank format with a given protein id (NP_XXXXX)

=head1 USAGE

perl batch_download_genbank_protein.pl

=head1 RESULTS

Results are stored in a subfolder named NP in your current working directory. Files are named is proteinid.gb

=cut


my $log="download_protein.log";
open(LOG,">$log") or die $!;
my @files=<chr*_CDS.gtf>;

foreach my $f (@files){
    print LOG "[",scalar(localtime),"] Downloading $f\n";
    open(IN,"grep protein_id $f |cut -f9 |cut -f6 -d';'|cut -f3 -d' '|sort |uniq |sed 's/\"//g' |") or die $!;
    while(<IN>){
        s/\r|\n//g;
        next if (/^$/);
        my $p=$_;
        print LOG "\t$p\t";
        my $out="NP/$p.gb";
        my $comm = "wget \"https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=protein&id=$p&rettype=gb&retmode=text\" -O $out --no-check-certificate";
        
        if(-s $out){
            print LOG "YES\n";
            next;
        }
       system($comm);

        if(!-s $out){
            print LOG "NO\n";
        }else{
            print LOG "YES\n";
        }
    }
}

