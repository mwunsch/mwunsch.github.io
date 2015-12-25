---
title: The Programs of Christmas Week
message_id: "<nzxgnb.1oriid4r645d1@markwunsch.com>"
---

This Week's Program: Dec 20 - Dec 25
====================================

Merry Christmas! 🎄

Thank you for taking time away from your loved ones to spend time with
your other loved one: Me.

## 2015 in Review

2015 is the year I launched *This Week's Program*, a weekly newsletter
where I highlight code I've written over the course of the week.

2015 is the year I started a streak of committing code out in the open
every weekday.

This was my second year as an engineering director at
[Rent the Runway](https://www.renttherunway.com/). My team focused on
building up a new foundation for our web application using
[React](https://facebook.github.io/react/),
[Redux](http://redux.js.org/), and
[JSON API](http://jsonapi.org/). They've done some outstanding work
and, as their manager, I have no problem taking partial credit. Those
are technologies I'm really excited about. I've dabbled a bit
in dev ops land with [Vagrant](https://www.vagrantup.com/),
[Ansible](http://www.ansible.com/), and
[Packer](https://www.packer.io/). I open-sourced a Git-powered feature
flag system called
[Flaggrocrag](https://github.com/renttherunway/flaggrocrag). I spoke
at [Empire JS](https://www.youtube.com/watch?v=3DY3YHZKanY) about the
DOM and Zippers.

In 2015 I used [Docker](https://www.docker.com/) for the first time to
mess with Google's
[Deep Dream](http://googleresearch.blogspot.com/2015/07/deepdream-code-example-for-visualizing.html)
and to use [Let's Encrypt](https://letsencrypt.org/).

I officially handed over maintenance of
[Handlebars.scala](https://github.com/mwunsch/handlebars.scala/issues/52). I
think I wrote zero **Scala** in all of 2015.

I set up a [POSSE](https://indiewebcamp.com/POSSE) system so that I
publish to Tumblr and Tinyletter from my website. I wrote about it in
previous editions of this newsletter.

In 2015 I started using
[Emacs](http://blog.markwunsch.com/post/131698116610/emacs) as my
primary text editor.

In 2015 I decided to go deep into **Clojure** and am learning how to
use Overtone.

There's a lot more to say about 2015.

## [704d4f31c4a1d23745cc9a627ceccbae6aa5f959][note-vector]

The Monotron from last week was very cool, but had no
[envelope](https://en.wikipedia.org/wiki/Synthesizer#ADSR_envelope),
which is another important function in making noise. Basically, I
couldn't specify a duration for how long the monotron should run. In
this commit, I've changed my `play` function to accept a sequence of
notes. A note is a structure that has a `:pitch` and a
`:duration`. The duration is a coefficient to the length of time a
beat lasts. The fast the bpm, the shorter the duration. In this way I
can represent things like *quarter notes* and *half notes* as seen in
musical notation. I use recursive forms like `first` and `rest` to
move down the the list.

## [3b659cd5e995c22c8309516e8c77faa79cf5dcb6][note-destructure]

Clojure's [Destructuring][destructuring] is powerful and awesome.

## [62763e354b8668278990fb73c3fe9633182ec2f0][tb303]

I bring in a new instrument. Overtone has a built-in `tb303` which I
assume is meant to mimic the
[Roland TB-303](https://en.wikipedia.org/wiki/Roland_TB-303). After
some experiments in the REPL. I make it play
[Jingle Bells](https://soundcloud.com/mwunsch/sonic-sketch-jingle-bells).

## [5f5419099d57aef14c7499d5f696a0e17f31fe26][jingle-bells]

My original Jingle Bells didn't sound quite right. My wife helped me
figure out the timing for small rests to make it sound more like
Jingle Bells ought to sound. To represent the rests, I pass `nil` as
the pitch in the note.

    (play (metronome 220) jingle-bells)

[It's a Christmas miracle!](https://soundcloud.com/mwunsch/sonic-sketch-jingle-bells-2)

I am *#blessed* to have a fantastic partner that listens to bleeps and
bloops coming out of my computer over and over again and helps me get
them to sound right and is patient when I take some time out of
Christmas day to write my Tinyletter.

Thank **you** for reading my writing and my code in 2015.

🎅 Mark

[note-vector]: https://github.com/mwunsch/sonic-sketches/commit/704d4f31c4a1d23745cc9a627ceccbae6aa5f959

[note-destructure]: https://github.com/mwunsch/sonic-sketches/commit/3b659cd5e995c22c8309516e8c77faa79cf5dcb6

[destructuring]: http://clojure.org/special_forms#Special Forms--Binding Forms (Destructuring)

[tb303]: https://github.com/mwunsch/sonic-sketches/commit/62763e354b8668278990fb73c3fe9633182ec2f0

[jingle-bells]: https://github.com/mwunsch/sonic-sketches/commit/5f5419099d57aef14c7499d5f696a0e17f31fe26
