#!/usr/bin/perl
#ssr.pl

#Search for simple sequence repeats in
#FASTA-formatted DNA sequences. Each FASTA record
#looks like this (the record delimiter is ">"):

#    >SequenceID with optional text on same line
#    sequence data on one or more lines

#for example,

#    >12345xyz this is a nice sequence of the Foo gene
#    atgccatgataggactatttattttttctcact
#    gaccatcacccncacttaaagcatgggcggatttacta
#    etc.

$/ = ">";
$| = 1;
my $seqcount;
my $fileIn = $ARGV[0];
my @arquivo = split(/\./,$fileIn); 
  
open(IN,"<$fileIn") or die "ERROR: I could not open the file $fileIn\n";
my $resultado = '';
my $t=0;
while(<IN>){ #FASTA formatted sequences as input
    chomp;
    my ($titleline, $sequence) = split(/\n/,$_,2);
    next unless ($sequence && $titleline);
    $seqcount++;
    my ($id) = $titleline =~ /^(\S+)/; #the ID is the first whitespace-
                                       #delimited item on titleline
    $sequence =~ s/\s//g; #concatenate multi-line sequence
    study($sequence);     #is this necessary?
    my $seqlength = length($sequence);
     
     
       if($seqlength >= 200) {
	    print  $id . "=" .$seqlength." \n";
	$resultado .= ">$titleline\n"."$sequence\n";
$t++;
	}
}
open(my $fh, '>', $arquivo[0].'_.fasta');
print $t;
print $fh "$resultado";
close $fh;
close(IN);




