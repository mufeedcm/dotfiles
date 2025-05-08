#!/bin/sh

# Check if ncmpcpp is running
# if pgrep -f "st -c ncmpcpp" > /dev/null; then
#     # If running, kill it
#     pkill -f "st -c ncmpcpp"
# else
#     # If not running, launch it
#     st -c ncmpcpp -g 60x25+1425+25 -e ncmpcpp &
# fi



# Check if ncmpcpp is already running
if pgrep -f "st -c ncmpcpp" > /dev/null; then
    # If running, kill it
    pkill -f "st -c ncmpcpp"
else
    # Launch ncmpcpp in st
    st -c ncmpcpp -g 60x25+1425+25 -e ncmpcpp &

    # Save the PID of the last launched st instance
    ST_PID=$!

    # Start a timeout: kill it after 4s if still running
    (
        sleep 3
        if ps -p $ST_PID > /dev/null; then
            kill $ST_PID 2>/dev/null
        fi
    ) &
fi
