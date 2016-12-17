---
title: The Programs of the Week of a Polar Vortex
message_id: <oib3qu.303qb4xl0b7da@markwunsch.com>
---

This Week's Program: Dec 12 - Dec 16
====================================

Good evening. An Arctic blast has come and the temperatures have
dropped in New York City. As the weather chills here, my velocity and
enthusiasm for `hive-city` does likewise. Progress this week in code
was quite slow as I do my best to enjoy the last remaining weeks of
2016.

## [bb72bc42dadf34559cdda0d8b15270c5a73d7fce][color]

`hive-city` is a 2-player game. This commit introduces a `color` state
for each Player. I move the `view` of the Gang into the Player module
and pass the Player's color into the `fill` attribute of the SVG `g`
element.

## [0855a1fdba75e463de862ac0c6107052f571d601][gangview]

Within my refactoring effort: the `Game` module, I set Player 2's
color to red. I implement the new `Player.gangView` function within
the SVG output of the Main `view` function. In the `Model` module I
have the fill color "inherit" from the Player.

## [7bce31667484fa51ff65c0122781532e4c8f98bc][generate]

Back in the original `GameState`, I used a `Random.generate` call to
populate the game with a Gang. Now that I have two Players and two
Gangs, I introduce a `Game.generator` into my refactoring. This will
return a `Generator Game` and will randomly generate two gangs for
each player. I use
the
[`uncurry`](http://package.elm-lang.org/packages/elm-lang/core/5.0.0/Basics#uncurry) function
to wire `Random.map2` to be able to accept a pair. Fancy functional
programming!

## [0b8e1580623fec85d20ed960f52080a29db3bef6][game]

Just for kicks and to verify that this works, I pull my new `Game`
module into my old `GameState` model and have it generate the
players. I look into the Elm debugger and lo and behold it works!

I'm slowly moving more and more functionality into the new `Game`
module. I think I might be done with that by the time this year is
over, and I'll be moving on from this project.

Stay warm,<br />
❄ Mark



[color]: https://github.com/mwunsch/hive-city/commit/bb72bc42dadf34559cdda0d8b15270c5a73d7fce

[gangview]: https://github.com/mwunsch/hive-city/commit/0855a1fdba75e463de862ac0c6107052f571d601

[generate]: https://github.com/mwunsch/hive-city/commit/7bce31667484fa51ff65c0122781532e4c8f98bc

[game]: https://github.com/mwunsch/hive-city/commit/0b8e1580623fec85d20ed960f52080a29db3bef6
