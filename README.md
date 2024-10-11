# JournalMastheads
Version control for masthead json files.  
Scheduled to run at 9am ET on the 1st and 15 of each month.  

## Requirements
journal-list.txt is required and lists each file that needs to be downloaded on a separate line.  
Make sure to update it with each new journal.  
get-mastheads.sh will check if each journal json file exists in iapps before downloading to prevent downloading empty files.  
