---
title: The Programs of the Week of a Supermoon
message_id: <ogunb4.30lugw5in98za@markwunsch.com>
---

This Week's Program: Nov 14 - Nov 18
====================================

I hope everyone got a chance to look at this week's Supermoon, the
biggest in 60+ years. It was really something. We won't see a moon
like this for another eighteen years. I found this quote on a
[blog](http://www.astropix.com/Supermoon_20161114.html) while reading
about the Supermoon:

> The term "Supermoon" was originally coined by an astrologer, but the
> general public and the media, unable to distinguish fact from
> fantasy and seeking any escape possible from the futility,
> meaninglessness, and ultimate tragedy of their existence, became
> infatuated with the superness and hyperbole of the name, even though
> perigee full moons occur fairly frequently.

"Escaping from the futility, meaninglessnes, and ultimate tragedy of
existence," you say? Well let me tell you about the progress I'm
making on my computer game…

## [9424f6c83cd339e736464cec888ad540380b3838][maxrange]

A weapon has a maximum range. With destructuring in Elm, it's pretty
simple to get at that maximum. Weapons in Necromunda have both a short
and a long range, which I represent as a pair of Pairs with the
`Ranged` type. To get the maximum, I destructure like so:

    Ranged (_, _) (_, max)

And now `max` is the maximum range of a weapon. With the shoot action,
I use the `Tabletop.viewMeasuringTape` function to draw a line from
the shooter to the maximum range.

## [c156b6c1ea822b450bb244b940a2baf59f1ee069][elm18]

[Elm 0.18](http://elm-lang.org/blog/the-perfect-bug-report) was
released this week. With it comes a new debugging mode for importing
and exporting a sequence of events in a program, which is really
cool. But some syntax was removed and libraries reorganized and it
meant I had to do a fair bit of work. Luckily the Elm folks made an
easy to follow
[migration guide](https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md). I'm
okay with these changes, but I have to admit I liked the backtick
syntax that let you use functions as infix operators. I had that with
`Tabletop.by` and frequent use of `Random.andThen`.

## [e45beeaebbe18916281919f1a5e2564919832ac6][angle]

Most of this week was spent re-learning basic geometry. Here I find a
new point given another point, and angle, and a length. I know that
[_polar coordinates_](https://en.wikipedia.org/wiki/Polar_coordinate_system)
are a thing, but I'm not very comfortable with using that just yet.

## [ebfe0a105f350beaba27ef0e78a59f294f2e9ee3][viewarc]

Here's my first stab at drawing an arc of sight for a weapon. From the
Necromunda rule book:

> The fighter is always assumed to face in the direction faced by the
> model itself, and is able to see within a 90 degree arc to his
> front.

Get out of here with that gendered language, Necromunda rulebook. One
of Necromunda's Hive City Houses is the
[House of Escher](http://wh40k.lexicanum.com/wiki/House_Escher), which
is all female. You'll be able to play a House Escher gang in
`hive-city` assuming I ever finish this game...

Anyway, using my poor geometry, I draw this arc. Using the previous
comit to find a new point at the maximum range of the weapon, and then
find new points out from either side at 45 degrees. I think this is
right.

This isn't really an arc though. It's a triangle.

## [5dd204366fc8f608583f483724602f1b7adf8247][path]

I revise my `viewArc` function to use an SVG
[`path`](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths)
element. This lets me draw an actual arc. I'm also learning more about
polar coordinates and so I might revise this further down the line.

## [ffa7cc09fef2d1b067e6f96612dd9f8d59a1a4ea][filterrange]

Now I need to make sure that you can only target and shoot at models
within the arc of sight and within the range of the weapon. I punt on
the "within arc of sight" part of that, and create a function:

    withinShootingRange : List Model -> Model -> Weapon -> List Model

This function signature says that given a list of model, a single
model, and a weapon, return a list of models. This function will take
the list of all the models, the shooter, and the weapon used, and will
filter down the list to only include the models within the maximum
range of the weapon.

This week, this blog post appeared:
[_Not Your Problem_](http://howtomakeanrpg.com/a/not-your-problem.html). It's
about the _real_ problems in game development outside of the high-tech
fancy problems. "Expert problems are not your problems," it says. I
liked this blog post quite a bit, especially as I'm dealing with such
non-expert problems as how to draw a simple arc.

I have to admit, I'm getting a little bit burnt on this project. I now
feel comfortable in the Elm programming language, which was one its
explicit goals. I know what I like about it and the challenges in
building software for it. I've learned a whole lot about SVG. I've
learned a small slice of game development. I find that I'm not solving
the problem of making the game, but also that of building a game
engine in a very young language and toolset, which is fine, but has
diminishing returns on my attention. The completionist in me wants to
see `hive-city` through to some conclusion, but I also feel tugged in
other directions. I know what I want to do after `hive-city` and I'm
anxious to start on _that_. I know that I am really fascinated with
gamedev stuff but I want to try a more powerful and mature set of
tools, like Unity. I'm going to continue to pour energy and work into
`hive-city`, but I think this project might not come with me
into 2017. Would love to know what you think. Has reading about this
project been interesting to you?

I am also somewhat resolved that I want to participate in this year's
[Ludum Dare](http://ludumdare.com/compo/), which is coming up _fast_.

This week, I also want to wish a very Happy Birthday to my wonderful
and amazing wife _Vera_, who is my most devoted reader and my closest
collaborator. Thank you for your encouragement, your friendship, and
your love.

🌕 Mark

[maxrange]: https://github.com/mwunsch/hive-city/commit/9424f6c83cd339e736464cec888ad540380b3838

[elm18]: https://github.com/mwunsch/hive-city/commit/c156b6c1ea822b450bb244b940a2baf59f1ee069

[angle]: https://github.com/mwunsch/hive-city/commit/e45beeaebbe18916281919f1a5e2564919832ac6

[viewarc]: https://github.com/mwunsch/hive-city/commit/ebfe0a105f350beaba27ef0e78a59f294f2e9ee3

[path]: https://github.com/mwunsch/hive-city/commit/5dd204366fc8f608583f483724602f1b7adf8247

[filterrange]: https://github.com/mwunsch/hive-city/commit/ffa7cc09fef2d1b067e6f96612dd9f8d59a1a4ea
