---
title: The Programs of the Week of the H'ackathon
message_id: <oujtxw.d5adsx0d4mbk@markwunsch.com>
---

This Week's Program: Aug 7 - Aug 11
===================================

Last week's Tinyletter was just all out of whack. The subject line of
the email got mangled. It was `The Programs of a Week of
#lang`. Markdown processing chewed that up. I also messed up the date
in the title line. I'm playing fast and loose on this little
letter. Move fast and break things, amirite?

## [60b6c919d770f69c2b18e0a5a86b7ff2fc4e9806][twitch]

In this commit, I move the functionality for creating an RTMP _sink_
for Twitch into its own module. In the process, I also make the
`twitch-stream-key` a
Racket
[_parameter_](https://docs.racket-lang.org/guide/parameterize.html). If
you've worked in Clojure, you are probably familiar with certain
`*earmuffs*` (a var surrounded by asterisks on either side). This is a
convention of Clojure for vars that are intended for
rebinding. Long-time readers of _This Week's Program_ might recall how
I used this
in [sonic-sketches](https://github.com/mwunsch/sonic-sketches)
with [`clojure.data.generators/*rnd*`][datagen]
and [`binding`](https://clojuredocs.org/clojure.core/binding) to get
deterministic results with pseudorandomness.

In Scheme, this kind of dynamic rebinding feature has a first-class
representation called a [_parameter_][srfi]. Now when streaming to
Twitch from within Overscan, you can `parameterize` your program with
a Twitch stream key (it defaults to getting one from the environment).

[srfi]: https://srfi.schemers.org/srfi-39/srfi-39.html
[datagen]: https://github.com/clojure/data.generators

Through the rest of the week I spend a fair bit more time working out
documentation, and scratching my head about how best to expose parts
of the Introspection API.

## Harry's H'ackathon

This week, the engineering team at my employer did our inaugural
Hackathon! For one day, the engineering team split up into teams to
work on a bunch of fun projects. I worked on a team where we decided
to pursue doing some stuff with Augmented Reality (lol it was kind of
a fun goof to learn
about [ARKit](https://developer.apple.com/arkit/)).

This was my first time _really_ trying to get my hands dirty with the
**Swift** programming language, which I found interesting. What makes
Swift particularly challenging for learning in a day is contorting
your brain to also accept **Objective-C** as input. In the end I got
some exposure to ARKit, but I spent the better part of the day working
through some stuff
with [Vision](https://developer.apple.com/documentation/vision),
Apple's new computer vision framework that's a smaller part
of [Core ML](https://developer.apple.com/machine-learning/), Apple's
new machine learning framework.

I was exposed to _a heck of a lot_ of new stuff all at once, and had a
great time with the quick immersion. Apple is _really_ good at
creating frameworks. I would really love to return to app development
at some point in the future, but the important thing is that I came
away from this experience with two distinct _learnings_.

1. You can not do both Computer Vision/Feature Detection and Augmented Reality at the
   same time. The phone is just not powerful enough. We repeatedly hit
   this wall with both `Vision` and `CoreImage`. If anyone has any
   examples otherwise, I'd love to see them!
2. Apple's programming monospace font, SF Mono, is really lovely. This
   font came as a part of macOS Sierra, and is used in XCode, but is
   not part of the Mac system fonts. To extract this font to use in
   your preferred tools and editor,
   follow [this tutorial](https://simonfredsted.com/1438). I'm using
   SF Mono in Emacs now and it is really nice.

Have a good evening and a great weekend!

📱 Mark

[twitch]: https://github.com/mwunsch/overscan/commit/60b6c919d770f69c2b18e0a5a86b7ff2fc4e9806
