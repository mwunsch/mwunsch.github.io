---
title: The Programs of the Week the Groundhog Predicted Spring
message_id: "<o23xcs.2vol9p1zi6ly3@markwunsch.com>"
---

This Week's Program: Feb 1 - Feb 5
==================================

Late edition newsletter. It's been a hectic day. This week,
inspiration struck. Let's look at code.

## [4ef1a585fe3f257304fe5ef579f4a8ca0eec218f][remove-forecast]

I remove the client to the Dark Sky Forecast API. Was getting
compilation errors. Unsure if related to the (dependency-heavy) client
or if I just needed to bump the `amazonica` lib. Will revisit this later.

## [908817f2a7432e73a74c5bcd0766c19edb530943][step-sequencer]

I bring in some pre-defined drum synths and take a crack at making a
[step sequencer](https://en.wikipedia.org/wiki/Music_sequencer#Step_sequencers). Given
a list of instruments and a sequence of instructions (a vector of 1's
and 0's), process the instructions at the ticks of a metronome. My
first pass at real algorithmic composition. In the fn description, I
describe an 8-step sequencer and the steps are generated
[lazily](https://en.wikipedia.org/wiki/Lazy_evaluation) and randomly.

    (repeatedly 8 #(choose [0 1]))

## [80e1702e6449ee190eb79ae1a0d10df17046b7a7][drummachine]

Flash forward: I've got a drummachine. `rand-drumsequence` makes a
16-step sequence for a list of drums. `loop-sequence` updates that
sequence to make it loop *n* times. The `drummachine` takes a
metronome and a sequence and multiplexes each instrument/sequence pair
onto the `step-sequencer` function that schedules playing on
SuperCollider. I also create a basic
[four-on-the-floor](https://en.wikipedia.org/wiki/Four_on_the_floor_(music))
rhythm.

## [0b90ef104eec4837cccf3fbde43d50b5f673d153][cycle-sequence]

I add another helper function that will loop the drum sequence
infinitely.

## [c9cfa3c51816c32995eb65face41985747bc4589][rng]

I pull in the
[`data.generators`](https://github.com/clojure/data.generators/)
library to use a stateful
[Random Number Generator](https://en.wikipedia.org/wiki/Random_number_generation). Will
describe its usage next week.

Incredible week for learning both musical and functional
composition. Using `update-in`, list comprehensions, lazy evaluation…
it feels like I finally have a grasp on idiomatic Clojure usage (but
not quite idiomatic Overtone usage). I'm super pleased with the
progress made this week. Here's 8 bars of a randomly generated drum
machine sequence:

    (drummachine (metronome 96) (-> [drums/dry-kick
                                     drums/tone-snare
                                     drums/closed-hat
                                     drums/snare2
                                     drums/open-hat]
                                     rand-drumsequence
                                     (loop-sequence 8)))

The result:
[soundcloud.com/mwunsch/sonic-sketch-random-drummachine](https://soundcloud.com/mwunsch/sonic-sketch-random-drummachine)

🎧 Mark

[remove-forecast]: https://github.com/mwunsch/sonic-sketches/commit/4ef1a585fe3f257304fe5ef579f4a8ca0eec218f

[step-sequencer]: https://github.com/mwunsch/sonic-sketches/commit/908817f2a7432e73a74c5bcd0766c19edb530943

[drummachine]: https://github.com/mwunsch/sonic-sketches/commit/80e1702e6449ee190eb79ae1a0d10df17046b7a7 "Make a drummachine"

[cycle-sequence]: https://github.com/mwunsch/sonic-sketches/commit/0b90ef104eec4837cccf3fbde43d50b5f673d153 "infinitely looping sequence"

[rng]: https://github.com/mwunsch/sonic-sketches/commit/c9cfa3c51816c32995eb65face41985747bc4589 "clojure.data.generators RNG"
