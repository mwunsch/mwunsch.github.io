---
title: The Programs of the Week We Lost David Bowie
message_id: "<o102qi.3ge7u6ihac4b0@markwunsch.com>"
---

This Week's Program: Jan 11 - Jan 15
====================================

Alan Rickman, too. With the passing of such creative forces, what more
can we do than ensure our own creative energies don't go to waste?

## [8aba22f47c2fbd28001cb165f60d70438732bf4e][rip-david-bowie]

On Monday, on my personal website, I added a lightning bolt in the style of
*Aladdin Sane*. I reverted this commit on Tuesday

## [1ce5a19da695ee08d36831a46b2b45ea404dac64][async-go]

Last week, I wrote a fair bit about asynchrony in this program, and
the need to provide an imperative, linear sequences at the edges. Gary
Bernhardt describes this kind of ethos as
[*Functional Core, Imperative Shell*](https://www.destroyallsoftware.com/talks/boundaries). I
also wrote about CSP (Communicating sequential processes) and how
channels and queues are effective at coordinating concurrent
execution.

This week, I brought in `core.async` to see how this would work in
practice. It turns out it doesn't do much different. This program is
almost the exact same as using the `promise` based implementation. I
cleaned up some of this code in the next commit.

In the 2-arity `play` function we create a channel that is passed into
the temporal recursive arity (same as the promise). When the melody
has completed, the tail call writes to the channel. This is a blocking
operation if there is nothing reading from the channel, but because
Overtone's scheduling happens off the main thread, that doesn't
matter. We just need a way to signal back up to the caller that the
song has completed playing. Back in the 2-arity function, we read from
that channel in the context of a `go` block: an inversion of control
thread. The `go` block returns a channel of its own that holds the
value of its computation. So calling `play` in its 2-arity form is
asynchronous and returns a channel. When you read that channel, it
blocks until the song has completed playing. Exactly like the promise
implementation.

The thought occurs to me that I might be doing it wrong. I think
core.async is still rad, though, and I'm going to keep it around to
experiment on.

## [8e909868dd25dadf89ebd563da769f5ea23a6ac0][tempfile]

Instead of writing my recording to the same file every time I run the
program, I record to a tempfile. This file will be cleaned up whenever
tempfiles on the system get cleaned up. I think this is the first bit
of Java interop I've done in this program so far.

## [3aaee1faa4714ff42bb5c542ecac44de0971f12e][macro]

My first [macro](http://clojure.org/reference/macros)! I've been
scared of macros for a long time and have been actively avoiding their
creation. Now I see that they're not *that* bad. Here, I make a macro
to make a recording of a song to a path. The song argument is called
"out" assuming that it's a core.async channel and performs a blocking
read within the returned form. I made this a macro, and not a normal
function, because I wanted to pass in the call to the `play` function
without it being evaluated immediately. It's Lisp! Code is data! The
little sigils and reader sugar that you see in macros is for quoting
forms and generating symbols.

## [a2722b9599feda4303743fb4a9dd4ed253393ed2][s3]

Here, I am preparing for next week. Guess what I'll be doing.

He's told us not to blow it<br />
Cause he knows it's all worthwhile

– Mark

[rip-david-bowie]: https://github.com/mwunsch/mwunsch.github.io/commit/8aba22f47c2fbd28001cb165f60d70438732bf4e

[async-go]: https://github.com/mwunsch/sonic-sketches/commit/1ce5a19da695ee08d36831a46b2b45ea404dac64

[tempfile]: https://github.com/mwunsch/sonic-sketches/commit/8e909868dd25dadf89ebd563da769f5ea23a6ac0

[macro]: https://github.com/mwunsch/sonic-sketches/commit/3aaee1faa4714ff42bb5c542ecac44de0971f12e

[s3]: https://github.com/mwunsch/sonic-sketches/commit/a2722b9599feda4303743fb4a9dd4ed253393ed2
