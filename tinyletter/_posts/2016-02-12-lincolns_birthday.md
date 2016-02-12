---
title: The Programs of the Week of Lincoln's Birthday
message_id: "<o2fz4k.2vorkebma7k5x@markwunsch.com>"
---

This Week's Program: Feb 8 - Feb 12
===================================

Another heads-down, focused week; which are the best weeks. This
newsletter suffers when I have really good coding weeks because my
mind is focused there and not on writing effusive, witty prose.

I'm slowly (*slowly*) making my way through a great book:
[*10 PRINT CHR$(205.5+RND(1)); : GOTO 10*](http://www.amazon.com/10-PRINT-CHR-205-5-RND/dp/0262526743/),
or just *10 PRINT* for short. It's a dense, somewhat academic,
fascinating examination of this **BASIC** one-liner as a, as Amazon
says:

> as a lens through which to consider the phenomenon of creative
> computing and the way computer programs exist in culture.

I've been inspired by it in a lot of ways, and have begun posting
explorations on its themes using **Processing** to my
[Instagram](https://www.instagram.com/mwunsch/) account. Follow me
there to see my progress with generative art and creative
coding. Throughout the coming weeks I'll discuss more of that in this
Tinyletter. For now it feels very ad hoc and experimental.

The other thing that *10 PRINT* has inspired, along with some of what
I'm doing in sonic-sketches, is a lot of *random* thoughts. I mean I'm
thinking a lot about Randomness as a theme in computers. Some great
conferences are coming up, and I've drafted up an abstract I intend to
send out to some CFP's. I'd love your feedback on it:
[*A Survey of Pseudorandomness*](https://gist.github.com/mwunsch/647d763e1ce91bfef7d2). I
think it could be a good talk. Reply to this email or comment on the
gist with your thoughts and comments.

## [344f753c9a510dcdf8f95833d7f520b36a45e563][rnd-binding]

At the end of last week, I pulled in the Clojure `data.generators`
library. This week I use the
[`binding`](http://clojuredocs.org/clojure.core/binding) function to
bind the dynamic, stateful `*rnd*` var to a seed (the current
timestamp). There was some trial and error here in learning about how
`binding` works. Thankfully there's this great blog post by Chas
Emerick:
[*Be Mindful of Clojure's `binding`*](http://cemerick.com/2009/11/03/be-mindful-of-clojures-binding/)
that talks through some of the traps.

With this code, I can take the previous seed and use it to replay a
previously generated sequence.

## [6b85e24015b009e9540aa9106d16afde8ae622df][tempo-map]

Here's a map of Italian words to ranges of BPM.

## [f92c8d7a8ded7bbb361d402678e0431740071998][rand-metronome]

Given an Italian word, generate a metronome by randomly choosing a BPM
within its range.

## [d16ad609fede73d6efb52a482a2c8d5fb5018780][rand-percussion]

Here was a tricky piece of code. I wanted to randomly choose a subset
of drums from the total percussion selection. Inside the
`overtone.inst.drum` namespace is a bunch of Overtone instruments. I
wanted to draw from all of those without stating exactly the
instruments I needed. Thanks to the denizens of the
[Clojurians](http://clojurians.net/) Slack, I found the
[`ns-aliases`](https://clojuredocs.org/clojure.core/ns-aliases)
function. Using this, I could wrangle out all of the percussion synths
that Overtone has pre-defined.

Six seems like a good number for a drum set, I think. It sounds okay.

## [5deea44a311d1f06551b4837c5f12b23fea73c1e][s3-metadata]

Here I attach the RNG
[seed](https://en.wikipedia.org/wiki/Random_seed) and the BPM to the
metadata of the song when I upload it to S3. So anything that the
program uploads to S3 can be reproduced locally by getting that
object's seed out of its metadata.

This is also one of my first times using Clojure's *rest
parameters*. That `apply hash-map` seems idiomatic, but I'm not sure.

## [808e0cc3cb6fd180061b6a10055156e32c2691ba][loop-sequence]

I loop the drum sequence for 8 bars. I am pleased with the drummachine
API. Good job, me.

Good job *you* for making it to the end of this week and to the end of
this newsletter. Have a happy Valentine's Day weekend.

🎲 Mark

[rnd-binding]: https://github.com/mwunsch/sonic-sketches/commit/344f753c9a510dcdf8f95833d7f520b36a45e563 "Dynamically binding the seed for an RNG"

[tempo-map]: https://github.com/mwunsch/sonic-sketches/commit/6b85e24015b009e9540aa9106d16afde8ae622df "A map of Italian words to BPM ranges"

[rand-metronome]: https://github.com/mwunsch/sonic-sketches/commit/f92c8d7a8ded7bbb361d402678e0431740071998 "Choose a random BPM from a tempo"

[rand-percussion]: https://github.com/mwunsch/sonic-sketches/commit/d16ad609fede73d6efb52a482a2c8d5fb5018780 "Choose from a list of drums"

[s3-metadata]: https://github.com/mwunsch/sonic-sketches/commit/5deea44a311d1f06551b4837c5f12b23fea73c1e "Add user metadata to s3 object upload"

[loop-sequence]: https://github.com/mwunsch/sonic-sketches/commit/808e0cc3cb6fd180061b6a10055156e32c2691ba "Loop sequence for 8 bars"
