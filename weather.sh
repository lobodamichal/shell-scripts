#!/bin/bash

LOGFILE="wroc_log.csv"

URL="https://wttr.in/Wroclaw?format=j1"
DATAFILE="weather_wroc.json"

if [ ! -f "$LOGFILE" ] ;
then
    echo "No log file found, creating one"
    echo "year,month,day,obs_tmp,fc_tmp" >> "$LOGFILE"
fi

curl -s "$URL" -o "$DATAFILE"

current_date=$(date "+%Y,%-m,%-d,")
temps=$( { grep 'temp_C' "$DATAFILE" && grep 'tempC' "$DATAFILE" | sed -n '6p'; } | grep -o '[0-9]\+' | paste -sd ',' )

log_entry="${current_date}${temps}"
echo "${log_entry}" >> "$LOGFILE"