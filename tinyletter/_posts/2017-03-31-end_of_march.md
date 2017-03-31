---
title: The Programs of the Week Before April Fools Us
message_id: <onp10l.1wlv34basm0ze@markwunsch.com>
---

This Week's Program: Mar 27 - Mar 31
====================================

It's been a productive week! My commits this week felt all noodled
and scattered, but I'm really pleased with the direction the code is
taking.

Last week I hit the big milestone of calling into a C function from my
own little Racket `ffi/unsafe/introspection` library. This week has
been all about making sure my library's API is ergonomic and
expressive, and also do what it needs to do to work. This week I
finished reading the [Racket Guide][guide]. I feel pretty comfortable
working with Racket code and am now regularly referring to
the [Reference][reference] to get a better understanding of the
language and the standard library. Racket is an _interesting_
language, and I'm enjoying it. I miss some of the niceties of
**Clojure** (like its awesome destructuring), but am able to push
through and do some interesting things.

## [2034968dbad88402c0fcc30ae2caa4295f980586][define-syntax]

Look at this commit on Monday. On Monday I was such a foolhardy child,
thinking I could just plaster [Macros][macros] everywhere and they
would solve all my problems. `define-syntax` and its associated forms
are incredibly powerful tools and on Monday I thought they were just
the thing I needed to make my API sing! A typical young Schemer's
foolish mistake.

## [86236cd315f58b5830e81f6336482370c8e0d817][structs]

The problem with using Macros and `define-syntax` is that by the time
we have our FFI bindings, we're already passed that phase of the
program. It's runtime! Past the point of manipulating
syntax. Everything I do here has to be done dynamically, which makes
sense since GObject Introspection is all about _dynamic_ interop.

So I have to find a way to make this code as expressive as
possible without manipulating the syntax to my bidding. The first
thing I do is reach for [`struct`][struct-guide]. Part of what
I'm struggling with is littering my API with anonymous lambdas
that have no real useful metadata associated with them. I want to
have handy mechanisms for understanding the C pointers and types
I'm getting back. This is a convenience that the
previous [`gir`](https://github.com/Kalimehtar/gir) library just
doesn't have.

In this commit I do things like
use [`procedure-rename`][procedure-rename] to add some affordances to
my code. And I use `struct`. Little did I know how powerful Racket's
`structs` are…

## [ccb4287ddc56a106de511980913a5d134e4a880f][prop:procedure]

Racket has something called [Structure Type Properties][structprops]
that allows a structure type to behave like some _other_ thing. An
awesome example of this is
the [`prop:procedure`][structprop-procedure] property. This property
allows a `struct` to behave like a lambda! This is perfect for
something like GObject Introspection functions where you want to
encapsulate parts of the function, but then also want a convenient way
to invoke the function. That's exactly what I do here.

For most of the remaining commits, I use `structs` and
`prop:procedure` to make my API clean, implementing some of the other
parts of GIR. I also reorganized the code and tried to group things
according to what kind of type they were associated with.

## [964d02fada017e1dde828fc139ccd85e3fa03053][prop:cpointer]

It was when I was wiring up method calls
for [`GIStructInfo`][gistructinfo] that I had my next aha
moment. Methods are a special kind of function in that their arity
reports as one less than what they really are. The first argument to a
method is implicitly a pointer to the object or struct that owns the
method. In order to call a method dynamically with GIR, I need to pass
in a pointer to a caller.

Racket's FFI library includes a Structure Type Property
called [`prop:cpointer`][structprop-cpointer] that allows a struct to
"be used transparently as a C pointer value". That means I can have my
`struct` representing C types and just pass instances of those around
as pointers to their same types. Some real Racket/C interop going on
here. This might not sound like much, but it helps me unify my API in
a major way.

## [9995465df90e23204dc733d414a47d8976d4f8a8][gi-base]

This leads us here. I now have a uniform way of dealing with GIR
information types. Every Introspected type is represented by a
`struct` that has properties that allow it to behave both as a
procedure and as a pointer for a C type. When called as a
procedure, each type behaves slightly differently. A GI Function
will invoke its function. A GI Constant will return its value. A
GI Struct will take a method name and return a GI Function ready
to be invoked.

## [168d7f6fac5babc430c5c748a6c819111ff48509][gi-field]

In addition to providing this uniformity throughout the
interface, I also add in some convenient functions to see more
about the C types I'm working with.

For example, calling `describe-gi-function` on a function will
give me a string describing it's type and arguments. Like so, for
GStreamer's `init_check` function:

    init_check (gint32 argc, array* argv) → gboolean

Or for a Struct, like GIRepository's own `BaseInfo`:

    struct BaseInfo {
      gint32 dummy1
      gint32 dummy2
      void* dummy3
      void* dummy4
      void* dummy5
      guint32 dummy6
      guint32 dummy7
      array padding

      equal (BaseInfo* info2) → gboolean
      get_attribute (utf8* name) → utf8*
      get_container () → BaseInfo*
      get_name () → utf8*
      get_namespace () → utf8*
      get_type () → InfoType
      get_typelib () → Typelib*
      is_deprecated () → gboolean
      iterate_attributes (AttributeIter iterator, utf8* name, utf8* value) → gboolean
    }

What the heck is going on with those "dummy" fields? Who knows‽
All I know is that I can look at these C types within Racket now
and know what the heck they are!

I think I've got a few more weeks left working on my GIR lib
before I can say that it's good enough and I can move on to focus
on bindings for GStreamer.

Try not to get too wacky for April Fools!

🤡 Mark

[guide]: https://docs.racket-lang.org/guide/index.html

[reference]: https://docs.racket-lang.org/reference/index.html

[define-syntax]: https://github.com/mwunsch/overscan/commit/2034968dbad88402c0fcc30ae2caa4295f980586

[macros]: https://docs.racket-lang.org/guide/macros.html

[structs]: https://github.com/mwunsch/overscan/commit/86236cd315f58b5830e81f6336482370c8e0d817

[struct-guide]: https://docs.racket-lang.org/guide/define-struct.html

[procedure-rename]: https://docs.racket-lang.org/reference/procedures.html#%28def._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._procedure-rename%29%29

[prop:procedure]: https://github.com/mwunsch/overscan/commit/ccb4287ddc56a106de511980913a5d134e4a880f

[structprops]: https://docs.racket-lang.org/reference/structprops.html

[structprop-procedure]: https://docs.racket-lang.org/reference/procedures.html#%28def._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._prop~3aprocedure%29%29

[prop:cpointer]: https://github.com/mwunsch/overscan/commit/964d02fada017e1dde828fc139ccd85e3fa03053

[gistructinfo]: https://developer.gnome.org/gi/stable/gi-GIStructInfo.html

[structprop-cpointer]: http://docs.racket-lang.org/foreign/foreign_pointer-funcs.html#%28def._%28%28quote._~23~25foreign%29._prop~3acpointer%29%29

[gi-base]: https://github.com/mwunsch/overscan/commit/9995465df90e23204dc733d414a47d8976d4f8a8

[gi-field]: https://github.com/mwunsch/overscan/commit/168d7f6fac5babc430c5c748a6c819111ff48509
