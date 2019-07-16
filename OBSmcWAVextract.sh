#!/bin/bash

shopt -s nullglob
for file in *.{mp4,avi,mov,wmv,ts,m2ts,mkv,mts}; do
    filename=$(basename -- "$file")
    echo Processing "${filename%.*}"
    ffmpeg -strict 2 -hwaccel auto -i "$file" -c:v libx265 -rc constqp -qp 24 -b:v 0K -c:a aac -map 0 "${filename%.*}_CRF24_HEVC.mp4"
    echo Processed $file
done
