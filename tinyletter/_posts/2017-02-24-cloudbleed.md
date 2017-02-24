---
title: The Programs of the Week SHA-1 Broke
message_id: <olw8ay.1a6y79z4gkdkp@markwunsch.com>
---

This Week's Program: Feb 20 - Feb 24
====================================

What a week. [SHA-1 is broken in practice.](https://shattered.it/)
Cloudflare [cloudbled][cloudbleed] all over the carpet. Presidents'
Day…

## [bb3ea59449bf580f0aa1c3937107b60be541f0b4][overscan]

### Chyron → Overscan

I've renamed my project from the trademarked "chyron"
to [**Overscan**](https://en.wikipedia.org/wiki/Overscan) which is:

1. Not a registered trademark.
2. A nice reference to the project domain.
3. A wink to [Overtone](http://overtone.github.io).

I reached out to my twitter followers with [a poll][poll] to help
arrive at the name. *Overscan* just barely edged out the other choice,
*Rastergun*, which is such a great name and I really ought to use it
for something at some point (it's a reference to a television's
electron gun).

I'm working my way through the [Racket Guide][racket-guide] and am
slowly picking up knowledge on Racket. There's a lot to go through,
since this project is so big in scope. The other area I've been
reading up on is modern **C** development. Since the revelation of the
Cloudflare vulnerability, writing anything in C seems like a bad
idea. I'm not planning on doing a lot with C, but getting comfortable
with [GStreamer](https://gstreamer.freedesktop.org) is real important
for this project.

I've been reading the book, [*21st Century C*][c-book], and it's
already introduced me to tooling and techniques I had never used
before.

[poll]: https://twitter.com/markwunsch/status/834154537829163008

## [ec7cae0b47b798df95aae57b6f50815712d8e9a6][pkgconf]

Back in [`mechwarper`](https://github.com/mwunsch/mechwarper), I
instruct my Ansible playbook to
install [`pkgconf`](http://pkgconf.org). `pkgconf` is a recent,
FreeBSD take on [`pkg-config`][pkg-config]. The usage is effectively
the same, but `pkgconf` takes a [different][comparison] approach to
resolving dependencies, and I suspect that FreeBSD folks just like to
be a _tiny_ bit contrarian. Both tools are used to help create flags
and linking statements for the C compiler.

## [90299c27fe6b18550f68c0241a449a27e8ebeb0a][c99sh]

Another bit of wisdom from *21st Century C* led to this little
function here, that I've put in my `.bashrc`:

    function c99sh() {
        tmpfile=`mktemp`
        trap "rm -f $tmpfile" EXIT
        cc -xc - -g -Wall -O3 -o "$tmpfile" -include stdio.h $@ && $tmpfile
    }

The `c99sh` function accepts C code on STDIN, and then will quickly
compile and run that program without fuss. Given how scary C is,
exercise your best judgment on how to use this function. This helps me
quickly mess around with some GStreamer stuff as I'm learning. A more
robust version can be found
at [`RhysU/c99sh`](https://github.com/RhysU/c99sh).

One really cool thing for me this week is
that [Sam Aaron](http://sam.aaron.name), contributor to Overtone and
the creator of [Sonic Pi](http://sonic-pi.net), reached out to me on
Twitter after my poll with a feature request:

> @markwunsch If you had an OSC API, then I could live code your
> system straight from @Sonic_Pi by sending well-timed OSC messages
> :-)
>
> <https://twitter.com/samaaron/status/834487380979630080>

First of all, this is a great idea. Secondly, I have a huge amount of
respect for Sam and the work that he does and (real talk) I am geeking
out that he has an eye on this project.

Next week: More learning Racket. More learning GStreamer. Hopefully I
can start to put them together.

🌧 Mark

[racket-guide]: https://docs.racket-lang.org/guide/index.html

[cloudbleed]: https://blog.cloudflare.com/incident-report-on-memory-leak-caused-by-cloudflare-parser-bug/

[overscan]: https://github.com/mwunsch/overscan/commit/bb3ea59449bf580f0aa1c3937107b60be541f0b4

[c-book]: http://shop.oreilly.com/product/0636920033677.do

[pkgconf]: https://github.com/mwunsch/mechwarper/commit/ec7cae0b47b798df95aae57b6f50815712d8e9a6

[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/

[comparison]: https://github.com/pkgconf/pkgconf#comparison-of-pkgconf-and-pkg-config-dependency-resolvers

[c99sh]: https://github.com/mwunsch/dotfiles/commit/90299c27fe6b18550f68c0241a449a27e8ebeb0a
