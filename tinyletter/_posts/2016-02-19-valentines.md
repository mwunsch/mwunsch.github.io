---
title: The Programs of the Week of Valentine's Day
message_id: "<o2t61s.54egta908g9z@markwunsch.com>"
---

This Week's Program: Feb 15 - Feb 19
====================================

No time to shmooze, let's get right to it.

## [4e9d63a174265cd3387d722ade6a266e24f64b28][note-sequencer]

I build up another step-sequencer, this one called
`note-sequencer`. This sequencer has the same method signature, but
the `pulses` here should be a sequence of vectors with key-value
pairs. On each metronome tick, that vector will be applied to the
instrument (via `apply` naturally). This means I can set up an
instrument with certain parameters already set and use
[`partial`](https://clojuredocs.org/clojure.core/partial) to delay
execution. For non-percussive instruments, this allows me to model
melodies similar to how I model the drummachine.

## [4520f26ccc2f17eaf4b49bd9d30d520333bb9df1][rand-notesequence]

Here's a simple function, similar to rand-drumsequence, that creates a
random sequence suitable for the note-sequencer.

## [cabc8775857aa5434e83bcd7aa90abdc031a9c44][play-sequence]

The natural thing to do from the note-sequencer is to create an
abstraction that both note-sequencer and step-sequencer can
use. That's what this function `play-sequence` does. It takes a
metronome, a sequence, a lambda, and a (later made optional)
predicate. When the metronome ticks, the lambda is called with the
next step in the sequence when the predicate matches. However, instead
of using the traditional temporal recursion model favored by Overtone,
I chose to lean in hard on `core.async`. I'm using `go-loop` to wrap a
loop in a go thread. The sequence is now an async channel. Channels
can easily be created from sequences with
[`to-chan`](https://clojuredocs.org/clojure.core.async/to-chan). A
step is read off the channel and then the thread "sleeps" (using the
`timeout` channel) for a metronome tick. Once the input channel is
closed, the loop exits. This feels pretty slick: no scheduling is
needed.

## [6fd169ffc68f524bcce21dd4792f76ae0a8f5cda][abstract-sequence]

I update the `step-sequencer` and `note-sequencer` functions to use
this new `play-sequence` abstraction. Their API's don't change at
all. That's re-*fun*-ctoring.

## [3911eaa342b306c61d0571a56f2b8b4b4bd2af7e][clock-signal]

One of the downsides to the above approach is I lose the ability to
use `(stop)` to stop all scheduling and music players. I decided that
the best way to tell a sequencer to halt is to cut off it's
metronome. Instead of using the metronome as is traditional, I create
a [*clock signal*](https://en.wikipedia.org/wiki/Clock_signal) similar
to how you would see this in traditional analog modular
synthesis. This clock signal is an abstraction of the timeout
mechanism from `play-sequence`. Every metronome beat, a message is
sent into the channel. Back in `play-sequence`, the loop there reads
from this channel and awaits the message (which happens to be the
metronome itself). If I close the clock channel, the sequencer will
stop execution.

Now **that's** how you `core.async`. I feel like a concurrency
wizard. See you next week!

💝 Mark


[note-sequencer]: https://github.com/mwunsch/sonic-sketches/commit/4e9d63a174265cd3387d722ade6a266e24f64b28 "note-sequencer"

[rand-notesequence]: https://github.com/mwunsch/sonic-sketches/commit/4520f26ccc2f17eaf4b49bd9d30d520333bb9df1 "random note sequence"

[play-sequence]: https://github.com/mwunsch/sonic-sketches/commit/cabc8775857aa5434e83bcd7aa90abdc031a9c44 "abstract sequencer"

[abstract-sequence]: https://github.com/mwunsch/sonic-sketches/commit/6fd169ffc68f524bcce21dd4792f76ae0a8f5cda "refactoring sequencers"

[clock-signal]: https://github.com/mwunsch/sonic-sketches/commit/3911eaa342b306c61d0571a56f2b8b4b4bd2af7e "using a clock signal"
