#!/usr/bin/perl

use strict;
use warnings; 

use Bio::DB::Fasta;

my $fasta = $ARGV[0];
my $txcds_file = $ARGV[1];

if (!defined $fasta || !defined $txcds_file) {
  print STDERR "$0 <fasta> <txcds table>\n";
  exit(-1);
}


print << 'EOF';
@relation normalização_sequencias

@attribute conteudo_GC numeric
@attribute AACG numeric
@attribute CCGT numeric
@attribute CGCA numeric
@attribute CGCT numeric
@attribute CGGG numeric
@attribute CGTA numeric
@attribute TACC numeric
@attribute TACG numeric
@attribute TCCG numeric
@attribute TCGC numeric
@attribute tamanho numeric
@attribute score numeric
@attribute cdsStop numeric
@attribute cdsSizes numeric
@attribute cdsPercent numeric
@attribute classes {lncRNA,mRNA}
 

@data
EOF



my $db = Bio::DB::Fasta->new ("$fasta");
open (TABLE, "<$txcds_file") or die "Nao consegui abrir $txcds_file: $!\n";
while (<TABLE>) {
  chomp;
  my ($id, $start, $end, $name, $dot, $score, @others) =   split (/\t/, $_);
  my %feature;
  my $entry = $db->get_Seq_by_id($id);
  my $seqstr = uc($entry->seq);
  $seqstr =~ s/U/T/g;
  $seqstr =~ s/-//g;
  $seqstr =~ s/N//g;
  my $nucref = countKmer($seqstr, 1);
  my $diref = countKmer($seqstr, 2);
  my $triref = countKmer($seqstr, 3);
  my $fourref = countKmer($seqstr, 4);

$feature{$id}{GC} = frequence($diref->{"GC"},$diref->{total});
$feature{$id}{AACG} = frequence($fourref->{"AACG"},$fourref->{total});
$feature{$id}{CCGT} = frequence($fourref->{"CCGT"},$fourref->{total});
$feature{$id}{CGCA} = frequence($fourref->{"CGCA"},$fourref->{total});
$feature{$id}{CGCT} = frequence($fourref->{"CGCT"},$fourref->{total});
$feature{$id}{CGGG} = frequence($fourref->{"CGGG"},$fourref->{total});
$feature{$id}{CGTA} = frequence($fourref->{"CGTA"},$fourref->{total});
$feature{$id}{TACC} = frequence($fourref->{"TACC"},$fourref->{total});
$feature{$id}{TACG} = frequence($fourref->{"TACG"},$fourref->{total});
$feature{$id}{TCCG} = frequence($fourref->{"TCCG"},$fourref->{total});
$feature{$id}{TCGC} = frequence($fourref->{"TCGC"},$fourref->{total});
$feature{$id}{tamanho} = $nucref->{total};
  $feature{$id}{score} = $score;
  $feature{$id}{stop} = $end;
  $feature{$id}{size} = $end - $start + 1;
  $feature{$id}{percent} = ($end - $start + 1)/$nucref->{total} ;
 


print $feature{$id}{GC}." , "; 
print $feature{$id}{AACG}." , "; 
print $feature{$id}{CCGT}." , ";
print $feature{$id}{CGCA}." , "; 
print $feature{$id}{CGCT}." , "; 
print $feature{$id}{CGGG}." , "; 
print $feature{$id}{CGTA}." , ";
print $feature{$id}{TACC}." , "; 
print $feature{$id}{TACG}." , "; 
print $feature{$id}{TCCG}." , "; 
print $feature{$id}{TCGC}." , "; 
  print $feature{$id}{tamanho}." , ";
  print $feature{$id}{score}." , ";
  print $feature{$id}{stop}." , ";
  print $feature{$id}{size}." , ";
  print $feature{$id}{percent}." , ";

  print "?\n";



}
close (TABLE);




sub countKmer {
  my $seqstr = shift;
  my $k = shift;
  my $total = 0;
  my %kmer;
  
  for (my $i = 0; $i < length($seqstr) - $k + 1; $i++) {
    my $s = substr ($seqstr, $i, $k);
    $kmer{$s}++;
    $total ++;
  }
  $kmer{total} = $total;
  return \%kmer;
}


sub frequence {
  my $x = shift;
  my $total = shift;
  if (defined $x) {
    return ($x)/$total;
  }
  return 0.0;
}
