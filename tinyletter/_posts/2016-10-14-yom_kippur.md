---
title: The Programs of the Week the Shackles Have Been Taken Off
message_id: <of1t79.a3qk9qmaxm0o@markwunsch.com>
---

This Week's Program: Oct 10 - Oct 14
====================================

Gut Yuntiff! Between Columbus Day, Yom Kippur, and the continuous
existential dread that is the United States election, I had a big
programming week in `hive-city`:
[23 commits this week][commits-this-week]!

I'm liking the **Elm** language quite a bit and am feeling much more
comfortable in it. Here's a look at the latest state of the game:

!["Animation of generated Gang in Hive City"][gengif]

Big difference from last week. Here are some of the highlights:

## [1529818eef115e3758f6d04eb4d4f254a030cd95][maxmovement]

A Model can only move as far as its movement characteristic allows.

## [ec250a1609b5c6e27cc777c1398987fe7a666212][selected]

A Model has a `selected` state.

## [ae8a7054eea5dbe62c72d8e11f8e84deed83f0f1][keyboard]

I bring in the
[`elm-lang/keyboard`](http://package.elm-lang.org/packages/elm-lang/keyboard/latest)
module. This lets me listen for key presses. Specifically I listen for
Key Code 27: the `ESCAPE` key. When pressed, the Model is unselected.

## [eaa66516500b356eed5eeb41c6d77172c059c718][player-gang]

I introduce two new modules: A `Player` and a `Gang`. A Gang is a
group of `Models`. You don't just have one fighter in Necromunda, you
have a gang of them! I move ownership of the gang into the `Player`
record, and that module is also responsible for operating over the
things a player can do (which right now is only selecting and moving
the fighters in the gang).

## [70b178f6f613c60743f529a0afa4fae85b7bd524][scale]

I adjust the scale of the tabletop. Most games are played on a 4′ × 6′
table. I adjust the Model to represent the 25mm base of a typical
[Citadel miniature](https://en.wikipedia.org/wiki/Citadel_Miniatures).

## [b945c183cf2fbb22e26541d305d3fedc98353fe5][measuringtape]

I move the view concern of drawing the line to represent movement into
the Tabletop module. I'm calling this concern the _measuring tape_ and
I've generalized it to be able to draw a line between two positions on
the board and a length between those points.

## [6305e00964c3922d10179d589dede25148436cc4][viewprofile]

I clean up some of the `Model` and add a new view: A table that
displays the fighter's profile.

In some future commits, I make it so that when a fighter is selected,
their profile view is rendered. I also add some helpful type aliases
and conversions to
[Tabletop](https://github.com/mwunsch/hive-city/commit/74fde8b9da2cdec6d5e3d1fe4d213eb1f2300c6c). The
coolest of this is `by` which lets me write:

    6 `by` 4

That returns a Tabletop!

## [9a6a26b0d91bc8b8a39c6cdd4fbd0ff3612866ef][random]

I pull in Elm's `Random` module to make Generators. I make a
`Generator` for `Tabletop.Position` and a Generator for `Models`. All
the Model one does is just clone the basic Model and assign it a
Random id for now.

## [649ba221f03d198eadabe3bff350716c62b9b2a4][positionedgenerator]

Using the above, I generate a Gang of 5 Models and position them
randomly on the board. I really like how Elm manages Random generation
while remaining purely functional.

`Gang` is a type alias to a `Dict` (that's Elm's hash map/dictionary
type), but in a later commit I remove all of the `Dict` references
from everywhere but `Gang`. I like static types because they let me
hide away these implementation details.

I also throw in a bunch of fun functional composition (lol see what I
did?). You'll see throughout these commits a bunch of revisions where
I prefer the point-free style. It can be terse without obfuscating
meaning. Elm's infix operators are inspired by [F♯](http://fsharp.org)
and using them makes me feel like a _real_ programmer.

## [3d70b375879aab3edb5cc3355f16a408c5320d57][uuid]

Using my newfound function composition skills and love for Elm's
`Random` module, I put together a UUID generator. This is somewhat
fake (or dumb as I called it in the commit message), since a
[Version 4 UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29)
has some specific requirements, but it looks close enough to a UUID!
Along the way I built this really handy function, which I now present
on its own:

    {-| Turn a List of Generators into a Generator of Lists
    -}
    together : List (Random.Generator a) -> Random.Generator (List a)
    together =
        List.foldr (Random.map2 (::)) (Random.map (always []) Random.bool)

Now that's some point-free shit. Took me forever to figure that one
out, but it's so useful! High five to you if you can translate that to
English. Here's my take: _"The `together` function reduces the list by
appending each generator onto the generator of
an empty list, starting on the right."_

## [6c865bb9b8fa575f2206dc9270e6368501bc1ac1][replace-id]

I update the `Model.Id` type alias to use my new `Uuid` under the
hood. Nothing else across the codebase has to change for this to work!

Types! Functions! Elm is so dope!

λ Mark


[commits-this-week]: https://github.com/mwunsch/hive-city/commits?author=mwunsch&since=2016-10-10T04:00:00Z&to=2016-10-14T04:00:00Z

[gengif]: http://www.markwunsch.com/img/hive_city_oct14.gif

[maxmovement]: https://github.com/mwunsch/hive-city/commit/1529818eef115e3758f6d04eb4d4f254a030cd95

[selected]: https://github.com/mwunsch/hive-city/commit/ec250a1609b5c6e27cc777c1398987fe7a666212

[keyboard]: https://github.com/mwunsch/hive-city/commit/ae8a7054eea5dbe62c72d8e11f8e84deed83f0f1

[player-gang]: https://github.com/mwunsch/hive-city/commit/eaa66516500b356eed5eeb41c6d77172c059c718

[scale]: https://github.com/mwunsch/hive-city/commit/70b178f6f613c60743f529a0afa4fae85b7bd524

[measuringtape]: https://github.com/mwunsch/hive-city/commit/b945c183cf2fbb22e26541d305d3fedc98353fe5

[viewprofile]: https://github.com/mwunsch/hive-city/commit/6305e00964c3922d10179d589dede25148436cc4

[random]: https://github.com/mwunsch/hive-city/commit/9a6a26b0d91bc8b8a39c6cdd4fbd0ff3612866ef

[positionedgenerator]: https://github.com/mwunsch/hive-city/commit/649ba221f03d198eadabe3bff350716c62b9b2a4

[uuid]: https://github.com/mwunsch/hive-city/commit/3d70b375879aab3edb5cc3355f16a408c5320d57

[replace-id]: https://github.com/mwunsch/hive-city/commit/6c865bb9b8fa575f2206dc9270e6368501bc1ac1
