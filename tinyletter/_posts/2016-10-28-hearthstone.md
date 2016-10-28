---
title: The Programs of the Week of the Hearthstone World Championship
message_id: <ofriyx.1u6ig7rlqutnw@markwunsch.com>
---

This Week's Program: Oct 24 - Oct 28
====================================

This is the opening week of the World Championship tournament for
[Hearthstone](http://us.battle.net/hearthstone/en/), a game that up
until this point I had no real interest in. I've become completely
caught up in the challenge of _gamedev_. Just like I studied music
theory in creating
[@sonic_sketches](https://twitter.com/sonic_sketches), I'm now
studying games and trying to learn everything I can about this
field. I've loved spending time on `hive-city` because it requires a
comprehensive understanding of all kinds of areas in software
development and design. I've come to really appreciate games of all
genres and production value for the immense amount of thought put into
them and the breadth of disciplines that are put to use.

This week I've done a lot of thinking on what Hive City's
[HUD](https://en.wikipedia.org/wiki/HUD_(video_gaming)) should look
like. HUD and user interface design in games are really fascinating to
me. How best do you represent the things a player is doing and _can_
do in a way that occupies minimal real estate? This is an area that I
can't find a lot of "best practices" in, probably because I'm still
unsure where to look. In a functional language like Elm in particular,
I'm forced to think about the various states the game and a player can
transition through. Thinking about how to represent how and where a
player is in the context of that state machine has been a really fun
puzzle. That's what brought me to Hearthstone: I was looking at the
user interfaces for turn-based, two-player games.

What's particularly interesting to me about Hearthstone is that it's
free, it's easy enough to pick up casually but also has its hardcore
appeal (some of the matches in the Championship tournament were pretty
thrilling), and I can play it on my iPad. Seeing how a game as
hardcore and as popular as Hearthstone manages to have an interface
that works both for touch screens as well as souped-up gaming PC's has
been a real inspiration. I would love to play Hive City on my iPad
without compromising the keyboard and mouse experience.

Hearthstone is free, so
[**use my referral link**](https://battle.net/recruit/WHH5WTN68G?blzcmp=raf-hs&s=HS&m=web)
to sign-up for an account and we will both get in-game rewards! If
you're already a player, I'm **Wunsch#1334** on Battle.net.

Here's what the User Interface for Hive City looks like now:

!["Animation of the UI in Hive City"][gif]

[gif]: http://www.markwunsch.com/img/hive_city_oct28.gif

## [c4aa2aa99252863d9c38edf761938e8d9b9920b7][utilities]

I create a `Utilities` module to hold some functions, most of which
relate to working with HTML/SVG. `onClickWithoutPropagation` creates
a click handler that doesn't propagate its event upwards.

## [9dd61471b3c97ff80eebac44de1035a8c00b4202][takeAction]

I add a new sum type, `Instruction`, and a `takeAction` function to
the Player module. The idea here is that once a Player triggers an
`Action`, like `Move`, the `Instruction` type encapsulates how that
action is completed.

## [6e560fb859a2ca6ccccb14f9514a8909c3c96f24][complete]

Back in the `Main` module, the `Player` will `takeAction` and then we
mark that action as `Complete` with the
[`Task`](http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Task)
type.

## [5044c414a2c9a972e20b9581cb8f94ba741a459b][documentation]

This relationship between an `Action` and `Instruction` and `Command`
types are a little bit stuck in my head, so I write a bit of
documentation to show how this ought to flow and change some of the
names.

> The `Action` module describes the Action a Player is allowed to take
> during a Phase and is responsible for drawing the user controls for
> those actions.

> A Player is always taking some Action (even just Awaiting
> input). The `Instruction` type describes the execution of that
> action, along with what is necessary to execute it.

> The `execute` function executes the Instruction, and returns a pair
> of an updated Player and a `Task`.

A Player can be set to the `Move` action and then `execute` the
`Moving` instruction to move a model to a new position. The `Task` is
there to indicate a successful or failed execution.

## [bc9a2613948db14c925f236f27f207cab83b6de4][letterbox]

I move the Tabletop into this little letterboxed area. The idea being
is that this space around the table will be where my HUD goes.

## [d4a8c43cb67210965f02159f84a024a1465234a0][clip]

I break out the SVG
[`clipPath`](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/clipPath)
to clip stuff that goes outside the Tabletop. I'm learning SVG as I
go!

## [d8866dc4a1e5f22010bd8d495ac81fba998b8877][foreignobject]

I create a new utility function: `htmlAsSvg`. This uses the SVG
[`foreignObject`](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/foreignObject)
element to include HTML inside the SVG. This way, I can take the
profile view of a `Model` and embed it right into the game. I position
it in the lower right when the Player selects a Model. I make a
`ContextMessage` type alias and place that at the top of the game. It
just says what Phase of the Turn you're in for now, but eventually
error and status messages will go here.

## [ceac065a6f23e4502313493c102bdfb5a18ca456][controls]

I make it so that when the `Player` selects a `Model`, the controls
for that `Model` (what `Action` a Player can take) are placed in the
lower left corner of the game HUD. By making them big and putting them
in one place I can make it a bit more touch-friendly.

## [7d9c3300ac99c31da4b49071675c3c9c445edf9e][canAct]

I create a "disabled" state for an action by passing a `canAct` flag
to the `viewControl` function eg. a `Model` can't take the `Move`
action if they're out of moves.

## [8758c8da5f2accb7754029a8df9adc7ef2bf8012][m-key]

I make it so that pressing the `M` key on a keyboard will trigger the
Move action if a Model is selected.

## [49f3ce64a267c33790196b14f5fd9e3fba8a649e][marker]

I break out the SVG
[`marker`](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/marker)
to draw a little arrow on the measuring tape. It's an interesting
flourish but I'm not completely satisfied with it.

Have a Spooky Halloween!

🎃 Mark


[this-week]: https://github.com/mwunsch/hive-city/commits?author=mwunsch&since=2016-10-24T04:00:00Z&to=2016-10-21T04:00:00Z

[utilities]: https://github.com/mwunsch/hive-city/commit/c4aa2aa99252863d9c38edf761938e8d9b9920b7

[takeAction]: https://github.com/mwunsch/hive-city/commit/9dd61471b3c97ff80eebac44de1035a8c00b4202

[complete]: https://github.com/mwunsch/hive-city/commit/6e560fb859a2ca6ccccb14f9514a8909c3c96f24

[documentation]: https://github.com/mwunsch/hive-city/commit/5044c414a2c9a972e20b9581cb8f94ba741a459b

[letterbox]: https://github.com/mwunsch/hive-city/commit/bc9a2613948db14c925f236f27f207cab83b6de4

[clip]: https://github.com/mwunsch/hive-city/commit/d4a8c43cb67210965f02159f84a024a1465234a0

[foreignobject]: https://github.com/mwunsch/hive-city/commit/d8866dc4a1e5f22010bd8d495ac81fba998b8877

[controls]: https://github.com/mwunsch/hive-city/commit/ceac065a6f23e4502313493c102bdfb5a18ca456

[canAct]: https://github.com/mwunsch/hive-city/commit/7d9c3300ac99c31da4b49071675c3c9c445edf9e

[m-key]: https://github.com/mwunsch/hive-city/commit/8758c8da5f2accb7754029a8df9adc7ef2bf8012

[marker]: https://github.com/mwunsch/hive-city/commit/49f3ce64a267c33790196b14f5fd9e3fba8a649e
