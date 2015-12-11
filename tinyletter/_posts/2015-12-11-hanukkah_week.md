---
title: The Programs of the Week of Hanukkah
message_id: "<nz7ef3.3w2z5kfghmxjh@markwunsch.com>"
---

This Week's Program: Dec 7 - Dec 11
===================================

Happy {Ch,H,Ḥ}anuk(k)ah! We're several nights into the Festival of
Lights and this week has been all about finding a
rhythm. Literally. How do you teach a computer rhythm? I have a hard
time (pun) with rhythm myself so you can imagine the challenge of
programming a computer to stay on beat.

## [afcf6d793d129e2563fe3b67439ddbfc71f67de9][metronome]

The first thing I do is bring in a sample of a simple kick drum from
[Freesound](https://freesound.org/people/opm/sounds/2086/). Overtone
provides all the tools needed to pull down a sample from Freesound and
use it like any other synthesized instrument. This is pulled right out
of Overtone's documentation.

The next thing I do is exercise a common idiom seen in Overtone (and
Extempore/Impromptu) called
[*temporal recursion*](http://extempore.moso.com.au/temporal_recursion.html). Effectively,
this means a function that schedules itself to be called again at some
point in the future. Similar to *tail call optimization*, this means
that you need not concern yourself with a growing stack. This is
accomplished in Overtone with the
[at-at](https://github.com/overtone/at-at) library and a collection
of functions (including the `after-delay` function that I was using in
earlier iterations). The `at` function is used to schedule messages to
the SuperCollider server and `apply-by` schedules Clojure functions to
be run in the future.

These scheduling functions are used in conjunction with Overtone's
metronome capabilities. The metronome is really just a time
manager. You define a metronome by calling `(metronome bpm)` and it
returns a function. When the returned function is called, it gives you
a beat number and multiple calls will reveal that it's just ticking
along in the background. When you pass a beat number in as an argument
to the returned function, it returns a timestamp of when that beat
will hit. In this way the metronome just maps beats to clock
time for the purposes of ahead-of-time scheduling.

I call this function like so:

    (play-bars 4 (metronome 120) kick)

This is a lie. It doesn't play 4 bars. Instead, it plays `kick` for 4
beats. I haven't quite figured out the best abstraction for counting
down bars. Overtone has functions `metro-bar`, `metro-tock`, and
`metro-bpb` that are about mapping beats to bars. I'm not sure how
relevant these are. My end goal is, given a list of lists of notes,
treat each note list as a bar and when all the notes have been played,
trigger some kind of event. I'm not sure if I'm trying too hard to
cram the abstraction of Western notation into Overtone, but I'll keep
exploring. Also, if anybody wants to treat me to a lesson on music
theory, I'm down.

The good news is this week I devised a real actual goal to accomplish
by year-end: something to work toward more than just noodling.

I will leave you with this
[excellent video](https://www.youtube.com/watch?v=Mfsnlbd-4xQ) from
Clojure Conj 2012 where Chris Ford uses Overtone to demonstrate how
well the domain of music maps to a functional language. This is an
incredibly well-done presentation and repeat viewings continuously
provide me with inspiration and guidance.

Until next week.

🕎 Mark

[metronome]: https://github.com/mwunsch/sonic-sketches/commit/afcf6d793d129e2563fe3b67439ddbfc71f67de9
