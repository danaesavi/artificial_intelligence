
# coding: utf-8

# # Decission Tree

# In[23]:

import csv
import pandas as pd
import numpy as np
import math


# ## Variables Globales

# In[24]:

dia = csv.excel()
df = pd.read_csv("breast-cancer.txt") 
clase=[x[0] for x in df[['class']].values.tolist()]
nombresAtt=('age','menopause','tumor-size','inv-nodes','deg-mailig','breast','breast-quad','irradiat')
atributos=[df[[nombre]] for nombre in nombresAtt]
atributosL=[]
[atributosL.append([x[0] for x in a.values.tolist()]) for a in atributos]
tot=float(len(np.asarray(atributos[0])))
arbol=[]
flag='true'


# In[26]:

classesN = {
    'class': ['no-recurrence-events','recurrence-events'],
    'age': ['20-29','30-39','40-49','50-59','60-69','70-79'],
    'menopause':['It-40','ge40','premeno'],
    'tumor-size':['0-4','15-19','20-24','25-29','30-34','35-39','40-44','45-49','50-54','10-14','5-9','05-19'],
    'inv-nodes': ['0-2','12-14','15-17','24-26','3-5','6-8','9-11'],
    ' node-caps': ['yes', 'no'],
    'deg-mailig':[1,2,3],
    'breast': ['left','right'],
    'breast-quad':['?','central','left_low','left_up','right_low','right_up'],
    'irradiat':['yes','no']
    }   
sn=classesN['class'][0]
ss=classesN['class'][1]


# ##  Funciones Auxiliares

# In[91]:

#cuenta cuántos de cada atributo 
col=[x[0] for x in atributos[0].values.tolist()]
def cuantosPorclase (col):
    return dict([(x, col.count(x)) for x in col])
#cpcA=cuantosPorclase(atributosL[0])


# In[92]:

def cuantosDadoClase(col1,col2):
    l=zip(col1,col2)
    k = [(x, l.count(x)) for x in l]
    return dict(k)
#cdcA=cuantosDadoClase(atributosL[0],clase)


# In[93]:

# entropia
def entropia (cpc,cdc,clases):
    e=0
    for s in cpc:
        sn=(s,clases[0])
        ss=(s,clases[1])
        td=float(cpc[s])
        #print cdc
        if(ss in cdc.keys() and sn in cdc.keys()):
            e=e+cpc[s]/tot*(-1)*(cdc[ss]/td*math.log(float(cdc[ss])/td,2)+cdc[sn]/td*math.log(float(cdc[sn])/td,2))
            #print 'calculando entropia'
        
    return e
#entropia(cpcA,cdcA,[sn,ss])


# In[94]:

#menor entropia
from operator import itemgetter
def minEntropia (attributes,names,target,classes):
    ent=[]
    i=0
    if(attributes):
        for at in attributes:
            cpcAt=cuantosPorclase(at)
            cdcAt=cuantosDadoClase(at,target)
            ent.append([entropia(cpcAt,cdcAt,classes),names[i]])
            i=i+1
    res=min(ent,key=itemgetter(0))[0],min(ent,key=itemgetter(0))[1],[x[0] for x in df[[min(ent,key=itemgetter(0))[1]]].values.tolist()]
    return res
#[minH,nomMinH,listMinH]=minEntropia(atributosL,nombresAtt,clase,[sn,ss])


# In[95]:

#tabla sin el ganador
def nuevaTabla (nombreAtributo,nombresAtts):
    atributosN,nombres=[],[]
    for n in nombresAtts:
        if(n != nombreAtributo):
             atributosN.append([x[0] for x in df[[n]].values.tolist()])
             nombres.append(n)
                
    atributosN.append(clase)
    return [np.array(atributosN), nombres]

#[atts,noms]=nuevaTabla(me[1],nombresAtt)


# In[96]:

#tabla dado un atributo del ganador
#att=classes[nomMinH][0]
def tablaDadoHijo(hijo,attsSinMinH):
    tabla=[]
    for x in range(len(listMinH)):
        if(listMinH[x]==hijo):
            tabla.append([attsSinMinH[k][x] for k in range(len(attsSinMinH))])
    
    clase=[tabla[k][len(attsSinMinH)-1] for k in range(len(tabla))]
    tabla=[[tabla[k][x] for k in range(len(tabla))] for x in range(len(attsSinMinH)-1)]
    
    return [tabla,clase]

#[tablaDadoAtt,claseDadoAtt]=tablaDadoHijo(att,atts)


# ##  Función Principal 

# In[98]:

nivel=0
arbol=[]
papa=''
file = open("Reglas.txt", "w")
def ID3(attributes,names,target,classes,level,papa):
    
    [minH,nomMinH,listMinH]=minEntropia(attributes,names,target,[classes[0],classes[1]])
    arbol.append([papa,level,nomMinH])
    papa=nomMinH
    level=level+1
    [atts,noms]=nuevaTabla(nomMinH,names)
    k=cuantosDadoClase(listMinH,target)
  
    for h in classesN[papa]:
        print ''+ ' '*level*4+'Si %s es %s' %(papa,h)
        file.write(''+ ' '*level*4+'Si %s es %s \n' %(papa,h))
        if((h,sn) in k.keys() and (h,ss) in k.keys()):
            [tablaDadoAtt,claseDadoAtt]=tablaDadoHijo(h,atts)
            ID3(tablaDadoAtt,noms,claseDadoAtt,[sn,ss],level,papa)
        else:
            if((h,sn) in k.keys()):
                arbol.append([sn,level,papa])
                print ''+ ' '*(level+1)*7+'entonces %s' %sn
                file.write(''+ ' '*(level+1)*7+'entonces %s \n' %sn)
               
            else:
                arbol.append([ss,level,papa])
                print ''+ ' '*(level+1)*7+'entonces %s ' %ss
                file.write(''+ ' '*(level+1)*7+'entonces %s \n' %sn)
    return arbol

arb=ID3(atributosL,nombresAtt,clase,[sn,ss],nivel,papa)
file.close()


# In[ ]:



