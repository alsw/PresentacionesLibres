#!/usr/bin/python

import urllib2, json, datetime

access_token = '900538806624473|34ceIHcz6e6GNlmT-rLBnvdO1Rw'
FotoID = '938821429506340'

data = urllib2.urlopen('https://graph.facebook.com/' + FotoID + '?fields=comments.limit(1000)&access_token='+access_token).read()
DatosFB = json.loads(data)

Color = "Banco"
Fecha =  datetime.datetime.strptime("2014-12-09T04:46:09+0000",'%Y-%m-%dT%H:%M:%S+0000') 
Nombre = "Nadie"

ColorActual = DatosFB['comments']['data'][0]['message']
FechaActual = datetime.datetime.strptime(DatosFB['comments']['data'][0]['created_time'],'%Y-%m-%dT%H:%M:%S+0000') 
NombreActual = DatosFB['comments']['data'][0]['from']['name']

for DatoActual in DatosFB['comments']['data']:
   FechaActual = datetime.datetime.strptime(DatoActual['created_time'],'%Y-%m-%dT%H:%M:%S+0000')
   if FechaActual > Fecha:
        Fecha = FechaActual
        Color = DatoActual['message']
        Nombre = DatoActual['from']['name']

print  Color
print "@"+ Nombre
