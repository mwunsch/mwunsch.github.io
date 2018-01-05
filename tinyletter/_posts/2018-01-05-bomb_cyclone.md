---
title: The Programs of the First Week of 2018
message_id: <p23oi4.3fjbrd1wu4no3@markwunsch.com>
---

This Week's Program: Jan 1 - Jan 5
==================================

I am entering into 2018 filled with just a mild sense of rage and/or
despair at this code. After a big breakthrough in getting my
cross-platform Racket image sink to actually run, this week I
discovered that it is _very_ slow. I spent a good portion of this week
getting the GStreamer [`cairooverlay`][cairooverlay] to work. It kind
of works, but it's finicky and crash-prone. This C/Racket interop is
tricky business, and I'd like to get back to just making a fun
framework for streaming.

As has become tradition, I'm going to take some time to reflect and
write out what I would like to work on and explore in the year ahead.

## In 2017 I Did

+ **Elm**
+ **Ansible**
+ **D3**
+ **Racket**
+ **C**

At the beginning of 2017 I finished up my first exploration with the
**Elm** programming language
and [`hive-city`](https://github.com/mwunsch/hive-city). Elm is a
fantastic language, and I think it has a huge amount of promise. I
likely won't be returning to Elm anytime soon, though. There are a ton
of technologies in web development left to explore, and Elm has a
tough row to hoe to become as mainstream as it aspires to be. In 2017
I also published [my first Medium post][medium-post], a retrospective
on the months I spent building Hive City. Like just about everything
else I write, publishing to Medium is done through
a [custom Jekyll plugin][publish-to-medium]. In 2018, I'd like to
publish some more stuff to Medium, especially now
that
[Tinyletter appears to be doomed](https://www.inc.com/maria-aspan/tinyletter-going-away.html).

Early in the year I wanted to do _something_ with my FreeBSD server
hanging out on DigitalOcean, and thought it would be a good
opportunity to mess with **Ansible**. Ansible was straightforward and
pretty easy to wrap my head around. I
created [`mechwarper`](https://github.com/mwunsch/mechwarper) to house
my studies in server administration. I'll be revisiting this soon, I
think. I'd like to get [Plex Media Server](https://www.plex.tv)
running on my server.  Maybe even get up to speed
with [FreeBSD Jails](https://www.freebsd.org/doc/handbook/jails.html)
in the process.

2017 was the first year I have worked with **D3**. I whipped up a
quick little project to visualize
my
[Tinyletter Metrics](https://bl.ocks.org/mwunsch/f041519e6c2795f5419d09771dd14da2). D3
is very good. Bl.ocks.org is _great_. Without a doubt I will be
revisiting D3 again; it's just a matter of _what_ I'll be
visualizing.

2017 was dominated by **Racket** and one
project: [`overscan`](https://github.com/mwunsch/overscan). It looks
like this will carry over into a good chunk of 2018 as well. Racket is
a good language, with a community of academic enthusiasts. The thing
that keeps me sticking with this project is the domain. Video is
_cool_ and _hard_. After coming up with
a [working proof-of-concept](https://vimeo.com/218155138), I dived
_really_ deep
into [GStreamer](https://gstreamer.freedesktop.org). Originally I
thought I was creating a neat toolkit for video streaming. Overscan
has grown to become a DSL for live-coding with GStreamer, and that's
fine by me. This project has got me messing around with a bunch of
different **C** libraries: GLib, GStreamer, and
now [Cairo](https://cairographics.org). Every day I work on Overscan I
learn something new about how computers work at a basic level, and
that's been so rewarding.

But this project has also been _very_ frustrating. As I said above,
I'm a bit over this C/Racket stuff, and I need to take a step back and
just focus on the streaming bits that I really care about. I'm
going to try to get a first release cut of Overscan before the
Spring.

In 2017, my list of things to explore included Racket and D3, but it
also included some other things. I'm committed to starting at least
one new project in a new programming language in 2018.

## In 2018 I Will

+ [**Elixir**](http://elixir-lang.org). Once I'm done with Overscan,
  I have an idea for a web app and I'm going to build it with Elixir.
+ [**JavaScript**](https://www.ecma-international.org/publications/standards/Ecma-262.htm). I'm
  going to write a web application which means I'm going to write a
  whole lot of JavaScript. More JavaScript than I would like. The
  state of JS is always changing, and every time I pick it up it feels
  like there's a new toolset to understand and (maybe) appreciate.
+ [**Go**](https://golang.org). Long time readers of this Tinyletter
  might be surprised to find Golang on this list. I've knocked Go
  quite a bit. It's a language that I find useful but can't get
  excited about. I think the time has finally come to give it a
  whirl. I have an idea in mind that might fit the language pretty
  well.

## In 2018 I Might

+ [**Unity**](https://unity3d.com). Game development still seems like
  a fun thing to try. Last year I said I would do it, but Overscan
  took over.
+ [**Swift**](https://swift.org). I messed around a bit with Swift in
  2017 during Harry's Hackday. It was neat! iOS SDK's are quite good!

## In 2018 I Won't

+ [**Rust**](https://www.rust-lang.org/en-US/). In 2016 Rust was on
  the "I Will" list. In 2017 Rust was on the "I Might". Sadly, I
  won't. Rust is still very cool to me, especially in light of the
  pain I've experienced working in C. Alas, it's not likely to happen.
+ [**Haskell**](https://www.haskell.org). Will have to wait another
  year.
+ F♯, Prolog, Pharo, PureScript, ClojureScript, Python, Kotlin, etc.


What are the projects _you_ plan on embarking on in 2018? What about
the ones you won't be committing to?

Let's learn together this year. Stay warm,<br />
🤗 Mark


[cairooverlay]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-cairooverlay.html

[medium-post]: https://medium.com/@markwunsch/five-months-of-gamedev-with-elm-62be2de75ca2

[publish-to-medium]: https://github.com/mwunsch/mwunsch.github.io/blob/master/_plugins/publish_to_medium.rb
