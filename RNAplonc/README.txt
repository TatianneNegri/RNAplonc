RNAplonc
Copyright © 2016 - All Rights Reserved
Developed by Tatianne Negri
Manuscript submitted:

Negri et al. RNAplonc: a tool for identification of plant long non-coding RNAs. 2017 – submitted.

====================

Before to start, it is necessary to install CD-HIT-EST and txCdsPredict. After, it just unzips the RNAplonc.zip.

CD-HIT-EST is for taking similar sequences, if you want the whole result not to do this step. This step is optional, since the CD-hit takes the strings with redundancy.


PS: path is the location of the RNAplonc folder.

1 - dataset.fasta

Input of data: The input sequences must be in fasta format, according to the model below:

>12345xyz this is a nice sequence of the Foo gene
atgccatgataggactatttattttttctcactaccatcacccncacttaaagcatgggcggatttacta
>12345xyz this is a nice sequence of the Foo gene
atgccatgataggactatttattttttctcactaccatcacccncacttaaagcatgggcggatttacta

2 - 200nt.pl

The 200nt.pl file, compacted in RNAplonc.zip in the download section, will be executed to remove sequences smaller than 200 nucleotides.

Open the command terminal (Ctrl + Alt+ t)

Command to execute: perl path/200nt.pl path/file.fasta

path = Path of the file

The output file will have the same name as the input file with "_" at the end, eg. dataset_.fasta

3 - CD-HIT-EST (Optional)

The CD-HIT-EST program is presented in the download section. Your installation is explained in the install section. Its execution is a little slow, due to it removes all sequences with similarity of 80%.

It will run with the file resulting from step 2.

Command to execute: cd path

./cd-hit-est -i dataset_.fasta -o result.fasta -c 0.8

-i = Name of the output file from step 2 
-o = Output file name
-c = Percentage cut used of 80% similarity

The output file will have the name you put after the -o

4 - txCdsPredict

The txCdsPredict program is presented in the download section. Your installation is explained in the install section.

The file resulting from step 3 (result.fasta) will be entered in the txCdsPredict

Command to execute: cd path/kentUtils/src/hg/txCds/txCdsPredict/

./txCdsPredict result.fasta result.cds

result.fasta = Name of the output file from step 3 - CD-HIT-EST
result.cds = Output file name
5 - feature_extraction.pl

The entry in this step 5 will be the resulting files of steps 3 will be the results files of steps 3 - CD-HIT-EST and 4 - txCdsPredict

Command to execute: perl feature_extraction.pl result.fasta result.cds >resultado.arff

result.fasta = Name ofthe output file from step 3 - CD-HIT-EST 
result.cds = Name of the output file from step 4 - txCdsPredict
The output file will have the extension .arff
6 - RNAplonc.model

The entry in this step 6 is the resulting file from step 5 - feature_extraction.pl

Command to execute: java -cp weka.jar weka.classifiers.trees.REPTree -l RNAplonc.model -T result.arff -p 0 >resultado_end.txt

The file weka.jar is in the download section in the compressed file RNAplonc.zip

7 - result

RNAplonc.model file results from step 6

>python3 FilterResults.py -c result.cds -r resultado_end.txt -o resultFinal.txt -p 0.8 -t 1

FilterResults.py = result display program 
-c = result.cds = Name of the output file from step 4 - txCdsPredict
-r = resultado_end.txt =  Name of the output file from step 6
-o = resultFinal.txt = result display
Optional parameters:
-p = 0.8 = Filter the output percentage in the terminal, float valeu between 0 and 1
-t = 1 = Filter the output type in the terminal, 1- lncRNA , 2-mRNA

Any questions please contact us.
