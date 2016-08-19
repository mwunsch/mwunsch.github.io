---
title: The Programs of the Week I Started Something New
message_id: <oc61qi.38sr9bjgzdvtw@markwunsch.com>
---

This Week's Program: Aug 16 - Aug 19
====================================

After [last week's][last-week] retrospection I spent some time this
week wistfully brooding, as my ilk are
[wont to do](https://en.wikipedia.org/wiki/Young_Man_at_His_Window). The
post-launch agile blues. This week, I started on my next projects:

+ I set-up a [FreeBSD](https://www.freebsd.org) Droplet on
[Digital Ocean](https://m.do.co/c/19d9dc066fc3) (that's a referral
link 😉)
+ I started a new repository to begin explorations in
  [**Elm**](http://elm-lang.org)
+ I made some updates to an older project of mine:
  <http://www.dailyspin.biz>

## FreeBSD

I had a few motivations behind spinning up this server:

+ I want to set-up an SSH *home base* so that I can do more
  development on my iPad and get more comfortable managing a server
  remotely.
+ I want to get familiar with various flavors of
  [*nix](https://en.wikipedia.org/wiki/Unix-like) out there. Having
  encountered a fair share of friction with Ubuntu on `sonic-sketches`
  and my trials and tribulations with other flavors of Linux over the
  years, I wanted to explore outside of the
  [GNU/Linux](https://www.gnu.org/gnu/why-gnu-linux.en.html)
  [bazaar](http://queue.acm.org/detail.cfm?id=2349257&ref=fullrss).
+ I'm fascinated with FreeBSD's history and
  [philosophy][bsd-vs-linux].
+ I've been really impressed reading the
  [FreeBSD Handbook][handbook]. Mostly because it exists as a thing to
  read.
+ [Jails](https://www.freebsd.org/doc/handbook/jails.html),
  [ZFS](https://www.freebsd.org/doc/handbook/zfs.html),
  [DTrace](https://www.freebsd.org/doc/handbook/dtrace.html).

So we'll see how this progresses. My goal for the next couple of weeks
is to get Emacs running and to write some code (and write this
newsletter) using my iPad and [Prompt](https://panic.com/prompt/). I
toyed a little bit with trying to get Terraform or Ansible to manage
the server but that seems somewhat premature.

## [08fe524da1a3e0bd9557f0515638641aebb610c4][hive-city]

I've been fascinated with **Elm** since my first encounter when
exploring
[Functional Reactive Programming](https://en.wikipedia.org/wiki/Functional_reactive_programming)
(which I stumbled upon when learning about
[Iteratees](https://www.playframework.com/documentation/2.5.x/Iteratees)). It's
been really interesting to watch it evolve and see its
[influence](http://redux.js.org) spread across the web application
landscape.

I've been toying with writing a talk abstract/proposal that traces the
evolution of functional reactive approaches from the research of
[Conal Elliott](http://conal.net) through Microsoft's
[Reactive Extensions](http://reactivex.io) to
[Evan Czapliki's](http://evan.czaplicki.us) thesis to the emergence of
React.js. Let me know if that's a talk you'd like to see!

_Anyway_, I've never made a game before. I think I'd like to try
that. As I dabbled in [psuedorandomness][lol-random] I got a newfound
appreciation for dice-based games, especially
[Dungeons & Dragons](http://dnd.wizards.com) and an old favorite,
[Warhammer 40,000](https://en.wikipedia.org/wiki/Warhammer_40,000).

[`hive-city`](https://github.com/mwunsch/hive-city) is a project where
I will attempt to make a game with Elm inspired by
[*Necromunda*](https://en.wikipedia.org/wiki/Necromunda). Necromunda
is a tabletop wargame from the mid 90's, set in the Warhammer 40K
universe, that encapsulates the things that I thought were cool when I
was a kid in the mid 90's. The `README` outlines the goals of the
project. I'm only beginning to get up to speed with the Elm language
and architecture.

## [829b3436c2b7140224d61b42878b4b1813c01f81][spinning]

I took some time this week to fix an older project of mine that I had
neglected: [DailySpin.biz](http://www.dailyspin.biz).

`dailyspin` takes some text or a Twitter URL and makes it the headline
of a
[spinning newspaper](https://en.wikipedia.org/wiki/Spinning_newspaper)
gag. When I made this in 2013 these CSS techniques were all
experimental and new. As browsers evolved, the newspapers stopped
spinning. Now they spin again!

Until next week,<br />
📰 Mark

[last-week]: http://tinyletter.com/wunsch/letters/the-programs-of-the-week-after-launch

[bsd-vs-linux]: https://www.over-yonder.net/~fullermd/rants/bsd4linux/01

[handbook]: https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/

[hive-city]: https://github.com/mwunsch/hive-city/commit/08fe524da1a3e0bd9557f0515638641aebb610c4

[lol-random]: https://youtu.be/pdUCK_io9SQ?list=PLliW0zeGqNKM4k7IiSId_DphJgX_9Wha9

[spinning]: https://github.com/mwunsch/dailyspin/commit/829b3436c2b7140224d61b42878b4b1813c01f81

