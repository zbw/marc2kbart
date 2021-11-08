#!/bin/bash

# MARC2KBART.SH -- Download and transform records from MARC21XML to KBART format
#
# Author: Felix Hemme
# Version: v1, 2012-03-18
# License: MIT License
#
# Usage
# ./marc2kbart.sh [filename]
#
# How it works:
# This script awaits record ids (MARC 21 field 001) from the K10Plus union catalogue in a
# separate file.
# It queries the unAPI interface and downloads bib records and holdings records from ZBW's
# collection. The records are then being processed and converted using Catmandu and the
# conversion rules specied in 'marc2kbart.fix' fix file.
# Please be aware that you have to modify the mapping rules according to the local cataloging
# rules in your institution.
#
# Known issues:
# - MARC 363 is not the appropriate element to populate coverage information. Need to wait until
#   VZG headquarter adds Pica+ 231@ to the MARC21 export.
# - Need to add mapping rules for monographic resources. Until then the fields are created with
#   blank values.
# - The record id is written into the first column 'identifier'. This is mainly for debugging
#   purposes. Before uploading the data into Folio the column has to be removed or the mapping
#   rule has to be deleted in the 'marc2kbart.fix' file.

url="https://sru.k10plus.de/"
database="ebooks"
recordSchema="marcxml"
maximumRecords="5"
query="pica.xpr=$1"
version="version=1.1"
parser="marcxml"
type="XML"

# Check if arguments are provided
if [[ $# -eq 0 ]] ; then
    echo "No arguments supplied!"
    exit 1
fi

echo "Please wait. Records are being downloaded and converted."

# Download records
# Convert records using fixes specified in file marc2kbart.fix
# Save records as records.csv

catmandu convert SRU --base ${url}${database} --query ${query} --recordSchema ${recordSchema} --parser ${parser} to CSV \
--fix marc2kbart.fix --fields identifier.ppn,publication_title,\
print_identifier,online_identifier,date_first_issue_online,\
num_first_vol_online,num_first_issue_online,date_last_issue_online,\
num_last_vol_online,num_last_issue_online,title_url,platform_url,\
platform,first_author,title_id,embargo_info,coverage_depth,notes,\
publisher_name,publication_type,date_monograph_published_print,date_monograph_published_online,\
monograph_volume,monograph_edition,first_editor,parent_publication_title_id,\
preceding_publiation_title_id,access_type,preceding_title_journal_id,\
journal_id,journal_title_history,monograph_parent_collection_title,\
zdb --sep_char '\t' > records.csv

# Count and display record count
resultCount=$(wc -l records.csv | awk '{print $1-1}')
echo "Number of records successfully processed: "${resultCount}
