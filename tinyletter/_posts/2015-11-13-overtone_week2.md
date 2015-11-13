---
title: Overtone Week 2
message_id: "<nxrz08.2lzplpfsbsgeq@markwunsch.com>"
---

This Week's Program: Nov 9 - Nov 13
===================================

It's Friday the 13th 👻! This was a weak week, all centering around one
line of code:

    (.addShutdownHook (Runtime/getRuntime) (Thread. (fn [] (println "Bye!"))))

What this code does, why it does what it does, and why it didn't work
as expected is what consumed this week's work. On the whole, I really
didn't write as much code as I would have liked, but I learned a lot.

For this week's newsletter: POSIX Signals, the JVM, and Trampolines.

## sonic-sketches: [eb53a0d0b2409ebf68dbe8941e8325a359ace8b7][shutdownhook]

Last week, I alluded to struggles with understanding how the Overtone
process worked and to make sure it was playing nicely on the command
line. Some Googling and digging through Overtone source code ate up my
time this week.

First, there's this little gem of a document: *Troubleshooting Guide
for Java SE 6 with HotSpot VM:
[Integrating Signal and Exception Handling](http://www.oracle.com/technetwork/java/javase/signals-139944.html)*. I
read this. I read it again. I just read it again when preparing this
email. I still just can't even... Everytime Solaris is mentioned my heart
just pounds kind of fast and my eyes get blurry. If you *can even*
please do send me a summary.

When you're in your terminal and you send `Ctrl-C` to the foreground
process, this sends the `SIGINT` signal (The command `kill -2` does
the same). In Ruby, we have
[`Signal::trap`](http://ruby-doc.org/core-2.2.0/Signal.html#method-c-trap)
that makes it really straightforward to handle clean shutdowns. The
fork and exec (and trap) pattern is well-tread. Approaching the JVM, I
really didn't have a great sense of how it handled inbound
[POSIX signals](https://en.wikipedia.org/wiki/Unix_signal).

Buried in that Oracle document is this little bit of code:

    java.lang.Runtime.addShutdownHook

So that's how I learned how Java handles signals designed to terminate
processes. The
[`Runtime.addShutdownHook`](http://docs.oracle.com/javase/8/docs/api/java/lang/Runtime.html#addShutdownHook-java.lang.Thread-)
method is Java's mechanism for adding cleanup work to a doomed
process. The method accepts a `Thread`. In Clojure's Java interop
syntax, it looks like the above code.

This code didn't work. When I sent `Ctrl-C`, I did not see "Bye!".

### Trampoline

Why didn't `Ctrl-C` work as originally thought? I was running this
program with [`Leiningen`](http://leiningen.org/) through the `lein
run` command. When this is run, Leiningen starts two JVM processes:
one for lein itself, and the other for my code. When I was sending the
`SIGINT` signal, it was being handled by the lein process.

So I ran the rambunctiously named: `lein trampoline run`. "Bye!"

[Read this article about the inner workings of Leiningen's Trampoline.](http://www.flyingmachinestudios.com/programming/lein-trampoline/)
It's fascinating, I swear.

## sonic-sketches: [b9c3989517ef3e756909221771dfcc2a7a5c1a84][removehook]

Later, I removed this code. I originally assumed it was
necessary. *Turns out* that Overtone already has a clean shutdown
mechanism. When I `(use 'overtone.live)` it boots up an internal
SuperCollider server. I thought that I would need to handle its
graceful shutdown myself, but the wise folks at Overtone already
handled that. Deep in the bowels of Overtone's SuperCollider client is
[`defonce _shutdown-hook`](https://github.com/overtone/overtone/blob/master/src/overtone/sc/machinery/server/connection.clj#L386-L392). Clever.

Next week I'll hopefully get to make some sounds.

Bye!<br />- Mark

[shutdownhook]: https://github.com/mwunsch/sonic-sketches/commit/eb53a0d0b2409ebf68dbe8941e8325a359ace8b7

[removehook]: https://github.com/mwunsch/sonic-sketches/commit/b9c3989517ef3e756909221771dfcc2a7a5c1a84
