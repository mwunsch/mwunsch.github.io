---
title: The Programs of the Last Week of 2015
---

This Week's Program: Dec 28 - Jan 1 2016
========================================

🎆 **Happy New Year!** 🎆

Last week I hastily reviewed my code in 2015. Now I'd like to hastily
review the code I would like to write in the coming year. I approach
projects by the programming language or paradigm I'd like to explore,
using the features of the language to better understand certain
domains and using my curiosity of certain domains to justify
experimenting with certain languages.

## In 2015 I Did

+ **Emacs Lisp**
+ **Clojure**

2015 was a big year for me and parentheses. Lisps, in all their
incarnations, are glorious and anybody who makes parentheses jokes
instead of [learning a Lisp][brave-and-true] is a thirsty
sonofabitch. 2015 is the deepest I've dived into Clojure and it is a
good language. One that I hope to continue to use for general purpose
programming. Making the switch to Emacs was a good decision.

[brave-and-true]: http://www.braveclojure.com/

## In 2016 I Will

+ [**Elm**](http://elm-lang.org/). I found Elm when first learning
  about [Functional Reactive Programming][frp]. It's fascinating. Its
  [architecture][elm-architecture] influences this whole new wave of
  UI libraries and frameworks. The next project I have in mind
  following the Overtone work is a game. Elm is the language to build
  it in.
+ [**Rust**](https://www.rust-lang.org/). I've never really done much
  systems programming but Rust makes me eager to try it. I
  [dabbled][wwwfinger] in the language before it stabilized and I
  loved it. Can't wait to try it again now that it's matured.
+ [**Racket**](http://racket-lang.org/). Clearly I'm fascinated by
  Lisps. Racket's focus is programming pedagogy: a language designed
  for making languages. Plus John Carmack thinks it's cool. (Don't
  come at me about the difference between Scheme and Lisp.)
+ [**Elixir**](http://elixir-lang.org/). I want to write a web
  application in Elixir.
+ [**Haskell**](https://www.haskell.org/). Haskell is the best
  programming language. It is my ticket to coolsville.
+ [**ClojureScript**](https://github.com/clojure/clojurescript). Same
  great language, new host runtime. The tooling for ClojureScript
  looks remarkable. See David Nolen's
  [*ClojureScript Year In Review*][clojurescript].

This is an ambitious list. I do not expect to complete these
explorations by 2017, but I'm going to give it my all.

[frp]: https://pinboard.in/u:mwunsch/t:frp

[elm-architecture]: https://github.com/evancz/elm-architecture-tutorial/

[wwwfinger]: https://github.com/mwunsch/wwwfinger

[clojurescript]: http://swannodette.github.io/2015/12/23/year-in-review/

## In 2016 I Might

+ [**Swift**](https://swift.org/). Mac and iOS development is
  tantalizing, especially now with a thoughtfully designed, modern
  language. I don't think Apple is going anywhere; I've held off for
  this long. Would be fun though, and, more than the other languages,
  would pad my résumé.
+ [**Pharo**](http://pharo.org/). I've never tried Smalltalk before. I
  have a hunch I would appreciate it.
+ [**Go**](https://golang.org/). Doesn't excite me much, but I get why
  it's an increasingly popular for service development. Résumé
  padding. I think a good choice for exploring the email domain.

## In 2016 I Won't

+ A language for data science. Something like **R**, **Julia** or even
  **Python**. I own a license for **Mathematica**, and I think it's a
  really cool environment but this is not a domain I'm going to be
  focusing on in 2016.
+ A logic or concatenative programming language. **Prolog** is really
  compelling, but with
  [core.logic](https://github.com/clojure/core.logic) I've temporarily
  scratched this itch. I'd like to revisit Prolog in 2017. Same for
  [**Mozart-Oz**](http://mozart.github.io/), which I know very little
  about. [**Factor**](http://factorcode.org/) looks cool.
+ [**Lua**](http://www.lua.org/) or
  [**Io**](http://iolanguage.org/). Distant cousins of
  JavaScript. With ECMAScript 6 (er, ES2015?)  looming large I don't
  think I'll be able to make time for these.

On to the code I wrote in the last week of 2015…

## How to Make a Noise: Envelopes

A couple of weeks ago I wrote about the basics of sound synthesis
starting with oscillators. When an instrument is played, depending on
how it is plucked or struck or blown, the quality of the sound changes
over time. In sound synthesis, an *envelope generator* controls a
parameter of the sound over time. The most common of these is an
*ADSR* envelope: Attack Decay Sustain Release. The envelope describes
the arc the instrument takes when the note is first triggered (the
Attack), the drop off from that burst (the Decay) to what level it
holds at (the Sustain), and how long the instrument takes to returns
to zero once the note is no longer held (the Release). When used to
control amplitude, the envelope describes the volume of the sound over
the duration of how long a note is played.

## [d5126e9e4b2f5f49a46d1f0a85591567d4fcab73][tb303-envelope]

In this commit, I change the parameters of the ADSR envelope to make
the tb303 sound a bit closer to what I want. I'm just using my ears;
the numbers are totally arbitrary. Both in this and last week's
*Jingle Bells* I use the duration of the note to control how long the
sound should decay. If you look at the
[implementation](https://github.com/overtone/overtone/blob/master/src/overtone/inst/synth.clj#L85-L109)
of the tb303, you can see the `env-gen` and `adsr` functions used.

## [b6ed35d4ded000c1458f71dbbfa1bf40c80ee789][finished-playing]

I wrap the entire body of my play function in an [`if-let`][if-let]
and when all the notes have been played, I trigger a
`::finished-playing` event on the next beat. I pass in the metronome
to the event, just in case I want to pick something up where I left
off.

## [29880fc68174cccc3ac935269e8e3dc02d2c72bd][recording-complete]

In the main function of the application, I start a recording that
stops when that `::finished-playing` event comes in. Lots more to come
in this particular area of the code. I'm eyeballing
[core.async](https://github.com/clojure/core.async) for exploration
next week. Check out that `when-let`, also. I'm getting more
comfortable exploring Clojure's API and using more of its forms.

## [9f7269adf0d159d260ccf512276323dd8ac01de0][piano]

I swap out the funky tb303 for a classy synthesized piano. Comes stock
in Overtone.

## [1fecb167e66030ceeba0fdd82054ef89eaa64394][doseq]

I change the `:pitch` parameter of the note to `:chord` representing a
sequence of pitches. I use `doseq` to play them simultaneously.

## [6eeae748f7452d302ae77a9e33bb802652728841][concat]

Here's the finished melody using chords. I'm modeling the left hand
and right hand on a piano, or the bass and treble clefs, as two
sequences and then I `concat` them together.

I've started learning a bit of music theory. I recommend the
[*Fundamentals of Music Theory*](https://www.coursera.org/course/musictheory)
course on Coursera and
[musictheory.net](http://www.musictheory.net/).

## [9e8be2085c1fcafeb7e7f934020950e204b60262][timing]

With last week's Jingle Bells exercise, I was doing timing all
wrong. This song is in 4/4 time. The bottom 4 describes that one beat
is the equivalent of a quarter note. I adjust the duration parameter
to be the coefficient of one beat. Then, instead of relying on the
metronome for scheduling, I derive how long a beat on the metronome is
in milliseconds multiplied by the duration coefficient and schedule
the next call of the function to happen at that point in the
future. Note the distinction between `apply-by` and `apply-at`. The
former is ahead-of-time function scheduling.

And here's my New Year's gift to you:
[**Auld Lang Syne**](https://soundcloud.com/mwunsch/sonic-sketch-auld-lang-syne)

Wishing you the best in 2016,<br />
🎊 Mark

[tb303-envelope]: https://github.com/mwunsch/sonic-sketches/commit/d5126e9e4b2f5f49a46d1f0a85591567d4fcab73

[finished-playing]: https://github.com/mwunsch/sonic-sketches/commit/b6ed35d4ded000c1458f71dbbfa1bf40c80ee789

[if-let]: http://clojuredocs.org/clojure.core/if-let

[recording-complete]: https://github.com/mwunsch/sonic-sketches/commit/29880fc68174cccc3ac935269e8e3dc02d2c72bd

[piano]: https://github.com/mwunsch/sonic-sketches/commit/9f7269adf0d159d260ccf512276323dd8ac01de0

[doseq]: https://github.com/mwunsch/sonic-sketches/commit/1fecb167e66030ceeba0fdd82054ef89eaa64394

[concat]: https://github.com/mwunsch/sonic-sketches/commit/6eeae748f7452d302ae77a9e33bb802652728841

[timing]: https://github.com/mwunsch/sonic-sketches/commit/9e8be2085c1fcafeb7e7f934020950e204b60262
