---
title: The Programs of the Week of the Anniversary of this Tinyletter
message_id: <oeoqmk.3udnqnl4m4j1@markwunsch.com>
---

This Week's Program: Oct 3 - Oct 7
==================================

One year ago, on October 2, 2015, I sent out
[the first _This Week's Program_][joaquin] email. Along with my coding
streak, I've made a habit of weekly writing and publishing. Thank you
to everyone reading along each week. Here's some stats:

+ I've sent **55 emails** (that includes this one).
+ As of this writing I have **96 subscribers**, including me. Thanks
  to each and every one of you.
+ I've gotten **13 replies**. I would love if more of you told me what
  you think or what you're working on.
+ My very first email had **28 recipients**.

In my tinyletters I've written about my explorations in
**CoffeeScript**, **Emacs Lisp**, **Ruby**, **CSS**, **Clojure**,
**JavaScript**, **Bash**, and now **Elm**.

Most of my emails are written in Emacs and published over SMTP to
Tinyletter.

    $ find tinyletter/_posts -type f | wc -l
        51

That's a lot of _content_! I'm toying with the idea of also doing some
publishing over on Medium.com. Let me know if you that would be a
better venue for you to consume my _content_.

## [7e8eea7654e796b667372575b44c5516cd9eb93b][model-view]

I move the `view` concerns of the `Model` into the `Model`
module. This is that Elm Architecture at work. I also set up a few
things here for the work on movement within the game. `remainingMove`
will show how much a model can move within the turn. `attemptMove`
returns a `Result` and the idea here is that a player can intend to
move to a particular point, but if the model is unable to move there,
you get the Error type. Right now, this doesn't do much of anything.

## [ecfdf43589ea85218c16d2089b6e887afafe6eef][ignore-elmjs]

I'm still getting a feel for what a good Elm workflow looks like in
Emacs. I find myself very frequently compiling a file with `C-c C-c`
to check my Types. This will produce an artifact `elm.js`. I tell git
to ignore it, because I'm sick of seeing it in my working
directory. There's probably a better way of dealing with this
transient artifact but this works just fine.

## [4a2532d2d641482ea307b12a4656a739d64a12be][elm-arrows]

I make the arrows in Elm (`->`) look cosmetically like a real arrow
(`→`) with Emacs. This is very important…

## [808052c83f9e3d6daf6ccb0292451aeb02734417][movement-intent]

Here, I add some new state: a `movementIntention`. This is a position
on the Tabletop where the Player intends to move a Model. I listen for
movement events from the mouse, and when a Model is selected, I draw a
line in `movementView` from the Model to the player's mouse.

## [9ab7bb5c4247dfb4db8502100fc720c2791e4be6][mouse-position]

The clever bit of JSON decoding code I was so proud of last week?
Turns out Elm had it the whole time, in `Mouse.position` (lowercase
position).

## [552e81926d5ee17d90dd23765d3dd971b05b0577][distance]

I add a Tabletop function to measure the distance between two
positions on the board. Measuring tape plays a big role in tabletop
wargaming.

## [4904dd3bc5f328a844b7ad441aebb71f0e3e52ed][allowed-movement]

I change all the Tabletop types to operate on `Floats` instead of
`Ints`. I add a new function to the Tabletop:
`positionFromDirection`. Given starting and ending positions, we can
calculate the distance. Given a smaller distance, this function will
find the point on that distance on the line. I use this to find the
Model's `maxAllowedMovement` position. The model can only move up to
their maximum movement in any direction. I draw a white line to show
their movement, and a grey line to show excess. This gives the effect
of the measuring tape. Here's another animated gif to illustrate:

!["Animation of maximum allowed movement in Hive City"][movementgif]

It took me forever to figure out the math for this. I am so bad at
geometry. I am a gamedev poseur of the lowest depths.

Thanks for subscribing! Let's see if I can keep this going for another
year!

– Mark

[joaquin]: http://tinyletter.com/wunsch/letters/the-programs-of-the-week-of-hurricane-joaquin

[model-view]: https://github.com/mwunsch/hive-city/commit/7e8eea7654e796b667372575b44c5516cd9eb93b

[ignore-elmjs]: https://github.com/mwunsch/hive-city/commit/ecfdf43589ea85218c16d2089b6e887afafe6eef

[elm-arrows]: https://github.com/mwunsch/emacs.d/commit/4a2532d2d641482ea307b12a4656a739d64a12be

[movement-intent]: https://github.com/mwunsch/hive-city/commit/808052c83f9e3d6daf6ccb0292451aeb02734417

[mouse-position]: https://github.com/mwunsch/hive-city/commit/9ab7bb5c4247dfb4db8502100fc720c2791e4be6

[distance]: https://github.com/mwunsch/hive-city/commit/552e81926d5ee17d90dd23765d3dd971b05b0577

[allowed-movement]: https://github.com/mwunsch/hive-city/commit/4904dd3bc5f328a844b7ad441aebb71f0e3e52ed

[movementgif]: http://www.markwunsch.com/img/hive-city-movement2.gif
