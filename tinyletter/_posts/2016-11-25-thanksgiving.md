---
title: The Programs of Thanksgiving Week
message_id: <oh7pxk.1a73rjg1njjwb@markwunsch.com>
---

This Week's Program: Nov 21 - Nov 25
====================================

Happy Thanksgiving! I hope you are sufficiently filled with food and
thanks and holiday spirits. Maybe you can't get to this email in your
inbox right away because you are out there hustling those sweet, sweet
deals for Black Friday. There is so much to be thankful for this
Thanksgiving. A difficult and challenging year shines a light on the
things that truly matter. Thank you for reading this TinyLetter and
letting me be a part of _your_ Holiday routine.

[Last year](http://www.markwunsch.com/tinyletter/2015/11/thanksgiving_week.html)
at this time, I called out some people that I am thankful for. That's
a tradition that I can get behind!

+ [Evan Czaplicki](https://youtu.be/oYk8CKH7OhE), the author of Elm.
+ [John Holdun](http://johnholdun.com/themed-entertainment/), my
  friend and colleague who is building
  [_dark rides_](https://en.wikipedia.org/wiki/Dark_ride) in New York
  City. I got the pleasure of seeing his first this Halloween. He's
  been writing a TinyLetter about his approach and progress and I'm so
  looking forward to his next one. He helped me with some geometry
  this week.
+ [Casey Kolderup](http://tinyletter.com/backtracks), my friend and
  not-frequent-enough collaborator. He's writing a TinyLetter with
  music recommendations as a spin-off to his
  [Backtracks](http://backtracks.co) service. Casey has been a huge
  influence and help in my projects.
+ [Pasquale D'Silva and Jacob Bijani](http://www.thinko.co) have
  recently formed a new company, Thinko, and are currently looking for
  clients and consulting projects. The two of them are immensely
  talented and I've been following their work for some time. Their
  game, [OK Dracula](http://okdracula.com), is something I'm really
  looking forward to playing.

## [78e1166cf4b7c967b4818ab6901b9b08a4f1400c][withinShootingRange]

The thing I worked on this week is trying to find the closest Model
within shooting range of a fighter. My first take did not work.

## [a58367eb5e5725549f4fdbba61e3815908e0063a][isWithinArc]

After consulting some friends of mine and the Elm-Lang Slack, I
finally got a working solution to this. Here's the problem: given an
arc (or a pie slice within a circle), find if a point is within that
arc. Seems like what should be pretty basic Geometry but I was really
stumped. Here's what I did to get this working:

+ I convert all angles in the `Tabletop` module to use radians, which
  is the default used throughout Elm. Only when it's time to render do
  I convert this to degrees for the purposes of SVG.
+ I make a new function, `translate`, which will just make an absolute
  point relative to an origin point.
+ I make a new predicate function in the `Tabletop` module,
  `isWithinArc`. I `translate` and convert the points in the arc to
  [polar coordinates](https://en.wikipedia.org/wiki/Polar_coordinate_system). It's
  then easy for me to compare the angles of the different points from
  the origin (or where the shooter is located).
+ Here's the tricky part: if the arc's start angle is less than the
  end angle, I can just see if the position I'm checking is within
  that. If the end angle is greater than the start angle, that means
  that I've gone around an axis and things are inverted. The thing
  that was throwing me off here is the use of `xor` to say "one of
  these must be true": either the start angle is less than the
  position angle, or the position angle is less than the end angle.
+ I use polar coordinates a little bit more throughout the `Tabletop`
  module and introduce `makeAbsolute`, the reverse of `translate`. I
  also introduce an `Arc` type to allow the type checker to be more
  involved in excluding edge conditions.
+ `withinShootingRange` is now a pipeline of filtering operations: The
  model can't also be the shooter, the model must be within the weapon
  range, and the model's position must fall within the arc.

After some variable renaming I'm able to determine what models are in
range of a weapon.

!["Hive City weapon range arc"][gif]

I _think_ this is a very simplified form of
[_ray casting_](https://en.wikipedia.org/wiki/Ray_casting).

## [ea1f24cbb214ead926b7b4fed6a33494ce118bd1][closest]

I add one more List operation to my pipeline: A `List.sortBy` to sort
the models within the arc by distance from the shooter. Calling
`List.head` on this list will give us a `Maybe Model` that is the
closest model in shooting range (or `Nothing`). That's the Model that
can be targetted.

## [3710d5e769b5929e94fbd25a5942ae8a54009fe9][closestModel]

I move some of this logic into the `Player` module function
`Player.getClosestModelInWeaponRange`. This function takes a `Player`
and a `Weapon` and returns a `Maybe Model`. Now I can shoot it.

🦃 Mark

[withinShootingRange]: https://github.com/mwunsch/hive-city/commit/78e1166cf4b7c967b4818ab6901b9b08a4f1400c

[isWithinArc]: https://github.com/mwunsch/hive-city/commit/a58367eb5e5725549f4fdbba61e3815908e0063a

[gif]: http://www.markwunsch.com/img/hive_city_nov22.gif

[closest]: https://github.com/mwunsch/hive-city/commit/ea1f24cbb214ead926b7b4fed6a33494ce118bd1

[closestModel]: https://github.com/mwunsch/hive-city/commit/3710d5e769b5929e94fbd25a5942ae8a54009fe9
