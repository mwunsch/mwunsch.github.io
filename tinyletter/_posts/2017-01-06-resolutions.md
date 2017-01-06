---
title: The Programs of the First Week of 2017
message_id: <ojdady.1ktzwvfk1utow@markwunsch.com>
---

This Week's Program: Jan 2 - Jan 6
==================================

We made it fam. We completed 2016. It was a challenging year. We're
one week into 2017 and I am feeling _resolved_. [Last year][last-year]
I wrote out the things that I was hoping to accomplish and the things
that I would be putting aside in the year ahead.

> I approach projects by the programming language or paradigm I'd like
> to explore, using the features of the language to better understand
> certain domains and using my curiosity of certain domains to justify
> experimenting with certain languages.

Here are the languages and domains I'd like to explore in 2017.

[last-year]: http://www.markwunsch.com/tinyletter/2016/01/last_week.html

## In 2016 I Did

+ **Clojure**
+ **Amazon Web Services**
+ **Elm**
+ **FreeBSD**

The Clojure came over from 2015 and
the [`sonic-sketches`](https://github.com/mwunsch/sonic-sketches)
project. 2015 was a big year for me and Lisps and 2016 was a big year
for me and functional programming more broadly. The big chore of the
year was getting sonic-sketches, and its bespoke system needs, running
in AWS. I used the occasion to get comfortable with AWS, beyond just
stuffing things in S3 and running webapps in EC2. I worked to
understand how to use the AWS ecosystem holistically. It was really
challenging and I found myself fighting against Linux all to
frequently. I learned a huge amount about productionizing complex
systems and building dead-simple continuous delivery pipelines with
*CloudFormation* and *CodeDeploy*. I have to recommend
the [*Amazon Web Services in Action*][aws-in-action] book (also
on [DHH's 2016 reading list][dhh-reading] fwiw). I haven't finished
the book, but I got enough out of the first few chapters and hopping
around to make me feel so much more comfortable approaching _the
cloud_.

**Elm** was the first language in my 2016 list. I spent the second
half of the year really focused on learning it and trying to build
something that matched its model. I really enjoyed working with Elm,
and I'll be doing a longer retrospective on [`hive-city`][hive-city]
next week (stay tuned). The biggest inspiration from working on
`hive-city` was learning first-hand how interesting and complex game
development is. I always knew but now I _know_. Game development is
something I'll be focusing a lot of energy and attention on
in 2017. I'm not a big gamer, but the amount of considerations and
scope that go into game development bring all of my skill and
experience to bear.

Last year I had a long ambitious list of languages to work in:
**Elm**, Rust, Racket, Elixir, Haskell, ClojureScript. I really only
got to work in one. It's a bit dissapointing but If I can immerse
myself in one programming language a year I'd still say that's a win.

[aws-in-action]: https://www.manning.com/books/amazon-web-services-in-action

[dhh-reading]: https://m.signalvnoise.com/the-books-i-read-in-2016-6ee02fa7fb82#.346sv6idg

[hive-city]: https://github.com/mwunsch/hive-city

## In 2017 I Will

+ [**Racket**](https://racket-lang.org). My next project will be
  written in Racket. I loved working in Elm and its ML-style, but I
  can no longer resist the parentheses' call. Things
  like [Hackett](https://github.com/lexi-lambda/hackett) and a
  [*Paper's We Love*][pwl] meetup I attended this year have convinced me that
  this language designer's language is one that I really want to
  explore.
+ [**Unity**](https://unity3d.com). My brief encounter with game
  development triggered all of my curiosity and creativity and I want
  to explore this domain more and Unity seems like the tool of choice
  for a lot of very smart, talented people. I like using the same
  tools as smart, talented people because it gives me (and maybe
  others) the illusion that I am smart and talented (see _Emacs_).
+ [**D3**](https://d3js.org). D3 has become the go-to tool for data
  visualization. I haven't really done any dataviz stuff in the past,
  and never really sought out opportunities to experiment with it. My
  wife's studies in data analytics and her enthusiasm have tipped me over
  the edge. I'm excited to add this to my repertoire.
+ [**Elixir**](http://elixir-lang.org). This seems like the thing to
  write web applications in. If I ever got around to writing a backend
  for `hive-city` it would have been in Elixir.

[pwl]: https://www.meetup.com/papers-we-love/events/233240967/

## In 2017 I Might

+ [**Rust**](https://www.rust-lang.org/en-US/). The systems
  programming language has moved from 2016's "I Will" list to 2017's
  "I Might" list. It's the language I'm most intellectually curious
  about.
+ [**Lua**](https://www.lua.org). This was on 2016's "I Won't"
  list. Now I might. The driving force? Interest
  in [PICO-8](http://www.lexaloffle.com/pico-8.php).
+ [**Swift**](https://swift.org). It's hard to resist the siren's call
  of iOS development, especially when my iPad is my favorite
  computer.

## In 2017 I Won't

+ [**Pharo**](http://pharo.org). Moved from 2016's "I Might" list. I
  won't be scratching my Smalltalk itch.
+ [**Go**](https://golang.org). Moved from 2016's "I Might" list. Go
  is a language that I think would look good on my résumé. It's hard
  to get excited about it.
+ [**ClojureScript**](https://clojurescript.org). This was on 2016's
  "I Will" list. I won't. I think it's awesome, I think the ecosystem
  is shaping up to be brilliant. I really like Clojure. I just am up
  to my eyeballs in web libraries and frameworks. Elm satisfied my
  desire for a better web language for now.
+ [**PureScript**](http://www.purescript.org). cf. ClojureScript. It's
  on my radar.
+ [**Haskell**](https://www.haskell.org). My white whale. 2018 will be
  its year.
+ [**Prolog**](http://www.swi-prolog.org). Still cool. My body is not
  ready.

On to the code I wrote in the first week of 2017. I took Monday off.

## [c23dc9ef20cfa158733a7d6943e6fb20d15b9406][publish-to-medium]

In 2017 I will write at least one *think piece*. A long-form blog
post. My true ambition is to be a thought leader and this code thing
is just a windy path to get there. [Medium](https://medium.com) is the
natural medium of the think piece. I can't just _write_ to Medium
though. I have to do it my way. By hooking up a Jekyll plugin that's
triggered on builds that publishes the markdown I write in the
`thinkpiece` category to
the [Medium API](https://developers.medium.com), naturally.

My first think piece will be a retrospective on working with Elm and
building `hive-city`.

## [08528f7199012c2989135c63ada0a7191beff544][animation]

I add animation to `hive-city` using
the
[`elm-style-animation`](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/latest) package. I
watched a lightning talk
by [Matthew Griffith](https://www.youtube.com/watch?v=DsDwYqsLU3E),
the package's creator from Elm Conf and after evaluating some
different options, this seemed like the most straightfroward to
integrate. Every `Model` now has a `transition` property that
represents an Animation state of the Model's position on the board. In
the Model's `attemptMove` function, not only do I update the Model's
`position` property, I also update the Animation state to move to the
new position. Back in the `Campaign` module, I rig up the
`Animation.subscription` Sub which triggers the `Transition` Msg
whenever the Model's animation state calls to change. This Transition
Msg calls `Animation.update` which moves to the next step in the
animation sequence. Now when a `Model` moves, they animate to the next
position.

Look for an animated gif in the aforementioned upcoming think piece.

## [bedd5c060db58edd7cc4307314a03668ced968ef][diceroll]

I add back the `DiceRoll` control that existed in the previous version
of the game and rig up the `Action.Shoot` Command logic to set up the
shooting dice roll. This logic feels a bit easier to wrangle now that
I have more comfort working wih `Maybe.map` and associated functions.

## [06ae5cad0f94d7bade151e7504db68bca5845266][projectile]

I introduce a new module, `Projectile`. This is a simple module that
just draws a green line from one position to another. The trick here
is that it uses the previously incorporated `Animation` library and
`Projectile.travel` will rig up an animation that lets that line shoot
across the tabletop. I have it hooked up to run the animation whenever
the shooting action is `Complete`, but I think I might try to move
that later.

This could very well be my last commit on `hive-city`. I'll be
abandoning this project soon, but we'll see what next week brings.

I'd love to hear about what projects _you'd_ like to embark on in
2017.

Let's learn together this year,<br />
🤗 Mark

[publish-to-medium]: https://github.com/mwunsch/mwunsch.github.io/commit/c23dc9ef20cfa158733a7d6943e6fb20d15b9406

[animation]: https://github.com/mwunsch/hive-city/commit/08528f7199012c2989135c63ada0a7191beff544

[diceroll]: https://github.com/mwunsch/hive-city/commit/bedd5c060db58edd7cc4307314a03668ced968ef

[projectile]: https://github.com/mwunsch/hive-city/commit/06ae5cad0f94d7bade151e7504db68bca5845266
