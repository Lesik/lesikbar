## What?
This time, in October 2017, I needed an even snappier panel for use on my Raspberry Pi 3. Screen brightness, volume level and date/time didn't matter that much, which sped up the panel significantly. Besides, instead of requesting `herbstclient tag_status` on every update, I decided to use the information that `herbstclient --idle` already delivers.

The panel is still POSIX compliant and is guaranteed to work with Debian's `dash`.

Due to the aforementioned changes, the panel runs smoothly and with very, very little and almost unnoticable lag on a Raspberry Pi 3.

## How?
In general you should be able to `./lesikbar.sh`.

You need `herbstluftwm` and `printf` from `coreutils`.

## Screenshot?
Soon...
