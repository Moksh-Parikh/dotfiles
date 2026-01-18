while true; do
    if [[ $(playerctl -a status) == *"Playing"* ]]; then
        # Read stdout from cava and perform substitution in a single sed command
    else
        pkill -x cava.sh
        echo
    fi
done
