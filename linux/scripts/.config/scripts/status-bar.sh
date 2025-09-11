volume() {
    muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
    level=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n 1)

    if [ "$muted" = "yes" ]; then
        echo "Muted 🔇"
    else
        echo "  $level"
    fi
}

wifi (){
  if [ "$(nmcli general | awk '{print $1}' | tail -n 1)" = "disconnected" ]; then
    echo " No Wi-Fi "
  else 
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    echo "  $ssid"
  fi
}

# cpu_usage(){
#   usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
#   echo " $usage"
# }

# ram_usage(){
#   total=$(free -m | awk '/^Mem:/ {print $2}')
#   used=$(free -m | awk '/^Mem:/ {print $3}')
#   percent=$((used * 100 / total))
#   echo " ${percent}%"
# }

# dayanddate(){
#   LC_TIME="en_IN.UTF-8" TZ="Asia/Kolkata" date '+%A,%e - %B - %G'
# }

dayanddate(){
  LC_TIME="en_IN.UTF-8" TZ="Asia/Kolkata" date '+%A    %d/%m/%Y'
}

timedate(){
  TZ="Asia/Kolkata" date '+%I:%M:%S %p'
}
datetime(){
  TZ="Asia/Kolkata" date '+%a %b %d %I:%M %p'
}

task() {
  # if timew missing
  if ! command -v timew >/dev/null 2>&1; then
    echo " timew?"
    return
  fi

  # returns '1' if active, otherwise '0' (timew get dom.active 1)
  active=$(timew get dom.active 1 2>/dev/null || echo 0)
  if [[ "$active" != "1" ]]; then
    echo " Idle"
    return
  fi

  # Prefer jq parsing if available (robust), otherwise fallback
  if command -v jq >/dev/null 2>&1; then
    tag=$(timew get dom.active.json 2>/dev/null | jq -r '.tags[0] // empty')
  else
    tag=$(timew get dom.active.tags 2>/dev/null | tr '\n' ' ' | awk '{print $1}')
  fi
  [ -z "$tag" ] && tag="?"

  # compute elapsed from start timestamp (robust vs ISO-duration parsing)
  start=$(timew get dom.active.start 2>/dev/null || true)
  elapsed_fmt=""
  if [[ -n "$start" ]]; then
    # date -d handles ISO-8601 timestamps like "2025-09-09T12:34:56"
    start_epoch=$(date -d "$start" +%s 2>/dev/null || echo 0)
    if [[ "$start_epoch" -ne 0 ]]; then
      now_epoch=$(date +%s)
      elapsed=$(( now_epoch - start_epoch ))
      h=$(( elapsed / 3600 ))
      m=$(( (elapsed % 3600) / 60 ))
      if [[ "$h" -gt 0 ]]; then
        elapsed_fmt=$(printf "%d:%02d" "$h" "$m")
      else
        elapsed_fmt=$(printf "%dm" "$m")
      fi
    fi
  fi

  printf " %s %s" "$tag" "${elapsed_fmt}"
}

while :; do 
  # xsetroot -name "$(dayanddate)"";""|  $(cpu_usage)  |""  $(ram_usage)  |""  $(volume)  |""  $(wifi)  |""  $(timedate)  "
  # xsetroot -name "  $(dayanddate)  ""|  $(volume)  |""  $(wifi)  |""  $(timedate)  "
  # xsetroot -name "|  $(volume)  ""|  $(wifi)  ""|  $(dayanddate)  ""|  $(timedate)  "
  xsetroot -name "|  $(task)  ""|  $(volume)  ""|  $(wifi)  ""|  $(datetime)  "
  sleep 1
done
