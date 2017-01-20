---
title: Five Months of Gamedev with Elm
tags:
- Elm
- Gamedev
- Retrospective
medium_id: 62be2de75ca2
---

In early August, I began writing a game in
the [Elm](http://elm-lang.org) programming language. It has been my
first experience using Elm and my first experience developing a
game. Developing the game was a justification for learning Elm, and
Elm seemed like a good language for experimenting with game
development. The game is [Hive City][hive-city]. Now, just over five
months later, I am abandoning the project. This is
the [retrospective][retrospective].

I [stumbled](https://twitter.com/markwunsch/status/322772755009400832)
upon Elm in the Spring of 2013, when researching a new-to-me
concept: [Functional Reactive Programming][frp]. Even as I wrapped my
brain around the concept of a _time-varying value_, I knew that Elm
was an impressive and important advancement in the development of user
interfaces. Evan Czaplicki's
thesis, [*Elm: Concurrent FRP for Functional GUIs*][elm-thesis], was
published in 2012 and I felt like I was early to what would become a
really interesting movement. Another interesting thing that happened
in the Spring/early Summer of 2013 was the initial public release
of [React](https://github.com/facebook/react/tree/v0.3.0).

This post is not the right venue to discuss the specifics of
Functional Reactive Programming. The Elm thesis is instructive and
worth reading, along with the foundational papers
of [Conal Elliott](http://conal.net). A narrative arc can easily be
drawn between the ideas behind FRP and its implementations, and the
methodology of React and its descendants. Data flows in one direction
and final rendering avoids what the Elm thesis describes as "needless
recomputation." Systems like [Om][om-future]
and [Redux](http://redux.js.org) are practical implementations
remixing these ideas to suit different contexts. Just before I began
work on Hive City, Elm said ["farewell to FRP"][farewell] with its
0.17 release.

> So is Elm about FRP anymore? No. Those days are over now. Elm is
> just a functional language that takes concurrency very
> seriously. And from a user's perspective, Elm is just a friendly
> functional language!

I was a bit flummoxed by this decision, but it's become clear that
functional UI paradigms are converging; searching for the best
metaphors and vocabulary to ease in newcomers. I think it's great.

* * *

In the mid-1990's, I was introduced to [**Warhammer 40,000**][40k]. It
was _so_ cool. Warhammer 40K is a tabletop wargame that encapsulates
everything that I thought was cool when I was a kid in the mid
90's. As I learned more about the game and bought into the whole
ecosystem (I did not literally buy into it because it is a very
expensive hobby, but I did read a lot of [White Dwarf][white-dwarf]) I
found [**Necromunda**][necromunda], a spin-off game set in the same
universe.

I had been dabbling in [pseudorandomness][lol-random] for a recent
project and gained a new-found appreciation for dice-based games like
Dungeons & Dragons and Warhammer. *Hive City* would be my attempt to
make a game with Elm inspired by Necromunda.

[hive-city]: https://github.com/mwunsch/hive-city

[retrospective]: https://www.infoq.com/articles/4-questions-retrospective

[frp]: https://en.wikipedia.org/wiki/Functional_reactive_programming

[om-future]: http://swannodette.github.io/2013/12/17/the-future-of-javascript-mvcs

[farewell]: http://elm-lang.org/blog/farewell-to-frp

[40k]: https://en.wikipedia.org/wiki/Warhammer_40,000

[white-dwarf]: https://en.wikipedia.org/wiki/White_Dwarf_(magazine)

[lol-random]: https://youtu.be/pdUCK_io9SQ?list=PLliW0zeGqNKM4k7IiSId_DphJgX_9Wha

![Hive City progress in September demonstrating basic character movement](http://www.markwunsch.com/img/hive-city-movement.gif)

## What Went Well?

I laid out my goals for the project in Hive City's [README][readme].

> This is a repository to house my attempts to better understand the
> problems involved in:
>
> + The Elm language, tools, and ecosystem
> + The Elm Architecture and the ongoing evolution of Functional
>   Reactive Programming
> + Making a game
> + Modeling entities and state in a computer game inspired by a
>   physical counterpart
> + And getting to immerse myself in a funky, esoteric game from the
>   90's

I better understand all of those things. The last point especially. I
picked up the original Necromunda manual and read it over and over
again throughout my implementation. It is still _so_ cool.

Elm is a _great_ language with a great community. I lurk quite a bit
in the Elm Slack and the folks there are genuinely nice and interested
in finding ways to help newcomers understand the language and
architecture. I struggled at first, but it helps that the Elm language
is nearly impossible to distinguish from
the
[Elm Architecture](https://guide.elm-lang.org/architecture/).

As I was working through the game *mitten drinnen* Elm 0.18 was
released. The [upgrade path][upgrade-path] was clear and easy to
follow. The Elm [compiler's errors][errors] have received a lot of
well-deserved attention for their usefulness and readability. I relied
heavily on the compiler and was so grateful for its clarity and
tone. There's plenty of internet handwringing about Elm's lack of
features, notably typeclasses. I did not find this to be a real
deal-breaker and got along fine without. My experience with Elm went
well.

[readme]: https://github.com/mwunsch/hive-city/blob/master/README.md

[errors]: http://elm-lang.org/blog/compiler-errors-for-humans

[upgrade-path]: https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md

![Hive City progress in October showing measured movement](http://www.markwunsch.com/img/hive-city-movement2.gif)

## What Didn't Go So Well?

My experience making a game did not go so well. I had no idea what I
was entering into. I chose to render the game with SVG, because it
seemed like that's what the Elm ecosystem encouraged. I don't think
making web-based games with SVG is common. Elm tooling is still so
nascent, and the community of frameworks and libraries built around
Elm (and that are kept up to date) are so young. There is no great
reference for doing game development in Elm, though I'm not sure what
I was expecting. I also had to do _so much math_ and I couldn't help
but think a solid game framework would have provided that for me.

As I stated before, I am abandoning this project. I reached my goals
for learning Elm, but I'm still so intrigued by game development and I
don't feel like staying within the Elm ecosystem will provide me the
education I need. I'll be picking up Unity to learn more. That's
perhaps the most obvious choice for someone new to game development. I
was hopeful that Elm would provide enough to scratch my gamedev
itch. It doesn't, and I'm still itching for more.

![Progress in the week of Oct 14](http://www.markwunsch.com/img/hive_city_oct14.gif)

## What Have I Learned?

A lot. I learned Elm. I learned how to be productive in a statically
typed, purely functional language, having only briefly toyed with
Haskell in the past. I learned more about SVG then I thought I wanted
to (and have since applied that knowledge to things like D3). I
learned about game development, and learned that I like it! I learned
that Warhammer 40K has not stopped being cool.

Here are some resources that really helped me along the way:

+ [jweissman/mandos](https://github.com/jweissman/mandos) — "a tiny
  rogue clone written in elm!" This project has been an incredibly
  useful example to follow.
+ [_Game Programming Patterns_](http://gameprogrammingpatterns.com) by
  Robert Nystrom — I didn't finish this book, but it helped get me in
  the mindset for game development.
+ [*Making Impossible States Impossible*][impossible-states] by
  Richard Feldman — a really useful talk about leaning into Elm's type
  system to reduce unwanted application states.
+ [*Rich Animation*][rich-animation] by Matthew Griffith — another
  useful talk from elm-conf. This one about using
  the
  [`elm-style-animation`](http://package.elm-lang.org/packages/mdgriffith/elm-style-animation/latest) library.
+ [*Point-Free or Die*][point-free] by Amar Shah — a provocatively
  named talk that walks through the point-free style of programming
  that can be used in Elm and languages like it.

Finally, and most importantly, is _the_ talk that best defines the Elm
approach:
[_Code is the Easy Part_](https://www.youtube.com/watch?v=DSjbTC-hvqQ). This
talk outlines the goals and methodology of the Elm community and
ecosystem. One argument leveled against Elm is how it stands up to
other, similar programming
environments. [Here's a blog post][purely-functional] comparing
different purely functional web UI approaches. This talk explicitly
outlines that Elm is not trying to be the pinnacle of the last twenty
years of functional programming research. Having "Monadic" code is not
something that Elm cares about. Honestly, neither do I. Neither do
most developers, I suspect.

[impossible-states]: https://www.youtube.com/watch?v=IcgmSRJHu_8

[rich-animation]: https://www.youtube.com/watch?v=DsDwYqsLU3E

[point-free]: https://www.youtube.com/watch?v=seVSlKazsNk

![Oct 28 progress](http://www.markwunsch.com/img/hive_city_oct28.gif)

[purely-functional]: http://mutanatum.com/posts/2017-01-12-Browser-FP-Head-to-Head.html

## What Still Puzzles Me?

Embarking on this project, I did not expect to be so captivated by
game development. Now I want to make games, and I want to explore game
development in a variety of contexts. Someone asked me if I thought
that a functional approach to game development was better than an
imperative approach. I honestly don't know, because I've never done
game development any other way. This is something I've only barely
scratched the surface on.

I'm so completely befuddled by WebGL, and in
particular
[WebGL with Elm](http://package.elm-lang.org/packages/elm-community/webgl/latest). How
does this work? I've never done anything with OpenGL before. More than
that, what is this strange syntax that allows WebGL to work within
Elm? I am so puzzled.

Elm works within its native environment (the browser, mostly) using
_Effect Managers_. Effect Managers are not well-documented. I'm not
really interested in diving into the guts of Elm, but I'm curious
about some of these implementation details. Mostly because I think it
would be neat for Elm to exist in runtimes outside the browser. I
don't know how these work and how they could be extended. This is an
area where Clojure is doing
some
[really](http://planck-repl.org) [interesting](https://github.com/omcljs/ambly) [stuff](http://arcadia-unity.github.io).

![Nov 22 progress](http://www.markwunsch.com/img/hive_city_nov22.gif)

I fret about Elm's ongoing relevance. *Code is the Easy Part* suggests
that Elm's goal is to compete with other JavaScript frameworks in the
arena of web developer mind share. I have come to really like and
enjoy Elm, but I can't help but think that ship has already
sailed. Developers have a plurality of choice in web development, and
the decision tree that a developer or engineering manager must take to
reach Elm is _very_ deep. Within the realm of frameworks with similar
reactive principles are React/Redux, Om, [Vue.js](https://vuejs.org),
AngularJS, Ember… Fans of statically typed languages can choose from
languages like [TypeScript](https://www.typescriptlang.org)
or [Flow](https://flowtype.org)
or [PureScript](http://www.purescript.org) or they might really go
wild and invest their time in [Scala.js](https://www.scala-js.org)
or [GHCJS](https://github.com/ghcjs/ghcjs). Many of those languages
allow for development in other runtimes
like
[JavaScriptCore](https://developer.apple.com/reference/javascriptcore)
or
Node.js. The
[developer tools for Redux](https://github.com/gaearon/redux-devtools)
are nicely done and are further along than Elm's. Elm is great, but
its greatness is lost in a sea of good-enough alternatives.

Then there's the domain of game development. You can make a robust
HTML5-powered game with TypeScript
and [Turbulenz](https://github.com/turbulenz/turbulenz_engine)
or [Superpowers](http://superpowers-html5.com/index.en.html). I think
this would be a great area for Elm to stand out and differentiate
itself. Unfortunately, I am not adept enough to make a meaningful
contribution here. If you're a game developer looking to shape and
mold a platform, I think Elm is worth your time and investment.

![Final Hive City animated gif](http://www.markwunsch.com/img/hive_city_jan19.gif)

* * *

If you're interested in "playing" Hive City (warning: it is not fun),
I encourage you to
clone [mwunsch/hive-city](https://github.com/mwunsch/hive-city) and
run Elm Reactor on it. I don't have any regrets about taking on this
project and no regrets about abandoning it in its current state. I
would love to revisit the world of Necromunda and 40K for my future
gamedev endeavors. I'll be keeping an eye on the Elm community and its
development, though it's unlikely I will be programming in it again
anytime soon. There are more languages to learn and more projects to
do.

Just this week, Games Workshop [announced][announcement] that an
officially licensed Necromunda computer game would be released soon.

This is the second retrospective I've done for a project I've embarked
on in an unfamiliar language. You can read [my first][sonic-sketches],
a retrospective for
my [@sonic-sketches](https://twitter.com/sonic_sketches) Twitter bot
written in Clojure.

[**Subscribe** to my weekly newsletter](http://tinyletter.com/wunsch) that
tracks the code I write and the progress I make each week. My next
project will be in the [Racket](https://racket-lang.org) programming
language.

[elm-thesis]: https://www.seas.harvard.edu/sites/default/files/files/archived/Czaplicki.pdf

[necromunda]: https://boardgamegeek.com/boardgame/3072/necromunda

[sonic-sketches]: http://www.markwunsch.com/tinyletter/2016/08/sonic_sketches_retrospective.html

[announcement]: https://www.warhammer-community.com/2017/01/19/new-computer-game-announced/
