#!/bin/sh

logfile="/tmp/solution.log"

if [ ! -f ${logfile} ]
then
    touch ${logfile}
fi

inotifywait -m /source -e create |
    while read path action file; do
        echo "The file '$file' appeared in directory '$path' via '$action'" >> $logfile
        curl -i "https://server/focus/api?method=analyse&apikey=key&target=/source/$file" > /target/$file.json
        
        if [ $? -eq 0 ]; then
            echo "API Processing done on '$file'" >> $logfile
        else
            echo "API Processing failed on '$file'" >> $logfile

        fi
    done

