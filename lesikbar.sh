#!/bin/sh
# pls don't use bash with this script :(
# I put a lot of effort in making it POSIX compliant
# to improve speed and compatibility

panel_height=18

# TODO currently only pads one mon, should do all
herbstclient pad 0 $panel_height

alias hc="herbstclient"
alias p="env printf '%s'"

active_color="$(hc attr theme.active.color)"
normal_color="$(hc attr theme.normal.color)"
urgent_color="$(hc attr theme.urgent.color)"

COLOR_BG="#111111"
COLOR_BLUE="#aabbcc"
COLOR_GRAY="#1f1f1f"
COLOR_HIGHLIGHT="#aadb0f"

tags="$(hc tag_status | sed 's/\t[.:+#-%!]/\t/g')"
tagc="$(($(echo "$tags" | tr -dc \\t | wc -c) - 1))"

omit_tag() { hc emit_hook tag_changed $(hc attr tags.focus.name); }
omit_focus() { hc emit_hook focus_changed "$(hc attr clients.focus.winid)" "$(hc attr clients.focus.title)"; }

{
	hc --idle &
	omit_tag
	omit_focus
} 2> /dev/null | {
	output=""
	while read -r line; do
		case "$line" in
			tag_flags*)
				tag_status=""
				for i in $(seq 0 $(($tagc - 1))); do
					tag_status="$(hc attr tags.$i.client_count)_$tag_status"
				done
				omit_tag;;
			window_title_changed|focus_changed)
				title="";;
			window_title_changed*|focus_changed*)
				title="$(echo "$line" | cut -f 3)";;
			tag_changed*)
				output_tag=""
				if [ -z "$tag_status" ]; then
					# should only happen once on first start
					hc emit_hook tag_flags
					continue
				fi
				rest="${tag_status%?}"		# TODO remove last underscore elsewhere
				for tag in $tags; do
					# status is last char
					status="${rest##*_}"; rest="${rest%_*}"
					if [ "$status" -eq 0 ]; then
						output_tag="$output_tag%{F$COLOR_BLUE}"
					fi
					if [ "$tag" = "$(echo "$line" | cut -f 2)" ]; then
						output_tag="$output_tag%{B$COLOR_GRAY}%{+o}"
					fi
					output_tag="$output_tag  $tag  %{-o}%{B-}%{F-}"
				done;;
		esac
		p "$output_tag$title"
		env printf "\n"
	done
} | lemonbar -g x$panel_height -B "$COLOR_BG" \
	-U "$active_color"
