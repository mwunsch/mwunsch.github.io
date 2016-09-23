---
title: The Programs of the Week of the Autumnal Equinox
message_id: <odypld.1lm33wm2t6wv9@markwunsch.com>
---

This Week's Program: Sep 19 - Sep 23
====================================

Autumn is my favorite season. I'm happy to be greeting it this
week. Writing, both code and this prose, is a respite from the tumult
of the world. A literal bomb went off nearby. I turn to my computers
and my craft for calm, which is slightly disrupted when I discover
that iOS 10 is kind of crap. I have not upgraded to OS X — \*ahem\* —
_macOS Sierra_. I won an Amazon Echo in a work raffle and have yet to
set it up. I am both slightly
[terrified](https://www.washingtonpost.com/news/the-switch/wp/2014/11/11/how-closely-is-amazons-echo-listening/)
and [intrigued](https://developer.amazon.com/ask) by it.

## Strange Loop

[Strange Loop](http://www.thestrangeloop.com) was this past
weekend. It is my favorite technical conference I've never
attended. They released some videos of the talks and I've been slowly
working my way through them. Here are some standouts so far:

+ [_Systems Programming as a Swiss Army Knife_][strange-loop-b0rk]
+ [_Tulip: A Language for Humans_][strange-loop-tulip]
+ [_Point Free or Die: Tacit Programming in Haskell_][strange-loop-pointfree]
+ [_Code is the Easy Part_][elm-conf-talk] (a talk from the colocated
  [elm-conf](https://www.elm-conf.us))

I find so much value in Strange Loop's content every year.

## [b0005725845e424b9cab6531d64a8c85740ada29][rect]

I render the `Tabletop` module into the game's main screen. It's a big
red rectangle. This is the extent of my SVG prowess.

## [5b81d3e7a43eb9e308687363ab274e96c4674fc6][fighter]

I render the "fighter" `Model` onto the `Tabletop`. Now it looks like
a small black `@` on a big red rectangle. You can click to "select"
the fighter and it turns white.

## [e08fef231cc19379c430796260bcc752bd5361c4][circle]

When the fighter is "selected", I render a pink circle with a radius
representing how far the fighter can move. Note that the fighter still
doesn't move; this just shows how far it _could_ move according to the
game rules.

## [7afbab4d2f0b1016dd2864bd23e50d841d8815cf][deselect]

If the fighter is selected, and you click anywhere outside of it, it
will "deselect" the fighter. I also introduce a `NoOp` msg type that
basically says "do nothing".

## [3f22d1899ec9c9856db26bd54006357ce216c389][movement]

Next, I attempt to make it so that when you click somewhere on the
tabletop, the fighter moves to that location. Here's where things get
hard. To get the coordinates of the mouse click, I pull in the
[`elm-lang/mouse`](http://package.elm-lang.org/packages/elm-lang/mouse/latest)
library. This isn't totally necessary. An alternative to this approach
is to use [`Html.Events.onWithOptions`][onwithoptions].

This code works, but because the mouse coordinates aren't mapped with
the coordinates of the SVG, the `fighter` moves to outer space (or at
least very far off the tabletop). The
[SVG coordinate systems](https://sarasoueidan.com/blog/svg-coordinate-systems/)
are the next thing I need to wrap my head around. This
[article from Microsoft][svg-coordinates] explains the problem well —
I still have no idea what it means.

I didn't expect my Elm explorations to so quickly turn into "how to
make a game engine with SVG", and it's not exactly where I'd prefer to
spend my time. I thought I'd be spending a bunch of time modeling the
problem with Algebraic Data Types. This is still fascinating stuff,
and Elm remains intriguing.

I'll be reading
[_An Original Approach to Web Game Development Using SVG_](http://www.svgopen.org/2011/papers/14-An_Original_Approach_to_Web_Game_Development_Using_SVG/)
for a bit of inspiration and reference. I also found the
[MDN Game Development Center](https://developer.mozilla.org/en-US/docs/Games)
and hope to find some good prior art there. I'll continue to lurk and
ask stupid questions in the elm-lang Slack. There's a long way to go.

🍂 Mark

[strange-loop-b0rk]: https://www.youtube.com/watch?v=HfD9IMZ9rKY

[strange-loop-tulip]: https://www.youtube.com/watch?v=lvclTCDeIsY

[strange-loop-pointfree]: https://www.youtube.com/watch?v=seVSlKazsNk

[elm-conf-talk]: https://www.youtube.com/watch?v=DSjbTC-hvqQ

[rect]: https://github.com/mwunsch/hive-city/commit/b0005725845e424b9cab6531d64a8c85740ada29

[fighter]: https://github.com/mwunsch/hive-city/commit/5b81d3e7a43eb9e308687363ab274e96c4674fc6

[circle]: https://github.com/mwunsch/hive-city/commit/e08fef231cc19379c430796260bcc752bd5361c4

[deselect]: https://github.com/mwunsch/hive-city/commit/7afbab4d2f0b1016dd2864bd23e50d841d8815cf

[movement]: https://github.com/mwunsch/hive-city/commit/3f22d1899ec9c9856db26bd54006357ce216c389

[onwithoptions]: http://package.elm-lang.org/packages/elm-lang/html/1.1.0/Html-Events#onWithOptions

[svg-coordinates]: https://msdn.microsoft.com/en-us/library/hh535760(v=vs.85).aspx

