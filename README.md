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
I noticed that as my needs and computers change, so do my panels. This doesn't mean that one of my newer wrappers is better than the older ones, so do check out all of them to discover whichever you like best. Simply have a look into the different branches of this repository.

## Contribute?
While I do consider the panels to be feature-complete (I usually only push them once I'm fully satisfied), there are things you can improve if you want. For example, I really don't give a shit about all the different options lemonbar offers, like panel colors or fonts. The colors could be derived from herbstclient attributes, for example, and the font could be requested from Xresources. That would be cool to have, but I find color work horrendously boring, which colors fit well with others, bla. If you care about this, feel free to submit a pull request.
