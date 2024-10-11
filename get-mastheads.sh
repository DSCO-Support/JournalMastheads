#!/usr/bin/env bash

# file download list location
journallist="../journal-list.txt"

# create local download directory
mkdir mastheads
cd mastheads

# download current journal json
download_file() {
    echo "Downloading $line" 
    http_code=$(curl -w '%{http_code}\n' --connect-timeout 5 --max-time 10 --retry 5 --retry-delay 0  --retry-max-time 40 -o $line $currentjournal)
    exit_status="$?"
    echo "Exit code: $exit_status"
}

# check contents of file
check_file() {
    if grep -q '<HTML>' "$line"; then
        echo $line 'contains <HTML>, try again'
    else
        fileDownloaded=true
        echo "File contents OK"
    fi
}

# loop through journal-list.txt file
while IFS= read -r line || [ -n "$line" ]; do
    # current json file url
    echo ' '
    echo "Current file: $line"
    currentjournal=$masthead_url"$line"
    echo $currentjournal
    echo ' '

    # check status of journal json file in iapps
    status_code=$(curl -L --write-out %{http_code} --silent --output /dev/null $currentjournal)
    echo "Status code: $status_code"

    #journal not found
    if [[ "$status_code" -eq 404 ]] ; then
        echo "Not available"
    
    #journal is available, download file
    elif [[ "$status_code" -eq 200 ]] ; then
        fileDownloaded=false
        download_file

        echo "Checking file contents"

        while [ "$fileDownloaded" = false ]; do
            check_file
        done

    fi

    echo ' '
    echo "============================================"

done < $journallist
