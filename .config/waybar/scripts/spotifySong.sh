#!/bin/zsh

# Get the current playing song from Spotify using dbus
SPOTIFY_STATUS=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
  /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
  string:"org.mpris.MediaPlayer2.Player" string:"Metadata")

# Extract artist and title from the D-Bus reply
ARTIST=$(echo "$SPOTIFY_STATUS" | grep -A 2 "xesam:artist" | tail -1 | cut -d '"' -f 2 | sed -e "s/&/&amp;/g")
TITLE=$(echo "$SPOTIFY_STATUS" | grep -A 1 "xesam:title" | tail -1 | cut -d '"' -f 2 | sed -e "s/&/&amp;/g")
URL=$(echo "$SPOTIFY_STATUS" | grep -A 1 "xesam:url" | tail -1 | cut -d '"' -f 2)

# Check if a song is playing and display the information
#
# echo $SPOTIFY_STATUS

if [[ -n "$TITLE" ]]; then
  echo "{\"text\": \"$TITLE by $ARTIST\", \"tooltip\": \"$URL\"}"
else
  echo
fi
