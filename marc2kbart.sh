#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'No arguments supplied!'
    exit 1
fi

echo "Please wait... Records are being downloaded."
cat $1 | xargs -n 1 -i curl -sS "http://unapi.k10plus.de/?id=opac-de-206:ppn:{}&format=marcxml" > records.xml
echo "Records are being converted to KBART format."

catmandu convert MARC --type XML to CSV --fix marc2kbart.fix --fields identifier.ppn,publication_title,\
print_identifier,online_identifier,date_first_issue_online,\
num_first_vol_online,num_first_issue_online,date_last_issue_online,\
num_last_vol_online,num_last_issue_online,title_url,platform_url,\
platform,first_author,title_id,embargo_info,coverage_depth,notes,\
publisher_name,publication_type,date_monograph_published_print,date_monograph_published_online,\
monograph_volume,monograph_edition,first_editor,parent_publication_title_id,\
preceding_publiation_title_id,access_type,preceding_title_journal_id,\
journal_id,journal_title_history,monograph_parent_collection_title,\
zdb --sep_char '\t' < records.xml > records.csv

resultCount=$(grep "<controlfield tag=\"001\">" records.xml | wc -l)
echo "Number of records successfully processed: "${resultCount}
