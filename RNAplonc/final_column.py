import pandas as pd
import sys

par1 = sys.argv[1] #txCdsPredict output
par2 = sys.argv[2] #RNAplonc.model output
par3 = sys.argv[3] #new output
tipo = sys.argv[4] #tipo da sequencia 1-longo 2-mRNA
porcent = sys.argv[5] #porcentagem limite 0.x

pd.options.display.max_rows=90000

arq1 = pd.read_csv(par1,sep='\t')
arq1.columns = ["Seq", "Start", "End", "txCdsPredict", ".", "6","7","8","9","10","11"]

arq2 = pd.read_fwf(par2,skiprows=range(4))

arq3 = open(par3,"w")

col1 = pd.DataFrame(arq2.loc[0:,['predicted','prediction']])
col2 = pd.DataFrame(arq1.loc[0:, 'Seq':'End'])

df = col2.join(col1)
final = str(col2.join(col1))

arq3.seek(0)
arq3.write(final)


longo = df.predicted.str.contains(tipo,na=False)
porc = df.prediction >= float(porcent)

print(df[(longo & porc)])


arq3.close()

