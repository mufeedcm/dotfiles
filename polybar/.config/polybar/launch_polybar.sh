
#!/usr/bin/env bash

# Terminate already running bar instances
# Graceful quit for Polybar with IPC enabled
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Logging
echo "---" | tee -a /tmp/polybar.log

# Launch Polybar dynamically on all monitors
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload toph 2>&1 | tee -a /tmp/polybar.log & disown
  done
else
  polybar --reload toph 2>&1 | tee -a /tmp/polybar.log & disown
fi

echo "Polybar launched!"

