dayanddate(){
  LC_TIME="en_IN.UTF-8" TZ="Asia/Kolkata" date '+%A,%e - %B - %G'
}

volume() {
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    level=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1)

    if [ "$muted" = "yes" ]; then
        echo "🔇"
    else
        echo "🔊 $level"
    fi
}
wifi (){
  if [ $(nmcli general | awk '{print $1}' | tail -n 1 ) = "disconnected" ]; then
    echo " 睊 "  
  else 
    echo "   "  
  fi
}

timedate(){
  TZ="Asia/Kolkata" date '+%I:%M:%S %p'
}

while :; do 
  xsetroot -name "$(dayanddate)"";""|  $(volume)  |""  $(wifi)  |""  $(timedate)  "
  sleep 1
done

