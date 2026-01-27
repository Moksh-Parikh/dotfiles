#! /usr/bin/zsh

STATE=0

function handle_toggle()
{
    if [[ $STATE == 0 ]]; then
        kill -SIGUSR2 $(pgrep wvkbd-mobintl) && echo {\"class\":\"activated\"}
        STATE=1
    else
        kill -SIGUSR1 $(pgrep wvkbd-mobintl) && echo {\"class\":\"deactivated\"}
        STATE=0
    fi
}
echo {\"class\":\"deactivated\"}
trap handle_toggle SIGUSR1

while true; do
    sleep infinity &
    wait $!
done
# read -r -d '' _
