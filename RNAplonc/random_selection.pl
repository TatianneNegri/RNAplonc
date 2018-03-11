#!/usr/bin/perl
use strict;
use warnings;
use 5.014;

my $fileIn = $ARGV[0];
open(IN,"<$fileIn") or die "ERROR: I could not open the file $fileIn\n";
print "Please, enter the quantity: ";
my $quant = <STDIN>;
my @arquivo = split(/\./,$fileIn); 
my $s = 0;
my $VALOR = '';
$/ = ">";
$| = 1;
my @id ='';
my @seq = '';
my $lng = '';

while(<IN>){ #FASTA formatted sequences as input
 chomp;

  my ($titleline, $sequence) = split(/\n/,$_,2);
    next unless ($sequence && $titleline);
  study($sequence); 
	$lng=length($sequence);

	if($lng >= 200){

		$id[$s] = $titleline;
		$seq[$s] = $sequence;	 

		$s++;	
	}
}
print $s;
BEGIN { srand() if $] < 5.004 }

$VALOR = $s;

my ($i, $j, $k);
my @vec = ();

my $n = $VALOR;

$i = 0;
while ($i<$n) { $vec[$i++] = -1; }

($i, $j) = (0, 0);
while ($i<$n) {

   $j = 1 + int rand($n);

   $k = 0;
   while ($k<=$i && $vec[$k++]!=$j) {}

   $vec[$i++] = $j if ($k==$i+1);

}

$i = 0;

my $resultado ='';
my $num ='';
while ($i<$quant) { 
$num = $vec[$i++];
$resultado .=  ">$id[$num]\n"."$seq[$num]";
}
open(my $fh, '>', $arquivo[0].$quant.'.fasta');
print $fh "$resultado";
close $fh;
close(IN);


