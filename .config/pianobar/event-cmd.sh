#!/bin/bash

# create variables
while read L; do
	k="`echo "$L" | cut -d '=' -f 1`"
	v="`echo "$L" | cut -d '=' -f 2`"
	export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|stationName\|songStationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\|stationCount\|station[0-9]*\)=' /dev/stdin)

case "$1" in
	songstart)
		growlnotify -m "Now playing: '$title' by '$artist'" -t "Pandora"
		;;
	*)
		if [ "$pRet" -ne 1 ]; then
			growlnotify -m "Pianobar error: $1 failed, '$pRetStr'" -t "Pandora"
		elif [ "$wRet" -ne 1 ]; then
			growlnotify -m "Pianobar error: $1 failed, network error: '$wRetStr'" -t "Pandora"
		fi
		;;
esac

