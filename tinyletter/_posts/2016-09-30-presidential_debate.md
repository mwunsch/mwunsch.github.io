---
title: The Programs of the Week of the First Presidential Debate
message_id: <oec32v.2127qfauzht2s@markwunsch.com>
---

This Week's Program: Sep 26 - Sep 30
====================================

I have computers. I am so good with these computers. It's
unbelievable. The security aspect of Cyber is very, very tough. And
maybe, it's hardly doable. But I will say, we are not doing the job we
should be doing. But that’s true throughout our whole governmental
society. We have so many things that we have to do better. And
certainly Cyber is one of them.

## [7a0f270a47fb245f226696bfb47e15cfd7e876b5][movementarea]

This week I reached some new level of awareness with Elm. Slowly, at
first, and then all at once. The _fun_ parts of working in a
functional language (I intended it) are in choosing the right type
abstraction. Do you lean on functional composition and the pointfree
style or do you favor being more explicit? In this case, by having the
`movementArea` binding include the view of the `Model`, I could avoid
some parentheses. It seems like avoiding parentheses in a language
like Haskell or Elm is part of the fun. How many combinators can I
string together so that I don't have to use parens?

## [d17f2a16e58af7760c82309f4eaf37ca7e4b8472][windowwidth]

I pull in the [`elm-lang/window`][elm-window] library so that I can
match the size of my `Tabletop` with the width of the browser
window. Previously, I was doing this in SVG directly by having the
`width` attribute of the svg element set to 100%. By moving this into
the Elm architecture, I can have the window width be a piece of state
that my game can react to, as in the `Resize` event. This is also my
first time really wrapping my head around the
[`Task`](http://package.elm-lang.org/packages/elm-lang/core/4.0.5/Task)
module.

## [f71b6700e842cc8e738ec0e9859a7b88abe1b7c8][parens]

I go far out of my way to minimize the use of parentheses in the
program. Lol. Later, I'll reverse this decision. Sometimes you need
those parens. This was a fun excuse to try some of the functional
infix operators.

## [d84e1acf32b6eb6b9fa24f682a00f9c04b56aa2e][clickwithcoords]

Here's the big milestone for this week. Moving the "fighter" model
around the board with the mouse.[^1]

!["Animation of entity movement in Hive City"][movementgif]

I create a function, `onClickWithCoords`, this will send a click event
to one of my `Msg` types with the `Mouse.Position` of the click. This
enables me to bind this event to DOM nodes without listening to global
click events, as I had done last week. Love this little piece of code:

    Json.object2 Mouse.Position
        ("clientX" := Json.int)
        ("clientY" := Json.int)

This is Elm's funky way of saying "Pull out the _clientX_ and
_clientY_ params from this JSON blob (a click event), cast them to an
`Int`, and construct a `Mouse.Position`.

I put the "scale" of the SVG into the game's state. It's the width of
the window divided by the width of the tabletop. I divide the mouse
position by the scale to get the coordinates within the SVG for where
to move the fighter. My game is now officially interactive!

Next week, I hope to further refine how movement occurs within the
game. The `Models` in a tabletop war game have clear rules about how
they can to move.

For funsies, here's
[a video of some guys playing Necromunda](https://youtu.be/eA4D8VDb9h0).

We came in with the Internet. We came up with the Internet.<br />
– Mark

[^1]: I made this animated gif with the very handy
    [LICEcap](http://www.cockos.com/licecap/)

[movementarea]: https://github.com/mwunsch/hive-city/commit/7a0f270a47fb245f226696bfb47e15cfd7e876b5

[windowwidth]: https://github.com/mwunsch/hive-city/commit/d17f2a16e58af7760c82309f4eaf37ca7e4b8472

[elm-window]: http://package.elm-lang.org/packages/elm-lang/window/latest

[parens]: https://github.com/mwunsch/hive-city/commit/f71b6700e842cc8e738ec0e9859a7b88abe1b7c8

[clickwithcoords]: https://github.com/mwunsch/hive-city/commit/d84e1acf32b6eb6b9fa24f682a00f9c04b56aa2e

[movementgif]: http://www.markwunsch.com/img/hive-city-movement.gif
