#!/bin/bash

while IFS='$\n' read -r line; do
    VALUE_CHANGE=$(echo $line | cut -d ":" -f 1)
    DIRECTION_CHANGE=$(echo $line | cut -d ":" -f 2)

    if [ "$VALUE_CHANGE" = 'Accelerometer orientation changed' ]; then
        if [ $DIRECTION_CHANGE == bottom-up ]; then
            swaymsg -- output - transform 180
        elif [ $DIRECTION_CHANGE == right-up ]; then
            swaymsg -- output - transform 90
        elif [ $DIRECTION_CHANGE == left-up ]; then
            swaymsg -- output - transform 270
        elif [ $DIRECTION_CHANGE == normal ]; then
            swaymsg -- output - transform 0
        fi
    fi
done < <(stdbuf -oL monitor-sensor --accel)
