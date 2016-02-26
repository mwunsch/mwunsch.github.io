---
title: The Programs of the Week of Washington's Birthday
message_id: <o3638o.26wjb9ju8n4vy@markwunsch.com>
---

This Week's Program: Feb 22 - Feb 26
====================================

Even though we celebrated President's Day last week, George Washington
was born on February 22nd. And that is why I've dedicated the subject
line to him.

It was a week that started slow and picked up momentum along the way.

## [71e47a5260b06f9f1758d2df73e0e6998add45cf][overpad]

I bring in another one of Overtone's built-in synths, the "overpad",
which has a cool synthy sound.

## [068aca23bc25cd5e60c23fc9c61e152bdcbbf117][make-song]

Using the primitives I built last week, this is my initial sketch for
composing a "song" based on a bpm and a scale. The channel returned by
the `overpad` is conjoined to the drummachine channels.

## [b06cb60072e4ccbe59cb97de5674d6ec7d323229][main-overpad]

I essentially replicate the above `make-song` function in the `main`
fn. Here's what that sounded like:
[RNG Seed 1456347630950](https://soundcloud.com/mwunsch/sonic-sketch-overpad)

## [99d72678f18de24ea6dd49f4d2655d1032a43665][abstraction]

At this point, I wanted to abstract song creation and generation from
the main function. The main function should be responsible for just
the imperative linear parts of this, and the song generation should be
encapsulated somewhere else.

This patch did several things:

+ In the above SoundCloud clip, you hear a hard cut-off when the song
  ends. I adjusted the `play-sequence` fn to wait one additional
  metronome tick before writing its completion bit.
+ I expanded the function signature of `make-song` to accept more
  variety in composition.
+ I created a function to replay a song from a previous seed.

## [c1b00a29cf369f02db44b8582ed132db3028c20f][gen-song]

Now the problem with the above was that I had that binding to the RNG
seed every which way, and was duplicating lots of functionality. I
consolidated all of that in this patch. `gen-song` takes a seed and
constructs a song from top to bottom. Pass in the same seed, you get
the same song! This combines the `make-song` and `replay-song` fns and
abstracts away all of the previous concerns of the `main` fn.

In addition, I put the Lein project version onto the S3 object's
metadata. A song is a function of its RNG Seed and the version of the
code that produced it.

## [1682cfe72348c2135d523e7a86fb2eb5c4ba11a2][tb303]

I bring back the 303 and have the RNG control its parameters.

The result:
🎵 [Andante C4](https://soundcloud.com/mwunsch/sonic-sketch-andante-c4)

I can then use the same seed, but change the internal parameters eg. I
can choose a faster tempo and a different musical scale. The result is
similar in structure:
🎵 [Allegro D3 Minor](https://soundcloud.com/mwunsch/sonic-sketch-allegro-d3-minor)

Next week, I'll be exploring more of the functionality of `core.async`
to better handle song control flow and will be tweaking the parameters
of song generation.

I would love to hear your feedback this week.

– Mark

[overpad]: https://github.com/mwunsch/sonic-sketches/commit/71e47a5260b06f9f1758d2df73e0e6998add45cf

[make-song]: https://github.com/mwunsch/sonic-sketches/commit/068aca23bc25cd5e60c23fc9c61e152bdcbbf117

[main-overpad]: https://github.com/mwunsch/sonic-sketches/commit/b06cb60072e4ccbe59cb97de5674d6ec7d323229

[abstraction]: https://github.com/mwunsch/sonic-sketches/commit/99d72678f18de24ea6dd49f4d2655d1032a43665

[gen-song]: https://github.com/mwunsch/sonic-sketches/commit/c1b00a29cf369f02db44b8582ed132db3028c20f

[tb303]: https://github.com/mwunsch/sonic-sketches/commit/1682cfe72348c2135d523e7a86fb2eb5c4ba11a2 "Everybody needs a 303"

