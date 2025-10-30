#!/bin/sh

# Check if nmtui is running
if pgrep -f "st -c nmtui" > /dev/null; then
    # If running, kill it
    pkill -f "st -c nmtui"
else
    # If not running, launch it
    st -c nmtui -g 60x25+1425+25 -e nmtui-connect &
fi



# Check if nmtui is already running
# if pgrep -f "st -c nmtui" > /dev/null; then
#     # If running, kill it
#     pkill -f "st -c nmtui"
# else
#     # Launch nmtui in st
#     st -c nmtui -g 60x25+1425+25 -e nmtui &
#
#     # Save the PID of the last launched st instance
#     ST_PID=$!
#
#     # Start a timeout: kill it after 4s if still running
#     (
#         sleep 3
#         if ps -p $ST_PID > /dev/null; then
#             kill $ST_PID 2>/dev/null
#         fi
#     ) &
# fi
