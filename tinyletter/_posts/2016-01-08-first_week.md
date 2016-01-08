---
title: The Programs of the First Week of 2016
message_id: "<o0n80a.3b4cebh5wdxnm@markwunsch.com>"
---

This Week's Program: Jan 4 - Jan 8
==================================

I hope ya'll are feeling resolute this week.

Last week, I teased at introducing core.async into my program. I
didn't quite get there, but I did make some intermediate steps in
building a more deterministic control flow.

## [d7cfee28601670e0897edaeadd4112b5031dda00][promise]

Previously, I had been using Overtone's built-in event system. I am a
middling computer scientist, but in my experience event listening and
triggering systems are not great at articulating the control flow of a
program. In this particular case, the `play` function sends a message
to the SuperCollider server and then schedules itself with temporal
recursion to do that again. This occurs on a separate thread, allowing
the main process to continue. This is great for live coding exercises
because you can continue to call functions and send input while it
processes in the background. But my main function is synchronous and
imperative in its nature: It starts recording to a path on the
filesystem, it plays music, when the music is done it stops
recording. With the event handles, this synchrony is not immediately
apparent.

Enter Clojure's
[`promise`](https://clojuredocs.org/clojure.core/promise). In this
commit, I've removed the event handling and instead added an
additional parameter to the `play` function: a `promise` that the
melody will complete. When `deref` is called against the promise (the
`@` character is some Clojure [Reader sugar][reader]), the thread will
block until the promise has been realized with the `deliver`
call. Instead of triggering the `::finished-playing` event in the tail
call, I deliver the metronome as the value to the promise. As a
result, the `main` function reads in the order it executes. Synchrony
is enforced around asynchronous internals.

## [ef118b13ad61b00d14b55f70b84619bc172d0d34][arity]

The next step I took was to change `play` to be a multi-arity
function. Now `play` has two forms: it either accepts two parameters:
the metronome and the melody, or it accepts those plus the promise. In
this way, the 2-arity form returns a promise to the caller, while the
3-arity form is used internally for the purposes of temporal
recursion. I thought this was a pretty clever trick.

## [7cdb4864e07cf2c171d05f748481be11b65104a7][core-async]

Here's where the week got thrown off a little. I was pleased with my
`promise` implementation but I still wanted to explore how core.async
could make this that much more deterministic. So I added it as a
dependency. I also decided to take this time to upgrade my Emacs
packages, including CIDER and its associated nREPL plugin. Afterward
none of my Clojure programs would run, not even Leiningen. After some
googling and digging, I realized that even though I thought I had Java
8 on my system, my Mac was still using the Java 6 JRE that is shipped
by Apple. After some brief confusion on the Oracle website (I thought
I had downloaded the JDK but really I downloaded the JRE which
installs itself in a directory called "Internet Applets" or some
malware-looking thing) I finally got it sorted. It's this kind of shit
right here…

### Communicating Sequential Processes

Here's a brief diversion on some of the background material about why
I think core.async is cool and why I'm really keen on the CSP model.

+ [Communicating sequential processes on Wikipedia][wikipedia]. Dense
  but a decent introduction to the ideas.
+ [*Clojure core.async Channels*][channels]. The blog post that
  introduces core.async and also provides the rationale behind
  bringing CSP to Clojure.

Effectively, what really interests me in the CSP approach is this idea
of enforcing synchrony around inherently asynchronous activity. Nearly
all apps these days do something that can and should happen in
separate threads or processes. The challenge is in coordinating these
disparate activities into a single deterministic thread of
execution. Another compelling mode of thinking about this challenge is
*Railway oriented programming* (Google it) which describes how
execution occurs linearly throughout a system but diverges in failure
states. CSP and the use of communication channels seem to support this
kind of thought. FRP and Signals is another line of thought. It's all
really interesting to me…

Another way to think about this as it relates to sonic-sketches:
Reading a promise (with `deref`) blocks until something has been
written to it (with `deliver`). When coordinating on a CSP channel,
the Writing process blocks until a Reading process begins.

Next week: more concurrency thinking. More synchrony.

I hope you're enjoying this TinyLetter. If you are, I'd really love to
hear your thoughts. Reply to this email or write me a tweet.

Your friend in 2016,
<br />Mark

[promise]: https://github.com/mwunsch/sonic-sketches/commit/d7cfee28601670e0897edaeadd4112b5031dda00

[reader]: http://clojure.org/reader

[arity]: https://github.com/mwunsch/sonic-sketches/commit/ef118b13ad61b00d14b55f70b84619bc172d0d34

[core-async]: https://github.com/mwunsch/sonic-sketches/commit/7cdb4864e07cf2c171d05f748481be11b65104a7

[channels]: http://clojure.com/blog/2013/06/28/clojure-core-async-channels.html

[wikipedia]: https://en.wikipedia.org/wiki/Communicating_sequential_processes
