# JournalMastheads
Version control for masthead json files.  
Scheduled to run at 12pm ET on the 1st and 15 of each month.  

## Requirements
journal-list.txt is required and lists each file that needs to be downloaded on a separate line.  
For new journals, when JCI is ready to output JSON for it, make sure the new journals have been added to journal-list.txt. This can be done at any time.

get-mastheads.sh will check if each journal json file exists in iapps before downloading to prevent downloading empty files.  
