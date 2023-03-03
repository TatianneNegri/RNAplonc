# RNAPlonc Docker Tutorial

Docker is a software platform that allows the creation of applications in a controlled environment. The idea for creating an RNAplonc
docker is to make the tool readly availabe, without going to the trouble of configuration and compatibility of its dependencies.

The RNAplonc image was created using Ubuntu 20.04 image, cd-hit-est and txCdsPredict tools compiled in Ubuntu 20.04, python version 3.8.2, openjdk version 1.8.0_252.

The RNAplonc tools were installed on /RNAplonc directory and contain the following files:
- 200nt.pl
- feature_extraction.pl
- seq_test
    -Citrus_sinensis_lncRNA_GREENC.fasta
- Dockerfile
- RNAplonc.model
- FilterResults.py
- txCdsPredict 
- README.txt 
- cd-hit-est 
- random_selection.pl
- weka.jar

## Steps to use RNAplonc docker image 

### 1. Installing docker

You can find how to install docker on Apple, Windows and Linux on the official documentation link below:

https://docs.docker.com/get-docker/

### 2. Downloading the docker image and installing.

```bash
docker pull lopesandrecosta/rnaplonc
```

### 3. RNAplonc usage

There are three

#### 3.1 Change directory to the path of the database using cd command.

This step is needed, because we are binding the database folder with a virtual folder called /app.

```bash
cd rnaploncepb
```

#### 3.2 - 200nt.pl (Optional)

200nt.pl is a perl script that verifies that the sequences on the fasta files have more than 200 nucleotides.

```bash
sudo docker run -it --rm -v "$(pwd):/app" --user $(id -u):$(id -g) lopesandrecosta/rnaplonc perl RNAplonc/200nt.pl app/samples.fa
```

Output: 200nt will output a fasta file with "_" at the end, eg file_fasta.

#### 3.3 - CD-HIT-EST (Optional)

CD-HIT-EST (Cluster nucleotide sequences) is an executable that removes the sequences with a given similarity X. On this work we use 80%.

```bash
sudo docker run -it --rm \
-v "$(pwd):/app" \
--user $(id -u):$(id -g) \
lopesandrecosta/rnaplonc RNAplonc/cd-hit-est -i app/samples_.fasta -o app/cd_hit_est_result.fasta -c 0.8
```

where

```
-i = Name of the output file from step 2 
-o = Output file name
-c = Percentage cut used of 80% similarity
```

#### 3.4 txCdsPredict (Mandatory)

txCdsPredict is an executable used to find Open Reading Frames in the Dataset. 
It will use the output file from 3.3. 

```bash 
sudo docker run -it --rm \
-v "$(pwd):/app" \
--user $(id -u):$(id -g) \
lopesandrecosta/rnaplonc RNAplonc/txCdsPredict app/cd_hit_est_result.fasta app/tx_cds_result.cds
```

where

```
cd_hit_est_result.fasta = Name of the output from step 3.3 (CD-HIT-EST)
tx_cds_result = Name of the output file from step 3.4 - (txCdsPredict)
```

#### 3.5 feature_extraction.pl (Mandatory)

The argument for this step is both output files from 3.3 and 3.4.

```bash
sudo docker run -it --rm \
-v "$(pwd):/app" \
--user $(id -u):$(id -g) \
lopesandrecosta/rnaplonc perl RNAplonc/feature_extraction.pl app/cd_hit_est_result.fasta app/tx_cds_result.cds > features.arff
```

The output of this step is a .arff file.

#### 3.6 RNAplonc.model execution on weka (Mandatory)

The argument needed for the weka execition is the resulting file from 3.5

```bash
sudo docker run -it --rm \
-v "$(pwd):/app" \
--user $(id -u):$(id -g) \
lopesandrecosta/rnaplonc java -cp RNAplonc/weka.jar weka.classifiers.trees.REPTree \
-l RNAplonc/RNAplonc.model -T app/features.arff -p 0 > classification_result.txt
```

The output is classification_result.txt

#### 3.7 Python Script to put back the sequence names back into the final result (Optional)

This step will use the classification_result.txt from the step 3.4 and 3.6.

```bash
sudo docker run -it --rm \
-v "$(pwd):/app" \
--user $(id -u):$(id -g) \
lopesandrecosta/rnaplonc python3 RNAplonc/FilterResults.py -c app/tx_cds_result.cds -r app/classification_result.txt -o app/final_result.txt
```

## Tips

Run shell

```bash
docker run -it --rm -v "$(pwd):/app" lopesandrecosta/rnaplonc bash
```

Any questions please contact us.
