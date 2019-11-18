# RNAplonc V1.0

A tool for identification of plant long non-coding RNAs.

Long non-coding RNAs (lncRNAs) correspond to an eukaryotic non-coding RNA class that has gained emerging attention in the last years as a higher layer of regulation for gene expression in cells. There is, however, a lack of specific computational approaches to reliably predict lncRNA in plants, which contrast with the variety of prediction tools available for mammalian lncRNAs. This distinction is not obvious, given that the biological features and mechanisms generating lncRNAs in the cell are likely different between animals and plants.

Here, we present RNAplonc, a classifier approach for the identification of lncRNAs in plants from mRNA-based data. This tool was created and trained with lncRNA and mRNA data from five plant species (thale cress, cucumber, soybean, western balsam-poplar and Asian rice), and it uses only 16 features robustly selected from more than 5,000 features with the REPTree algorithm.

After an extensive comparison with other largely used tool in plants, we found that RNAplonc obtained a better accuracy (92%) with the training dataset when compared to the 77% of accuracy obtained with the CPC tool. We also found that RNAplonc produced more reliable lncRNA predictions from plant transcripts, as estimated for 17 datasets of 13 different species of CANTATAdb, GreeNC and PNRD databases.

# AUTHOR/SUPPORT

Tatianne da Costa Negri - tatinegri@gmail.com;</br>
Priscila Tiemi Maeda Saito - priscilasaito@gmail.com;</br>
Pedro Henrique Bugatti - pbugatti@utfpr.edu.br;</br>
Douglas Silva Domingues - dougsd3@gmail.com;</br>
Wonder Alexandre Luz Alves - wonder@uninove.br;</br>
* Alexandre Rossi Paschoal - paschoal@utfpr.edu.br;</br>
* Corresponding author. If you need any information contact paschoal@utfpr.edu.br

# INSTALL
Before to start, it is necessary to install txCdsPredict and CD-HIT-EST software.</br>
txCdsPredict : https://github.com/ENCODE-DCC/kentUtils</br>
CD-HIT-EST: https://github.com/weizhongli/cdhit/releases
 

All to install: https://github.com/TatianneNegri/RNAplonc/blob/master/Install.md

# MANUAL
Manual : https://github.com/TatianneNegri/RNAplonc/blob/master/manual.pdf

# DOWNLOAD

RNAplonc: pre-compiled executables for Linux, scripts required, RNAplonc.model, folder with test sequence (https://github.com/TatianneNegri/RNAplonc/tree/master/RNAplonc).</br>
manual.pdf: documentation  (https://github.com/TatianneNegri/RNAplonc/blob/master/manual.pdf)</br>
Datasets used: All datasets used (https://github.com/TatianneNegri/RNAplonc/tree/master/Datasets%20used).</br>

# HARDWARE/SOFTWARE REQUIREMENTS
Project name: RNAplonc</br>
Operating system(s): Linux/Unix or similar</br>
Programming language: PERL</br>
Other requirements (software): txCDSpredict, CD-HIT-EST, Java</br>
License: GNU GPL</br>
Any restrictions to use by non-academics: request permission is needed. </br>
General information: All dataset used, tutorial and software are in the website

# LIMITATIONS

This release was tested with the default parameters for plants. Please contact the author for a list of recommended parameters for much larger or much smaller genomes.

# UPDATE 2019

star Note: Updated test dataset, and added result display script.

# PUBLICATION
Negri T. D. C., W. A. L. Alves, P. H. Bugatti, P. T. M. Saito, D. S. Domingues, and A. R. Paschoal. ”Pattern recognition analysis on long noncoding RNAs: a tool for prediction in plants.” Brief. Bioinformatics, Abr 2018.
Doi: https://doi.org/10.1093/bib/bby034
