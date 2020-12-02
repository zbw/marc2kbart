#!/bin/bash

url="http://sru.gbv.de/opac-de-206!levels=0?version=1.1&operation=searchRetrieve"
index="pica.sgn"
query="zbw-6-sab"
format="marcxml"
startRecord=1
counter=1000
mkdir -p data

while [ "$counter" -le 1000 ] ; do
    echo ${url}
    curl "${url}&query=${index}%3D${query}&maximumRecords=1000&recordSchema=${format}&startRecord=${startRecord}" > data/${startRecord}-${counter}.xml
    let counter=counter+1000
    let startRecord=startRecord+1000
done
exit
catmandu convert MARC --type XML to MARC --type RAW < data/1-1000.xml