---
title: This Programs of the Week of Valentine's Day
message_id: <olj0cb.35kyu1stuf8j@markwunsch.com>
---

This Week's Program: Feb 13 - Feb 17
====================================

[Last week](/tinyletter/2017/02/niko.html), I outlined why I am
choosing **Racket** as the language for my next project. This week, I
began what is, without a doubt, my most ambitious project yet.

## [d2a9857cc162798d91a5f50fe500b67a7bcd23d9][chyron]

I run `git init` on [`chyron`](https://github.com/mwunsch/chyron)
(working title), and fill out the project README.

## Chyron

Chyron (no relation to the [ChyronHego](http://chyronhego.com)
Corporation) is a project to better understand the creation and
distribution of live video streams. I'm building
a [*vision mixer*](https://en.wikipedia.org/wiki/Vision_mixer) in the
Racket programming language. The name comes from the character
generators and graphics used in television broadcasts (Chyron has
become a generic trademark like "Xerox" or "Kleenex"). I am looking
for a new name and am taking suggestions.

I'm fascinated by the proliferation of live video broadcasting on
platforms like Twitch and Facebook Live. I want to build a set of
tools that makes that makes live broadcasting easy, fun, and
extensible. I set out to build a toolkit
like [Streamlabs](https://streamlabs.com), but as my understanding of
the technologies involved grew, so too did my ambitions for this
project. From the protocols to stream live data to the video mixing
tools, the entire domain fascinates me.

Using Racket's powerful language capabilities, I want to build an
environment similar to [Overtone](http://overtone.github.io)
or [Extempore](http://extempore.moso.com.au) but for live video
compositing. I want to evaluate
an [s-expression](https://en.wikipedia.org/wiki/S-expression) and see
a change in the video stream.

I admit that this is bananas.

I am a complete novice to the entire domain of multimedia, and this is
a hell of a way to take a stab at it. I think it's doable.

My first milestone for `chyron` is to produce
a [lower third](https://en.wikipedia.org/wiki/Lower_third) that I can
pull in to [OBS Studio](https://obsproject.com). That's still a long
ways off.

### C

In order to execute this project, I believe I'll have to step down
into the depths of **C**. C scares me. I respect it and I fear it. I
don't know _how_ to work in audio and video in software without using
it. For this project, along with using and learning Racket, I'll be
looking into the [GStreamer](https://gstreamer.freedesktop.org)
framework. I'll need to write some kind of binding
in [Racket's FFI](http://docs.racket-lang.org/foreign/). This is so
outside of my programming comfort zone. What keeps me motivated? The
knowledge that if I can pull this off, I will have _so much cred_.

TODO:

1. Learn Racket
2. Learn GStreamer
3. Question what the heck I'm doing (repeat this step frequently along
   the way)
4. Write a Racket binding for GStreamer (or
   consider [`gir`](https://github.com/Kalimehtar/gir))
5. Write some code ???
6. Works perfectly the first time no bugs
7. All dreams come true

Feeling _pretty_ good.

## [60801771a6a29f44846bb7e7da98f061af2825a9][raco]

I run `raco pkg new`. This is my first time
using [`raco`](https://docs.racket-lang.org/raco/). The journey of a
thousand miles begins with running a terminal command you're not
entirely certain of. My _scheme_ begins!

I took Valentine's Day off from my committing streak, and that was a
great decision that I feel really good about (Hi Vera I love
you!).

💝 Mark

[chyron]: https://github.com/mwunsch/chyron/commit/d2a9857cc162798d91a5f50fe500b67a7bcd23d9

[raco]: https://github.com/mwunsch/chyron/commit/60801771a6a29f44846bb7e7da98f061af2825a9
