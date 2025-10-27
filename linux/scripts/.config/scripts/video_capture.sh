#!/bin/bash
if pgrep -x ffmpeg > /dev/null; then
    pkill -INT ffmpeg
    notify-send "Screen recording stopped."
else
    geometry=$(slop -f "%wx%h+%x,%y")
    outfile=~/Videos/record_$(date +%s)
    ffmpeg -f x11grab -framerate 30 -s ${geometry%%+*} -i :0.0+${geometry#*+} \
      -c:v libx264 -preset ultrafast ${outfile}.mkv && \
    ffmpeg -i ${outfile}.mkv -c copy ${outfile}.mp4 && rm ${outfile}.mkv &
    notify-send "Screen recording started."
fi
