---
title: The Programs of the Week the Panama Papers Were Leaked
message_id: <o5bm1t.1mc2xguhyo1fs@markwunsch.com>
---

This Week's Program: Apr 4 - Apr 8
==================================

Weird week on the Internet. Productive week in the repository.

[`sonic-sketches`](https://github.com/mwunsch/sonic-sketches) is
nearing a nice milestone. Let's recap. I wanted to make a a project
where I could…

+ Do something ambitious with the Clojure programming language. More
  ambitious then "Hello, World".
+ Learn to use the Clojure ecosystem at-large: Leiningen, CIDER, etc.
+ Build something that wasn't a web application.

`sonic-sketches` became that project where I could do the above and
also work within a domain I hadn't really ever explored before:
music. As the project grew and expanded it went from an exercise in
learning [Overtone](http://overtone.github.io/) to the creation of an
automated Bot that generated musical compositions.

Now, `sonic-sketches` produces a procedurally generated piece of music
based on the day's weather.

This week I put the "final" (nothing is final) touches on the song
generation algorithm. Next week I'm going to focus on automating the
bot: making it run at regular daily intervals without my involvement.

Here's this week's code.

## [96324d8387652758d1543fdf16314cdd8ce5ca58][precip-prob]

From the Forecast API, I pull in three more data points: the
probability of precipitation, the intensity of precipitation (in
inches per hour), and the cloud coverage. I normalize these (for
instance, making `cloudy` a boolean) and then map them to different
intervals and music modes.

If the probability of precipitation is greater than 50%, heavy
precipitation will make the song a
[minor](https://en.wikipedia.org/wiki/Minor_scale) scale. Medium
precipitation will make the song
[minor pentatonic](https://en.wikipedia.org/wiki/Pentatonic_scale#Minor_pentatonic_scale),
and a light drizzle will choose the
[harmonic minor](https://en.wikipedia.org/wiki/Minor_scale#Harmonic_minor_scale)
scale. I'm new to this music theory thing, but it is my feeling that
those scales evoke the mood of a rainy day. If it's not going to rain
but it's cloudy outside, the song will be in the
[Lydian scale](https://en.wikipedia.org/wiki/Lydian_mode) which I
think suggests something otherwordly or supernatural. If it's a clear
sunny day, we'll hear the
[major scale](https://en.wikipedia.org/wiki/Major_scale).

Last week we used the day's temperature to determine the pitch of the
song and now we use precipitation to choose the scale of the
song. With that, I feel like song generation is mostly complete for
now.

## [28554e7b139693f26f9f3fe31b60249f23d91f40][play-generated-song]

One of the things I was doing in the REPL all the time was writing out
this little piece of code:

    (let [t (now)
          weather (:daily (:body (forecast/nyc-at t)))]
      (gen-song t (:data weather)))

I could change the value of `t` to replay a previously played seed. I
decided to formalize this in the codebase and now I have a handly
function to replay previously generated songs or generate a new one on
demand. The difference between `play-generated-song` and `gen-song` is
that the former will always make a request out to the Forecast API
whereas the latter will just randomly generate values if the Forecast
data is not provided.

## [efe9607fc73b4fdd54fe95cdf71f2f36bf104894][day-of-week]

Here I wrangle out the day of the week from the RNG seed to use that
as the first part of the song's filename. I could have used
[`clj-time`](https://github.com/clj-time/clj-time) here but I just
preferred not to pull in the external dependency. This is the Java way
of doing things. I don't think I ever want to do Java outside of
Clojure again. I much prefer working with Java in the context of
Clojure. Later I move this into its own function.

## [fedac58e8cef07e7cc38aa91177cf16167e5070c][half-notes]

Back in song generation, I adjust the lead line (the 303) to play half
notes and adjust the sequencing to account for that. I set the
*resonance* control of the 303 to a random value. When generating the
notes to play from the scale, I also randomly generate a value for the
*cutoff* control of the 303's lowpass filter for every note. This is
like if you were to play a 303 line and just wiggle the knob as the
sequence plays. It sounds more like a 303.

Here's the song generated for today,
[**Friday April 8**][friday-8122984298179943942].

The song plays at a moderate 96 bpm because the moon is slightly waxing
crescent. The temperature today averages 45° and it's clear outside
so the song is in the key of E3 Major.

If you're a musician or fan of music, I would love to know what
feelings different keys and scales evoke for you.

🌚 Mark

[precip-prob]: https://github.com/mwunsch/sonic-sketches/commit/96324d8387652758d1543fdf16314cdd8ce5ca58

[play-generated-song]: https://github.com/mwunsch/sonic-sketches/commit/28554e7b139693f26f9f3fe31b60249f23d91f40

[day-of-week]: https://github.com/mwunsch/sonic-sketches/commit/efe9607fc73b4fdd54fe95cdf71f2f36bf104894

[half-notes]: https://github.com/mwunsch/sonic-sketches/commit/fedac58e8cef07e7cc38aa91177cf16167e5070c

[friday-8122984298179943942]: https://soundcloud.com/mwunsch/sonic-sketch-friday-8122984298179943942

