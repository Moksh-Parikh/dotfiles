#!/bin/bash

# Not my own work. Credit to original author

#----- Optimized bars animation without much CPU usage increase --------
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"

# Calculate the length of the bar outside the loop
bar_length=${#bar}

# Create dictionary to replace char with bar
for ((i = 0; i < bar_length; i++)); do
    dict+=";s/$i/${bar:$i:1}/g"
done

# Create cava config
config_file="/tmp/bar_cava_config"
cat >"$config_file" <<EOF
[general]
# Older systems show significant CPU use with default framerate
# Setting maximum framerate to 30  
# You can increase the value if you wish
framerate = 45
bars = 14

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# status=$(playerctl -a status -i firefox,chromium 2>/dev/null)
increment=99
status=1
info=$(playerctl metadata -i chromium,firefox --format '{{title}} by {{artist}}' 2>/dev/null)

detectPlayerStatus() {
    while IFS='$\n' read -r line; do
        ((increment++))
        # status=$(playerctl -a status -i firefox,chromium 2>/dev/null)
        # if [[ $status == "No players found" ]]; then
        #     echo
        #     sleep 1
        # fi
        
        if [[ $status != 0 ]]; then
            echo ""
            sleep 1
            pgrep 'spotify|kew' > /dev/null
            status=$?
        else
            echo "$line $info"
            if [[ $increment -ge 100 ]]; then
                pgrep 'spotify|kew' > /dev/null
                status=$?
                info=$(playerctl metadata -i chromium,firefox --format '{{title}} by {{artist}}' 2>/dev/null)
                increment=0
            fi
        fi
    done
}

# Kill cava if it's already running
pkill -f "cava -p $config_file"

cava -p "$config_file" | sed -u "$dict" | detectPlayerStatus
