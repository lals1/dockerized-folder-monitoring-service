#!/bin/sh

LOG_file = /tmp/inotify.log

inotifywait -m /source -e create |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'" >> $LOG_file
        curl -i "https://server/api?method=analyse&apikey=key&format=json&target=/source/$file" > /target/$file.json
    done
