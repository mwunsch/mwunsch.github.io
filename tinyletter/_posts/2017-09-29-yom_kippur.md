---
title: The Programs of the Week of Yom Kippur
message_id: <ox28xd.36p5srbk0q12c@markwunsch.com>
---

This Week's Program: Sep 25 - Sep 29
====================================

Happy Friday and _Gut Yuntiff_! Last week, I discussed the proper
pronunciation of "gobject" (with a hard _g_ as in _goblin_). It
occurred to me today that pronouncing it like the character Gob from
_Arrested Development_ would be quite funny as well — "jobe-ject".

This week I switched gears and moved deeper into the `gstreamer`
module, using some of the new functionality I've written in the
`ffi/unsafe/introspection` module that deal with bridging the world of
gobjects to the world of `racket/class`.

The result is an in-progress rewrite of the building blocks of
Overscan. I want to make a _good_ Racket binding for GStreamer that
feels like conventional Racket. Feels like I'm progressing toward that
goal.

## [c96c04aee8e5c83122bc9e74b7641365d52b83bb][gst-object]

With all the tools from the previous weeks at my disposal, I create
`gst-object%`. This is a subclass of `gobject%` that uses last week's
`make-gobject-delegate` for the heavy lifting. This class is the base
class for most of GStreamer's domain. Now it's provided as a nice tidy
Racket class, complete with a contract enforcing its method
boundaries. Contracts, in this case, are pretty important. Contracts,
if you recall, are a way to express assertions, and they're used a lot
throughout Racket for making easy-to-follow error messages. The reason
why I went through all that hullabaloo with the introspection module,
was so that I can bring the usage of GStreamer closer to what a
typical Racket developer would expect. Here's the first step of that!

## [f3350fff9f8218b45aaa50327a693493d7d74002][element]

And the second step has me rewriting `element%` and `element-factory%`
to inherit from `gst-object%`.

## [fa02cedede95af12635078f0ff77d8db12d2fdcb][instanceof]

Now here's a funny thing about writing contracts on classes: those
contracts are only enforced when they've been explicitly placed in the
entry point for dynamic dispatch. In other words, within the
_element.rkt_ module, those functions that return object instances
will not have their return values subject to a contract. This makes
the element & element-factory relationship particularly tricky. The
`element-factory%` class has methods that construct `element%`
instances. And `element%` has a method to retrieve the
`element-factory%` that constructed it. This is a recursive thing, and
can't easily be expressed with the contract system. Racket provides a
few different mechanisms for working with contracts to make this
easier, but the one I decided to reach for
was [`instanceof/c`][instanceof/c]. This lets me express that a
function should return a contract for a class where I would otherwise
not have access to the class itself, thereby making sure the contract
is in the path of dynamic dispatch.

Got all that? No? Yeah… I have a hard time explaining it. The main
thing to take away here is that contracts are good because they make
really useful error messages. It's important the contract is applied
when you need the value to be checked.

## [e4bc050da879207f85cbc37c687bfa7d8dc77ade][gi-enum-value]

I write my own contract. `gi-enum-value/c` is a contract that accepts
an introspected Enum and recognizes its values.

## [01ac7888ad6ebe7d7400b2e984d69c56fd174cfb][contracts]

Here's even more contracts on GStreamer objects! No invalid data EVER!
`pad%` and the spookier `ghost-pad%`!

## [8eac317d67177c4718bbd0302d2a85d619d7233c][link-many]

Recursion and OOP!

## [87ba946b29bee9123f4efa232f3345b53ec4dd0f][bin]

The `bin%` is back, with the new OOP powered factory function,
`bin%-compose`!

The rewrite of the GStreamer module is now well under way and I've got
a bunch of ideas here. I can't wait to get back into Overscan, but I'm
happy to be making progress on something that might see a ton of
utility outside of Overscan itself.

— Mark

[gst-object]: https://github.com/mwunsch/overscan/commit/c96c04aee8e5c83122bc9e74b7641365d52b83bb

[element]: https://github.com/mwunsch/overscan/commit/f3350fff9f8218b45aaa50327a693493d7d74002

[instanceof]: https://github.com/mwunsch/overscan/commit/fa02cedede95af12635078f0ff77d8db12d2fdcb

[instanceof/c]: https://docs.racket-lang.org/reference/Object_and_Class_Contracts.html?q=racket%2Fclass#%28def._%28%28lib._racket%2Fclass..rkt%29._instanceof%2Fc%29%29

[gi-enum-value]: https://github.com/mwunsch/overscan/commit/e4bc050da879207f85cbc37c687bfa7d8dc77ade

[contracts]: https://github.com/mwunsch/overscan/commit/01ac7888ad6ebe7d7400b2e984d69c56fd174cfb

[link-many]: https://github.com/mwunsch/overscan/commit/8eac317d67177c4718bbd0302d2a85d619d7233c

[bin]: https://github.com/mwunsch/overscan/commit/87ba946b29bee9123f4efa232f3345b53ec4dd0f
