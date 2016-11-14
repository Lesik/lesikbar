## What?
A POSIX shell (dash) wrapper around
[lemonbar](https://github.com/LemonBoy/bar). It is specifically tailored for
the use with herbstluftwm, though you can easily modify it to work with the
window manager of your liking.

## Why?
First of all, lemonbar requires a wrapper around it, generating data for it
to display. It is not a panel like bmpanel that you can install and use right
away.

Why write yet another wrapper when there's tons of them available already?
Primarily because I was dissatisfied with anything I found so far. I want a
single, pure-POSIX shell script, ideally less than 100 lines. No Python, no
FIFO.

## How?
In general you should be able to `./mypanel.sh`.

You need `herbstluftwm`, `acpi`, `alsa-utils` and `printf` from `coreutils`.
There is an optional dependency on
[`xtitle`](https://github.com/baskerville/xtitle).
