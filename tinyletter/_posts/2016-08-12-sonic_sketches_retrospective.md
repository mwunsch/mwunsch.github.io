---
title: The Programs of the Week After Launch
message_id: <obt5uz.pvwsxa07j0m5@markwunsch.com>
---

This Week's Program: Aug 8 - Aug 12
===================================

If you haven't already, **follow
[@sonic_sketches](https://twitter.com/sonic_sketches) on Twitter**!

This week, I wrapped up this project. Now it's time for the
[post mortem][postmortem].

On August 31, 2014 I wrote a note in [Vesper](http://vesperapp.co),
the now seemingly abandoned iOS note-taking app, and tagged it with
_Idea_:

> **Today's Sound**
>
> Automated daily musics. Using phases of moon, weather, stock info as
> random generators to a [Figure][figure]-esque synth. Publishing to soundcloud
> and twitter.

I have a bunch of notes tagged _Idea_ in Vesper. Every time I open
them up I think, "I should move these out of Vesper and into a
different note-taking app."

On November 2, 2015, over a year after writing that note, I made the
[initial commit][first-commit] to the `sonic-sketches` repository. It
was a Monday. [I wrote about it.][nov-tinyletter]

Just over nine months after that initial commit I had
*@sonic_sketches* running on Twitter. _Nine months_.

Just like a Passover seder, it's time to ask the
[_4 questions_](https://www.infoq.com/articles/4-questions-retrospective).

## What Went Well?

I always like to answer this question first with: _We did it!_ This
project saw its way to completion, met the stated goals, and is now
merrily rolling along.

More than just getting it out into production, I took the time to
exercise my DevOps muscles and now I or anyone else can create a
reproduction of the sonic-sketches environment in AWS.

It's been a fantastic learning experience, I've received a ton of
great feedback, and I documented my process all along the way. Here's
what I wrote in my [very first tinyletter][first-tinyletter]:

> I don't write much code these days; yet the backlog of projects,
> languages, and frameworks to explore grows unabated. I started this
> practice to ensure I'm always making progress and sharpening my
> skills. Otherwise the backlog becomes insurmountable.

I have a big backlog of _Ideas_ in various note-taking apps. I started
this whole macro-project with the intention of working my way through
that backlog. With the launch of `@sonic_sketches`, I now get the
satisfaction of checking off a box that's been there for nearly two
years. No project has been as meaningful or as prominent in the
[past year of writing code][year-tinyletter] than `sonic-sketches`.

I also changed jobs midway through!

[first-tinyletter]: http://tinyletter.com/wunsch/letters/the-programs-of-the-week-of-hurricane-joaquin

[year-tinyletter]: http://tinyletter.com/wunsch/letters/the-programs-of-a-year-of-deliberate-practice

## What Didn't Go So Well?

I think the obvious thing here is that it took a lot longer than I had
anticipated. I knew going in that the pace of my commits and visible
progress would be slow, but it felt like I still underestimated how
that would _feel_. I was really jazzed about working in **Clojure**
and Overtone but when I started doing the DevOps kind of thing it felt
like it killed a lot of momentum.

I also felt like I was encountering a lot of friction with
Overtone. It's a system that's been designed around live coding, and
here I was trying to not do that. The documentation is somewhat sparse
and most of my learning came from REPL experimentation, reading
examples in the source code, and watching videos of people performing
with it. I would have loved to have spent more time learning about how
it works, and more importantly learning more about SuperCollider
underneath it. I skipped that learning to get the end result built
sooner.

I had a bunch of assumptions about how this ought to work that were
thrown out along the way. I thought I would be utilizing AWS Lambda
for a lot and I did a bunch of things preparing for that only for
those things to end up tossed out later.

I thought that doing a bunch of stuff for Vagrant would better prepare
me for the move to AWS. That was barely the case. False starts with
Otto and Packer.

I completely punted on production monitoring and alerting if something
goes wrong with the bot.

## What Have I Learned?

A lot. Apart from launching a product, this was a learning exercise.

+ This was my first **Clojure** project, exposing me to the language,
  the environment, the tooling. Leiningen, Emacs + CIDER, all that
  stuff.
+ I used `core.async` to great effect.
+ I learned and used Overtone. Making music with code. That's new for
  me.
+ I went from having nearly zero musical understanding to getting
  comfortable enough with musical theory to create some rules for
  generating music.
+ I got exposed to the Forecast API and got deep with the Twitter API.
+ A crash course in FFmpeg. Thanks to my pal
  [Casey](https://twitter.com/ckolderup) for giving me some guidance
  here and suggesting I use Twitter as the main place to host my
  songs.
+ I did some interesting stuff with Vagrant. I'm used to deploying web
  applications. Deploying a thing that had a whole other set of
  dependencies is really new to me.
+ I got really deep into the world of AWS. CloudFormation, Lambda,
  CodeDeploy, IAM, etc. This was hard and tedious, but holy cow; I was
  exposed to a huge amount of stuff and now I feel I can speak with
  just a wee bit of authority about how these things are pieced
  together.

It feels like there's more granularity here, but yeah I learned so
much. I learned that I can keep this coding/newsletter habit going and
that it produces results.

## What Still Puzzles Me?

So much. Music. Modular synthesis. SuperCollider. Building
production-ready apps with Clojure with logging, monitoring, testing,
etc. ClojureScript. Appropriate problem domains for AWS Lambda. What tools to
choose for building continuous delivery systems. Jackd. The merits of
different Linux distros. What one _can't_ do with FFmpeg. …

So much.

I also kept writing code this week.

## [839c7cd544907afa566c27c343101b6eca18693f][datagen]

I use `clojure.data.generators` again to use the song's seed as the
seed to choose what tweet. Now the twitter message is deterministic
with the song.

## [1e7e7268e7fb6a38e5d5844cd6923130b58c6cc0][ffmpeg-colors]

I choose the colors of the mp4 video for Twitter at random. I pull the
list of colors from ffmpeg with this handy script:

    ffmpeg -colors 2>/dev/null | tail -n +2 | awk '{print $1}'

Like the tweet, these are chosen deterministically.

## [eaaa482ed9867af2fc5bcf564193fd086511e107][emoji-bug]

I find and fix a bug. I need to convert the interval from a string
back to a keyword so that I can choose the appropriate emoji for it in
the tweet. I also reach for `clojure.string/join` to bring a bit of
clarity to tweet composition.

## [a50a5866b7aeebc6fb85c5c0c0f9d69d129f9c85][hive-city]

I start my next project. I'll be writing it in
[**Elm**](http://elm-lang.org). First fun thing I learn about Elm: it
stores dependency artifacts in a directory called `elm-stuff`. More
about this next week.

🚼 Mark

[figure]: https://allihoopa.com/apps/figure

[postmortem]: http://ieeexplore.ieee.org/xpl/login.jsp?tp=&arnumber=526833&url=http%3A%2F%2Fieeexplore.ieee.org%2Fxpls%2Fabs_all.jsp%3Farnumber%3D526833

[first-commit]: https://github.com/mwunsch/sonic-sketches/commit/21199013c1589e0f745c3bcc4be7a4fd5f0ce11f

[nov-tinyletter]: http://tinyletter.com/wunsch/letters/overtone-week-1-2

[datagen]: https://github.com/mwunsch/sonic-sketches/commit/839c7cd544907afa566c27c343101b6eca18693f

[ffmpeg-colors]: https://github.com/mwunsch/sonic-sketches/commit/1e7e7268e7fb6a38e5d5844cd6923130b58c6cc0

[emoji-bug]: https://github.com/mwunsch/sonic-sketches/commit/eaaa482ed9867af2fc5bcf564193fd086511e107

[hive-city]: https://github.com/mwunsch/hive-city/commit/a50a5866b7aeebc6fb85c5c0c0f9d69d129f9c85

