#!/bin/bash

echo "Records are being converted to KBART format."

# Convert records using fixes specified in file marc2kbart.fix
# Save records as records.csv
catmandu convert MARC --type RAW to CSV --fix marc2kbart.fix --fields publication_title,\
print_identifier,online_identifier,date_first_issue_online,\
num_first_vol_online,num_first_issue_online,date_last_issue_online,\
num_last_vol_online,num_last_issue_online,title_url,platform_url,\
platform,first_author,title_id,embargo_info,coverage_depth,notes,\
publisher_name,publication_type,date_monograph_published_print,date_monograph_published_online,\
monograph_volume,monograph_edition,first_editor,parent_publication_title_id,\
preceding_publiation_title_id,access_type,preceding_title_journal_id,\
journal_id,journal_title_history,monograph_parent_collection_title,\
zdb --sep_char '\t' < $1 > $2

# Count and display record count
resultCount=$(grep "=\"001\">" $1 | wc -l)
echo "Number of records successfully processed: "${resultCount}
