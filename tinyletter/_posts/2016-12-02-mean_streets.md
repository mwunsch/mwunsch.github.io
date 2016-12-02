---
title: The Programs of the Week of ⚡ Cyber Monday ⚡
---

This Week's Program: Nov 28 - Dec 1
===================================

[Last year][last-year] at this time I said, "Truly, all of our days
our Cyber." This year that feels like a nightmare prophecy come
true.

Here's my plan for the rest of the year. `hive-city` is not coming
with me into 2017. I'm going to make as much progress as I can in that
time, but I'll probably be wrapping up and picking up some work
outside this project as December winds down. I'd call this project a
success. Here's what I lay out in the
[README](https://github.com/mwunsch/hive-city/blob/master/README.md):

> + The Elm language, tools, and ecosystem
> + The Elm Architecture and the ongoing evolution of Functional
>   Reactive Programming
> + Making a game
> + Modeling entities and state in a computer game inspired by a
>   physical counterpart
> + And getting to immerse myself in a funky, esoteric game from the
>   90's

I did those things. I really have loved my time spent in Elm, though
it's still such a nascent set of tools. I've embraced the Elm
architecture. I'm making a freaking game and I enjoyed the hell out of
it. I'm coding alongside the Necromunda rulebook. I'm immersed. Feels
great, and I would love to revisit the rules of these skirmish
wargames in a future project.

So here's what I'm thinking about doing next: Next week I'm going to
prepare to set up a new Elm project for the Ludum Dare game
competition. I want to do something in **Racket**, and I'm particular
interested in building tools for the [Twitch](https://dev.twitch.tv)
ecosystem and
[HTTP Live Streaming](https://en.wikipedia.org/wiki/HTTP_Live_Streaming). I
want to get started with Unity development and continue my gamedev
education.

## [13a6a06dd938468ed10e136a73a0b5137fe8dad5][dice]

Tabletop wargames are essentially dice games, so what's a dice game
without dice!? This commit introduces the `Dice` module and type to
`hive-city`. Elm's
[`Random`](http://package.elm-lang.org/packages/elm-lang/core/5.0.0/Random)
module is one of my favorites. Purely functional generators force sane
data-flows. The `Dice` module is just a `Generator (List Int)`.

One thing I miss in the transition to Elm 0.18 is being able to use
backticks to make any function an inline operator. When I imagined the
dice API, I imagined being able to do something like:

    2 `d` 6

To make a 2D6 dice roll. Now, that syntax has been removed, and
reversing the arugments and using the pipe operator is encouraged. So
we get this:

    2 |> d 6

I also make a D3 from the rules of the game. We take our list of dice
and:

    Random.map (List.map (toFloat >> (*) 0.5 >> ceiling))

I do a `Random.map` because this is a generator and the value is not
yet realized, but we know it will be a `List Int`. Inside the
`Random.map` I map over the List with a function we compose: convert
the Int to a Float, divide it in half (I multiply 0.5 because
multiplication is commutative), and then round up.

## [f25b42190e3b033bdfa8e335ef5d016f534715f3][execute]

Back in `Player.execute`, I change the type signature from returning a
pair with a `Task` to one that returns a `Cmd`. You get a `Cmd` by
`perform`ing a Task, so it's pretty quick work to make that
modification. The reason I do this is because `Random.generate`
returns a `Cmd`, so we can `execute` instructions through the same
function regardless of whether or not they require Random effects.

Also the new (as of Elm 0.18) `Tuple.mapFirst` and `Tuple.mapSecond`
functions make shaping the return value of `execute` very easy.

## [74e9660cc543be825032a8832f22a004b362542f][roll]

I add a helper value to `Dice`: `oneD6`, and a new function
`roll`. Roll is just an alias for `Random.generate`, but I pull it in
here so that anything that imports `Dice` doesn't also need to import
`Random`.

## [cf523121e17e81d385839c8af7186858709cb4b8][oned6]

Using that new `Dice.roll` function, I can just slot that in to make
it so that the `Shooting` instruction will roll some dice. I ignore
the dice roll for now.

## [13444a2f66272eb98dc1cd7a061d2b90af318e1d][failure]

Using a previously created, but underutilized type called `Failure`, I
change the `Complete` `Msg` to accept a `Result Failure Action`. I
simplify the `Player.execute` function because I can use
`Tuple.mapSecond` along with `Cmd.map` to make sure that `execute`'s
return value can slot into what the Elm Architecture expects. Using a
`Result` means we encode that some instructions can actually have
values that are failure modes eg. a shot can miss.

## [d642280934eeb222b4d82852636140ff5eae0141][shot]

A `Shot` can either be a `Hit` or a `Miss`. That `Shot` can be
converted to a `Result` with `Weapons.toResult`. I also create
`Model.shoot`, which accepts a `List Die` (I introduce `Die` as an
alias for `Int`). This `List Die` is generated from `Dice.roll` and
contains the values of the dice we rolled. We sum them up and compare
them against the attacker's _ballistic skill_ to determine whether the
shot was a `Hit` or a `Miss`. The `TODO` here notes that I still need
to add modifiers.

## [ab2fb346157ea5bcd485e645757aa2d37da9645d][missedshot]

Now I hook everything up. When the `Shooting` instruction is executed,
the dice is rolled, and the results of the roll are passed into
`Model.shoot`, which will convert the returned `Shot` into a `Result` of
either an `Err`, holding the `MissedShot` type or an `Ok`. The Main
`update` loop will then feed that into the `Complete` Msg to resolve
effects.

## [520365c646b60bcbe58061061ac9551c3c45db44][viewRoll]

Here's a view that presents an icon of Dice. When you click it, it's
going to do something.

## [53b890d92d30882b15a994ec808ed26ae382aa57][diceroll]

Here's a new type alias. A `DiceRoll` is a tuple of the number of
dice, the value of those dice, and an `Instruction` we're rolling for.

## [9121c53f0523d840e96951cd7cb1cc97acd2c595][rolling]

Glueing all of this together is this commit. A new piece of state is
added, `rolling`, which is `Maybe` an aforementioned
`DiceRoll`. `Roll` is a new Msg that executes a given instruction.

In the area of the UI where we display the action controls, if our
`rolling` state is set, we display that Dice view. When clicked, it
will `Roll` the dice for the instruction.

A lot of magic happens in the `Action.Shoot` command, where we use
`Maybe.andThen` to combine the attacker and shooter into a pair, and
then set up `rolling` for the `Shooting` instruction.

Now, whenever a target is in range of the shooter, the message "Target
Acquired" is displayed, and the dice roll control appears. When you
click the dice, it will roll the dice and the result is either `Ok` or
`Err` if the attack is successful.

Now, to resolve wounds! This code is looking hideous. I need to do
some refactoring and reorganization.

🎲 Mark

[last-year]: http://www.markwunsch.com/tinyletter/2015/12/cyber_week.html

[dice]: https://github.com/mwunsch/hive-city/commit/13a6a06dd938468ed10e136a73a0b5137fe8dad5

[execute]: https://github.com/mwunsch/hive-city/commit/f25b42190e3b033bdfa8e335ef5d016f534715f3

[roll]: https://github.com/mwunsch/hive-city/commit/74e9660cc543be825032a8832f22a004b362542f

[oned6]: https://github.com/mwunsch/hive-city/commit/cf523121e17e81d385839c8af7186858709cb4b8

[failure]: https://github.com/mwunsch/hive-city/commit/13444a2f66272eb98dc1cd7a061d2b90af318e1d

[shot]: https://github.com/mwunsch/hive-city/commit/d642280934eeb222b4d82852636140ff5eae0141

[missedshot]: https://github.com/mwunsch/hive-city/commit/ab2fb346157ea5bcd485e645757aa2d37da9645d

[viewRoll]: https://github.com/mwunsch/hive-city/commit/520365c646b60bcbe58061061ac9551c3c45db44

[diceroll]: https://github.com/mwunsch/hive-city/commit/53b890d92d30882b15a994ec808ed26ae382aa57

[rolling]: https://github.com/mwunsch/hive-city/commit/9121c53f0523d840e96951cd7cb1cc97acd2c595
