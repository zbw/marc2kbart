# MARC2KBART

## Workflow to extract bibliographic records from CBS and convert to KBART

- Extract bib records from CBS (any database)
- Download, convert and and export as CSV file (KBART compliant)
- This file can be used for ingest into GOKb

## How it works
Mit diesen Skripten ist es möglich, Daten aus CBS-Datenbanken im Format MARC 21 XML herunterladen 
und in eine CSV-Datei im KBART-Format zu konvertieren.

Zwei Szenarien sind umgesetzt:

### Retrieval via SRU
The user has to set a query in the ```query``` variable in marc2kbart.sh. 
It queries the SRU interface and downloads bibliographic, holdings and item records records from ZBW's
collection. The records are then being processed and converted using Catmandu and the
conversion rules specied in 'marc2kbart.fix' fix file.
Please be aware that you have to modify the mapping rules according to the local cataloging
rules in your institution.


### Retrieval via unAPI
The script awaits record ids (PPN-ID) from the K10Plus union catalogue in a
separate file. 
It queries the unAPI interface and downloads bibliographic, holdings and item records records from ZBW's
collection. The records are then being processed and converted using Catmandu and the
conversion rules specied in 'marc2kbart.fix' fix file.
Please be aware that you have to modify the mapping rules according to the local cataloging
rules in your institution.

## Usage

+With SRU+
```
./marc2kbart.sh [query]
```

+With unAPI+
```
./marc2kbart.sh [filename]
```

## Known issues
- MARC 363 is not the appropriate element to populate coverage information. Need to wait until VZG headquarter adds Pica+ 231@ to the MARC21 export.
- Need to add mapping rules for monographic resources. Until then the fields are created with blank values.
- The record id is written into the first column 'identifier'. This is mainly for debugging purposes. Before uploading the data into Folio the column has to be removed or the mapping rule has to be deleted in the 'marc2kbart.fix' file.
