#!/usr/bin/perl -w
#############################################
#Author: John Peacock
#email:  johnnpeacock@gmail.com
#############################################
use strict;
use warnings;

=pod

=head1 SYNOPSIS

A wrap of genbank2gtf_mRNA.pl to batch convert genbank format into gtf (only those mRNA features)

=head1 USAGE

perl batch_annotation_mRNA.pl

=head1 RESULTS

20 chrXX_mRNA.gtf files

=cut


my @files=<*.gb>;
foreach my $f (@files){
    #print $f,"\n";
    my $chr=$f;
    $chr=~s/\.gb//g;
    $chr=~s/Chr/chr/g;
    print $chr,"\n";
    `perl genbank2gtf_mRNA.pl  $f $chr>${chr}_mRNA.gtf`;
}
