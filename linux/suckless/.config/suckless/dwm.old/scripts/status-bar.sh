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
  if [ "$(nmcli general | awk '{print $1}' | tail -n 1)" = "disconnected" ]; then
    echo " No Wi-Fi "
  else 
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    echo "   $ssid"
  fi
}

cpu_usage(){
  usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
  echo " $usage"
}

ram_usage(){
  total=$(free -m | awk '/^Mem:/ {print $2}')
  used=$(free -m | awk '/^Mem:/ {print $3}')
  percent=$((used * 100 / total))
  echo " ${percent}%"
}

timedate(){
  TZ="Asia/Kolkata" date '+%I:%M:%S %p'
}

while :; do 
  # xsetroot -name "$(dayanddate)"";""|  $(cpu_usage)  |""  $(ram_usage)  |""  $(volume)  |""  $(wifi)  |""  $(timedate)  "
  xsetroot -name "$(dayanddate)"";""|  $(volume)  |""  $(wifi)  |""  $(timedate)  "
  sleep 1
done
