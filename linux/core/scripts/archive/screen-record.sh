#!/usr/bin/env bash

record() {
  ffmpeg \
    -video_size 1920x1080 \
    -framerate 30 \
    -f x11grab -i :0.0 \
    -f pulse -i default \
    -c:v h264 -qp 0 \
    -c:a aac \
    "$HOME/Videos/video_$(date '+%a__%b%d__%H_%M_%S').mkv" &

  echo $! > /tmp/recpid

  notify-send -t 500 \
    -h string:bgcolor:#2e3440 \
    "Screen recording started"
}

end() {
  kill -15 "$(cat /tmp/recpid)" && rm -f /tmp/recpid

  notify-send -t 500 \
    -h string:bgcolor:#3b4252 \
    "Screen recording stopped"
}

([[ -f /tmp/recpid ]] && end && exit 0) || record
