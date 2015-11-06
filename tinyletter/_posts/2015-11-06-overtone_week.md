---
title: Overtone Week 1
message_id: "<nxezge.1y09yhve1o6y9@markwunsch.com>"
---

This Week's Program: Nov 2 - Nov 6
==================================

Back on the _.chain(gang). This week, I started a new project.

## sonic-sketches: [ca99b06a335d204c57b364e2c4420285bd7a4110][readme]

In the README for my new repository, I lay out what I hope to
accomplish. I've been fascinated with **Clojure** for some time. Apart
from a small toy project for work, I haven't really explored the
entirety of the language or ecosystem. I realize after writing that
sentence that "entirety" is real big. I haven't explored enough of
Clojure to my liking. No Clojure project is as fascinating to me as
[Overtone](http://overtone.github.io/).

Overtone is "an open source audio environment designed to explore new
musical ideas..." which sounds super rad and when you see it
[demonstrated](https://www.youtube.com/watch?v=imoWGsipe4k) is even
more rad. I'm not a musician, but um I own a MIDI Controller (purchased
when I attempted to pretend to try to become a musician) so. I had
toyed with Overtone a little bit in the past. Just enough to make some
blips and bloops. Just the idea of writing code to produce sound is
thrilling to me.

This week I set out to take more meaningful steps in exploring
Clojure's ecosystem through the lens of Overtone. Along the way I hope
to pick up some deeper understanding of
[Leiningen](http://leiningen.org/), Clojure's project automation and
configuration tool, and become more productive in
[CIDER](https://github.com/clojure-emacs/cider), the Clojure
development environment for Emacs. And, it goes without saying, I hope
to make some *phat* beats.

I also really like the idea of code *studies*. I have some idea for an
Overtone project that is larger in scope, but I want to sketch out
ideas and experiment. The same way that an artist would sketch out
studies for a greater piece. Michael Fogus talks about
[code painting](http://blog.fogus.me/2015/02/16/code-painting/) and I
think that kind of work is invaluable. It's also a great way to
reinforce *the streak*. I tend to get hung up on some kind of large,
grandious idea of a project. I freeze there when I should be embarking
on learning and exploration phases.

## sonic-sketches: [cb161a3acd950a7582e57ffaf857a79569ca033a][mousedrums]

Here's the first sketch, just using one of Overtone's built-in
examples. Overtone is largely designed as a tool for live coding. Most
of the examples and demonstrations show off Overtone's facilities
within a REPL or Emacs. Finding out how to bake something into an
application is the challenge I'm interested in.

Presently, I'm struggling with making this a better behaved command
line utility. I've taken simple POSIX signal handling for granted it
seems. This weekend I hope to brush up on my Clojure reading, and get
a better understanding of how the JVM can be a better Unix
citizen. Less trivial examples to come next week, hopefully.

Until then,<br />- Mark

[readme]: https://github.com/mwunsch/sonic-sketches/commit/ca99b06a335d204c57b364e2c4420285bd7a4110

[mousedrums]: https://github.com/mwunsch/sonic-sketches/commit/cb161a3acd950a7582e57ffaf857a79569ca033a
