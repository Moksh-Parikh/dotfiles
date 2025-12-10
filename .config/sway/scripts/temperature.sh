#!/bin/bash

# Get CPU temperature (may need to adjust the label)
# Use `sensors` to find the correct label, e.g., "Tctl", "Core 0", etc.
TEMP=$(sensors | grep 'Tctl' | awk '{print $2}' | cut -d'+' -f2 | cut -d'.' -f1)

# Set the threshold
THRESHOLD=80

# Check if temperature is above the threshold
if [ "$TEMP" -ge "$THRESHOLD" ]; then
  notify-send "CPU Temperature Alert" "CPU temperature is $TEMP°C, which is above the $THRESHOLD°C threshold."
  # Optional: Add another action here, like sending an email
  # mail -s "CPU Temp Alert on $(hostname)" your.email@example.com <<< "CPU temperature is $TEMP°C"
fi
