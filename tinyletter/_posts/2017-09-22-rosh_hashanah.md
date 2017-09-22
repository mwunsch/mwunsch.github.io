---
title: The Programs of the Week of the Jewish New Year
message_id: <owp71r.6556xc3yafx4@markwunsch.com>
---

This Week's Program: Sep 18 - Sep 22
====================================

Happy Friday and _Shanah Tovah_! Last week I dipped my toe in the
waters
of [OOP](https://en.wikipedia.org/wiki/Object-oriented_programming)
and this week I dove in like an apple into honey on a sweet new year.

If you recall, I've been stuck on this dilemma. I'm binding a bunch of
Object-oriented C code to Racket. I want this Racket code to be
idiomatic and follow typical Racket conventions. But Racket is a
_Lisp_. It's got _lambda_. How to I bridge the Object-oriented GObject C
code with Racket and not lose something in translation?

I've been orbiting Racket's own
Object-oriented
[faculties](https://docs.racket-lang.org/guide/classes.html) for some
time. Last week I finally had an a-ha moment and created a few
different things: `prop:gobject` and `gobject?` — mechanisms for
extending Racket types to behave like C pointers to GObjects, and the
`gobject<%>` interface and the `gobject%` class to bridge the world of
GObjects with Racket's own OOP tools.

Why go through this whole rigmarole? Well eventually I know I'll want
to bring
the [Racket Drawing Toolkit](https://docs.racket-lang.org/draw/) into
Overscan, and that uses a lot of Racket's OOP _stuff_. Feels like it
will reduce cognitive load to just stick with one OOP system.

This week, I jumped back into my GStreamer module and rewrote some of
the code around GStreamer Elements to use some of this new thinking.

Oh, and in case you were wondering, I'm pronouncing "gobject" with a
hard _g_, like "goblin". Not "jee object" and not "jobject" (although
that sounds funny too).

## [f0be0a1f67859f56d0677290efbc92d8413b9b7b][elfac]

The first thing I do is move the `element%` and `element-factory%`
gi-objects to be classes that implement `gobject<%>`.

## [4337bceb4fe3cb89596a955b079f725e84e68d1c][inherit-field]

Then I define methods on those. I also create two factory functions:
`element-factory%-find` and `element-factory%-make` which are facades
to the GStreamer factory functions. I also do a thing like
`get-metadata`, which combines two different C function calls into one
to provide a good interface. Objects can be good!

## [d210dbe6699394eca8e2bead2c7d7779825b738c][make-gobject-delegate]

I create a new macro. Originally called `define-gobject-mixin`, in
this commit I rename it to `make-gobject-delegate`, which is a little
bit more descriptive. This will create a `mixin` in Racket, and is
designed to quickly define methods that should just delegate to the
underlying C implementation. So:

    (make-gobject-delegate get-name get-factory)

Will create a mixin around a `gobject<%>` that defines two methods
called `get-name` and `get-factory` that delegates their arguments on
to the gobject method. In short, it means I don't have to type as
much.

After this I write a bunch more
documentation. Here's
[`make-gobject-delegate`][make-gobject-delegate-docs].

Next week, more GStreamer bindings with new OOP power.

🍎🍯 Mark

[elfac]: https://github.com/mwunsch/overscan/commit/f0be0a1f67859f56d0677290efbc92d8413b9b7b

[inherit-field]: https://github.com/mwunsch/overscan/commit/4337bceb4fe3cb89596a955b079f725e84e68d1c

[make-gobject-delegate]: https://github.com/mwunsch/overscan/commit/d210dbe6699394eca8e2bead2c7d7779825b738c

[make-gobject-delegate-docs]: http://www.markwunsch.com/overscan/gobject-introspection.html#%28form._%28%28lib._ffi%2Funsafe%2Fintrospection..rkt%29._make-gobject-delegate%29%29
