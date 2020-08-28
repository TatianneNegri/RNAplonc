#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 26 15:35:17 2020

@author: gregorio
"""

import pandas as pd
import argparse
import numpy as np

pd.options.display.max_rows=900000

ap = argparse.ArgumentParser()
ap.add_argument("-c", "--cdsFile", required=True, help= "Path of the cds file, or the txCdsPredict output")
ap.add_argument("-r", "--resultFile", required=True, help= "Path of the result file, or the RNAplonc.model output")
ap.add_argument("-o", "--outputFile", required=True, help= "Path of the output file")
ap.add_argument("-t", "--type", required=False, help= "Filter the output type in the terminal, 1- lncRNA , 2-mRNA")
ap.add_argument("-p", "--percent", required=False, help= "Filter the output percentage in the terminal, float valeu between 0 and 1")
args = vars(ap.parse_args())

arq1 = pd.read_csv(args["cdsFile"], sep='\t' , header =None)
arq1.columns = ["Seq", "Start", "End", "txCdsPredict", ".", "6","7","8","9","10","11"]
arq2 = pd.read_fwf(args["resultFile"], skiprows=range(4))
arq3 = open(args["outputFile"],"w")


col1 = pd.DataFrame(arq2.loc[0:,['predicted', 'prediction']])
col2 = pd.DataFrame(arq1.loc[0:, 'Seq'])


df = col2.join(col1)


if args["type"]!=None and args["percent"]!=None:
    if(int(args["type"]) ==1 or int(args["type"])==2):
        longo = df.predicted.str.contains(args["type"], na=False)
        if float(args["percent"]) >=0 and float(args["percent"]) <=1:
            porc = df.prediction >= float(args["percent"])
            dataF = df[longo &porc]
            arq3.seek(0)
            final = dataF.to_string(index=False)
            arq3.write(final)
        else:
            print("Percentage value incorrect, use a value between 0 and 1 ")
    else:
        print("Type value incorrect, use 1 for lncRNA or 2 for mRNA ")

elif args["type"]!=None and args["percent"]==None:
    if(int(args["type"]) ==1 or int(args["type"])==2):
        longo = df.predicted.str.contains(args["type"], na=False)
        dataF = df[longo]
        arq3.seek(0)
        final = dataF.to_string(index=False)
        arq3.write(final)
    else:
        print("Type value incorrect, use 1 for lncRNA or 2 for mRNA ")

elif args["type"]==None and args["percent"]!=None:
    if float(args["percent"]) >=0 and float(args["percent"])<=1:
        porc = df.prediction >= float(args["percent"])
        dataF = df[porc]
        arq3.seek(0)
        final = dataF.to_string(index=False)
        arq3.write(final)
    else:
        print("Percentage value incorrect, use a value between 0 and 1 ")
else:
    arq3.seek(0)
    final = df.to_string(index=False)
    arq3.write(final)
