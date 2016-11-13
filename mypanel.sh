#!/bin/sh

panel_height=24
#bgcolor=$(herbstclient get frame_border_normal_color)
#selbg=$(herbstclient get window_border_active_color)
herbstclient pad ${1:-0} $panel_height

separator="    "
COLOR_BG="#111111"
COLOR_BLUE="#aabbcc"
COLOR_GRAY="#1f1f1f"
COLOR_HIGHLIGHT="#aadb0f"

{
	# generate events to trigger panel updates
	# either run every two seconds
	while true; do
		echo
		sleep 5
	done &

	# or whenever there's output from xtitle or herbstclient,
	# meaning that something has changed
	~/bin/xtitle -sf 'T%s' &
	herbstclient --idle &
	# the cool thing is that herbstclient --idle doesn't output anything
	# right on start, only when something changed. so when running this
	# script, it won't print out twice (because of the echo; sleep 2 above)
	# (baskerville xtitle breaks this of course =\ )
} 2> /dev/null | {
	while read -r line; do
		# begin left part of panel
		env printf "%%{l}"

		# generate tag names/icons
		for tag in $(herbstclient tag_status | xargs | tr ' ' '\n'); do
			case ${tag#?} in
				# change the icons to your likings
				1)	tag_name="\ue1d8 \ue17e";;
				2)	tag_name="\ue1d8 \ue17f";;
				3)	tag_name="\ue1d8 \ue180";;
				4)	tag_name="\ue1d8 \ue16d";;
				5)	tag_name="\ue1d8 \ue16e";;
				6)	tag_name="\ue1d8 \ue16f";;
				7)	tag_name="\ue1d8 \ue170";;
				8)	tag_name="\ue1d8 \ue171";;
				9)	tag_name="\ue1d8 \ue172";;
			esac
			# add some separators
			tag_name_formatted="%%{O8}$tag_name%%{O5}"
			case $tag in
				# tag is focused on current monitor
				[#]*)	env printf "%%{B$COLOR_GRAY}%%{+o}$tag_name_formatted%%{-o}%%{B-}";;
				# tag is empty
				[.]*)	env printf "%%{F$COLOR_BLUE}$tag_name_formatted%%{F-}";;
				# everything else
				*)		env printf "$tag_name_formatted"
			esac
		done

		# begin center part of panel
		env printf "%%{c}"
		# uncomment if no baskerville xtitle is available
		#if [ -n "$(echo $line | grep focus_changed)" ]; then
		#	title="$(echo $line | cut -d ' ' -f 3-)"
		#fi

		# uncomment if baskerville xtitle should be used
		case "$line" in T*) title="${line#?}";; esac

		# the "%s" is important, otherwise printf interprets % as argument
		# and you get `printf: %): invalid conversion specification` errors
		env printf "%s" "$title"

		# begin right part of panel
		env printf "%%{r}"
		# generate status output here
		env printf "%%{F$COLOR_BLUE}VOL%%{F-} $(amixer get Master | egrep -o '[0-9]+%')%"
		env printf "%%{O20}"
		env printf "%%{F$COLOR_BLUE}BAT%%{F-} $(cat /sys/class/power_supply/BAT0/capacity)%% \
											$(cat /sys/class/power_supply/BAT1/capacity)%%"
		env printf "%%{O20}"
		env printf "$(date '+%A, %d. %B %H:%M:%S') "
		env printf "\n"
	done
} | lemonbar -g "$(herbstclient monitor_rect $1 | cut -d ' ' -f 3)x$panel_height" \
		-f "-*-tamzen-medium-*-*-*-15-*-*-*-*-*-*-1" \
		-f "-*-siji-*-*-*-*-10-*-*-*-*-*-*-1" \
		-B "$COLOR_BG" \
		-U "$COLOR_HIGHLIGHT"
