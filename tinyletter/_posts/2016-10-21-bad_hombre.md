---
title: The Programs of the Week We Were Kept in Suspense
message_id: <off1ia.es5601y98kxm@markwunsch.com>
---

This Week's Program: Oct 17 - Oct 21
====================================

I spent a bit of time this week reading the rules of Necromunda and
expanding `hive-city` a bit more. No animated gif though; a lot of
what I worked on was under the hood. Check out the code I wrote
[this week][thisweek]!

## [c40be00e4c246dc3aecfffac149d09d5b7e504ac][turn]

I flesh out the `Turn` module a bit more. A turn in both Necromunda
and Warhammer 40K is broken up into a series of phases. A player can
only do certain actions depending on the phase.

## [4b73f3a9765a91509b893943b1785cf3df36a31a][movementphase]

Here, I make it so that you can only move a Model if you're in the
Movement phase of the Turn. I also do a little trick I saw in Richard
Feldman's elm-conf talk,
[_Making Impossible States Impossible_](https://www.youtube.com/watch?v=IcgmSRJHu_8). In
this talk, Richard walks through using Elm's Sum Types (aka Algebraic
Data Types) to hide implementation details. I use that in the `Turn`
type:

    type Turn = Turn Int Phase

This basically says that a `Turn` type has 1 constructor, also called
`Turn`, that takes an `Int` and a `Phase`. Within the Turn module, I
can deconstruct on this, but I don't expose the `Turn` constructor
outside of the module. Only functions within the `Turn` module can
create new turns.

## [cf12f7104848c8bce105bc6457ab42e0195b4f8f][profiletypes]

There are four different types of fighters in Necromunda: Gangers,
Heavies, Juves, and Leaders. Each one of these types start off with a
base level attributes. I formalize those a bit more.

## [29b00dc9299bab3db46726b921494fc012973218][gangrecruit]

I apply the same constructor type pattern from the `Turn` type to the
`Gang` type. Previously, a Gang was just a `Dict` — a key/value
pair. Now, a Gang has a rich set of information, but that information
is only accessible from using functions from the Gang
module. Nothing changes in the API, all the functions keep their type
signatures, but the implementation details are all different. Now a
Gang can also "recruit" members. In Necromunda, you're given a certain
number of "Guilder credits" that you can use to "buy" gang members and
weapons. In this way, you can bring the same Gang from game to game
and power them up over time. I make it so that recruiting new Models
deducts points from your available credits in the `recruit` function.

## [60fce4f78f48843dc2fe93f627d87b7e62b0150a][action]

Here's a new module: `Action`. An `Action` is a thing a Model is
doing: either awaiting instructions, moving, shooting, etc.

## [be9e5bcfc9503bc576a9b100f03d73b025fb6980][await]

The `Player` type is always performing some `Action`. When the Player
selects a Model, then the Action is rendered. Typically, the Player is
performing the `Await` action, which just means that the selected
Model is awaiting some instruction.

## [36075dedfb3751813a149d30d91e66b354b6a928][click-to-deselect]

When the Player clicks on the screen, if they're not 2 inches near the
selected Model, the Model will be deselected. I make the
`Tabletop.isWithinDistance` function to handle that scenario.

## [290293c718a9f054242679cb842244ddb97c59ac][lookup-by-key]

When you hit the "1" through "5" keys on your keyboard, that selects
the corresponding Gang member. I expose `Gang.toArray` to make this
easier. You'll notice I'm really loving Elm's pipeline operator (`|>`)
and using `Maybe.map` and `Maybe.withDefault` together. That pattern
is used all throughout this program.

## [c54834bf163a22839c7ac78774a362825646e700][viewcontrol]

There's a lot going on here. When a Player has the `Await` action,
selecting a Model will render a small little control that shows the
available actions that Model can take in the current Phase. This code
sets that up and also sets up the control for `Move`. When the `Move`
control is clicked, the Player is now in the `Move` action and renders
the measuring tape UI. Now when the Player clicks and the current
action is `Move`, it moves the Model just as it had done before.

Harry's, my employer, is having a Chili cookoff today. So I'm going to
go enjoy that now. Have a good weekend!

🌶 Mark


[thisweek]: https://github.com/mwunsch/hive-city/commits?author=mwunsch&since=2016-10-17T04:00:00Z&to=2016-10-21T04:00:00Z

[turn]: https://github.com/mwunsch/hive-city/commit/c40be00e4c246dc3aecfffac149d09d5b7e504ac

[movementphase]: https://github.com/mwunsch/hive-city/commit/4b73f3a9765a91509b893943b1785cf3df36a31a

[profiletypes]: https://github.com/mwunsch/hive-city/commit/cf12f7104848c8bce105bc6457ab42e0195b4f8f

[gangrecruit]: https://github.com/mwunsch/hive-city/commit/29b00dc9299bab3db46726b921494fc012973218

[action]: https://github.com/mwunsch/hive-city/commit/60fce4f78f48843dc2fe93f627d87b7e62b0150a

[await]: https://github.com/mwunsch/hive-city/commit/be9e5bcfc9503bc576a9b100f03d73b025fb6980

[click-to-deselect]: https://github.com/mwunsch/hive-city/commit/36075dedfb3751813a149d30d91e66b354b6a928

[lookup-by-key]: https://github.com/mwunsch/hive-city/commit/290293c718a9f054242679cb842244ddb97c59ac

[viewcontrol]: https://github.com/mwunsch/hive-city/commit/c54834bf163a22839c7ac78774a362825646e700
