---
title: The Programs of the Week After the Blizzard
---

This Week's Program: Jan 25 - Jan 29
====================================

"My name is Jonas," said the Blizzard as it dropped 26.8 inches of
snow on Manhattan. Saturday in New York City was lovely. We should
look more often for excuses to get cars off the roads, walk in the
streets, and curl up inside with our loved ones, large amounts of
bottled water, and a good book. Thanks for all you've shown us.

This week ended up being kind of a dud for writing code. I knew I
needed to take a break from
[*sonic-sketches*](https://github.com/mwunsch/sonic-sketches) to
formulate what to do next. I felt what I guess you could call
[analysis paralysis][analysis-paralysis]. I have some idea of what I
need to do next with *sonic-sketches* but couldn't articulate a
roadmap of action. I wanted to take a break and explore **Elm** and
[**Processing**](https://processing.org/) a bit, but setting up
development environments for new languages is 😖. I wanted to noodle on
my personal website but didn't feel a sense of inspiration. It's a
rut.

Escaping this inertia is the hardest part of any project. It's why
building a habit of writing code and keeping up this streak is
important: filling those green boxes in GitHub means I'm moving in
*some* direction.

Inspiration did appear throughout the week in a few ways:

+ Indie Web Camp NYC and its
  [principles](http://indiewebcamp.com/Principles).
+ Joe Armstrong, the creator of **Erlang** and star of [*Erlang the
  Movie II: Outlaw Techno Psychobitch*][erlang-the-movie] blogged
  extensively about his own
  [experiments with programming music][joearms]. Awesome.
+ I attended my first [Papers We Love](http://paperswelove.org/)
  meetup to see [Ramsey Nasser](https://twitter.com/ra) talk through a
  [paper][pushpullplusplus] that was wildly over my head.

Filled with a renewed sense of duty to computer, I'm going to outline
my grand scheme for *sonic-sketches* for you now:

+ I want to get the sonic-sketches program to a point where I can run
  it and it will produce a randomly created musical piece. This is why
  I'm investing time in learning both music theory and modular
  synthesis. I want it to sound good.
+ I want to run the program on a daily interval, so I need to set up a
  server somewhere in the cloud and a crontab (maybe).
+ When the program outputs a wav into s3, I want to set up an [AWS
  Lambda](http://aws.amazon.com/lambda) trigger to upload that wav to
  SoundCloud.

That's the plan. I'm really inspired by the
[#botALLY](https://twitter.com/hashtag/botally) community and I intend
for sonic-sketches to be my first foray into bot-making. It involves
learning enough about music and synthesis to appreciate how to inject
randomness into composition, and getting comfortable enough with
Clojure and AWS to handle the operational complexity of running a bot.

I recently purchased two books:
[*Amazon Web Services in Action*][aws-in-action] and
[*Docker Up & Running*][docker-up-running]. Operationalizing software
is crucial. It's time I felt comfortable with the tooling.

## [f80418ee6cb6f4df7e99870fed890140e3323b3e][emacs-modes]

I added major modes for **Elm** and **Processing** to Emacs. I haven't
used them yet.

## [9136a088c836c748bcac970405d2cc8ccb57e42c][photo-posts]

Most of this week was about getting my Tumblelog POSSE system to
support Photo-type posts and syndicating them to Tumblr. Mostly
straightforward, but for images that I host, I post the binary
directly to Tumblr.

## [f76a74fdfb23b4d24390e4499f2618cc8e79dbbb][forecast-api]

In sonic-sketches, I pull in a Clojure client to the
[Dark Sky Forecast API](https://developer.forecast.io/) as a
dependency of the project. I'd like to use this forecast data as input
to some of the musical compositions. Next week, I'll experiment with
implementing this and what it might actually mean in practice.

Fresh out of batteries, but still making noise<br />
– Mark

[analysis-paralysis]: https://en.wikipedia.org/wiki/Analysis_paralysis

[erlang-the-movie]: http://www.gar1t.com/blog/erlang-the-movie-ii-the-sequel.html

[joearms]: http://joearms.github.io/2016/01/27/Controlling-Live-Music.html

[pushpullplusplus]: http://peterwonka.net/Publications/pdfs/2014.SG.Lipp.PushPull.pdf

[aws-in-action]: https://www.manning.com/books/amazon-web-services-in-action

[docker-up-running]: http://shop.oreilly.com/product/0636920036142.do

[emacs-modes]: https://github.com/mwunsch/emacs.d/commit/f80418ee6cb6f4df7e99870fed890140e3323b3e

[photo-posts]: https://github.com/mwunsch/mwunsch.github.io/commit/9136a088c836c748bcac970405d2cc8ccb57e42c

[forecast-api]: https://github.com/mwunsch/sonic-sketches/commit/f76a74fdfb23b4d24390e4499f2618cc8e79dbbb
