---
title: The Programs of the Week the Winter Returned
message_id: <omm377.2vjfzwjozi7jz@markwunsch.com>
---

This Week's Program: Mar 6 - Mar 10
===================================

It's snowing in New York City right now. March is a month that always
seems deceptive.

Last week I hit a bit of a wall with
Racket's [GObject Introspection](https://github.com/Kalimehtar/gir)
library. _GIR_ is used to construct a language binding to a C library
that uses GObject conventions. It's really handy for my explorations
with GStreamer. The problem with the Racket GIR library seems to be
that when using objects, methods don't inherit from parent classes and
method return types aren't transformed into useful representations (or
they're the wrong representation).

The last commit on the `gir` library was an update to the `README` in
April of 2016. Before that the previous commit was in July of 2015. An
open pull request to the docs has been open since March of 2016. I
think it's fair to say that the project has been abandoned. So this
week I started a spike on my own GObject Introspection library within
`overscan`.

## [7e846551e4f09b86b9bad807b555e7208709c675][introspection]

The first thing I do is create a new file:
`ffi/introspection.rkt`. What will likely happen is that I'll move
this under `ffi/unsafe/introspection` but I'm still trying to get a
feel for Racket [collections][collections] and modules. We build up
our GIR library by first creating a FFI to `libgirepository`, which is
a C library for working with GObject Introspection Repositories and
Typelibs.

## [0329371c278d80e2f23d8349a36c4402e41ce7bb][find_by_name]

In addition to trying to understand _how_ to use the GIRepository
stuff, I'm also getting a better sense of using Racket and using
Racket's FFI. Specifically how to create Racket definitions of C
types.

`(introspect namespace)` returns a lambda that will then lookup a name
in that namespace.

## [5e8a914a44240a26a189138c8a42fa5e7d28219b][lambda-prettify]

I make sure in my Emacs configuration that typing _lambda_
"prettifies" to a λ character in Racket mode. Racket mode has a
special "unicode-input-method" that allows you to replace other
mathematical notation with unicode equivalents, but I found that kind
of intrusive.

This is all just to get me more productive in Racket from within
Emacs, where I can work on my code alongside a REPL.

## [f92f0efa7b3e0c78b2ca13fcaf6634520d2e5f80][infos]

Here, I look at a GIR namespace and construct a list of pairs of type
and name for every name in the repository.

Now I can look and see everything that the `Gst` (GStreamer)
repository contains. I can even do this for the `GIRepository`
namespace itself.

## [e8776c92d9ed42ec752951b2007ff88fa0a4dac8][gerror]

Here, I deal with the [`GError`][gerror-guide] type. In C, a function
that takes a `GError**` argument will set that pointer with an error
and that can be used as an exception message when that function enters
an error state. `ffi/unsafe` allows me to capture this pointer value
and if the function returns a false or null pointer, I can raise an
exception in the Racket process. This is a pattern I'll probably have
to get more comfortable with.

## [9c10e00b0b2ac687048ec1bf0975582d3fcaf548][callable_info]

Here I adjust my function
to [`case`](https://docs.racket-lang.org/guide/case.html) on the type
of the info I get back from GIR from a particular name. I start with a
`function`
type. A
[`GIFunctionInfo`](https://developer.gnome.org/gi/1.50/gi-GIFunctionInfo.html) type
represents a function that could be called. To get the most out of
this type you also have to work with `GICallableInfo`, `GIArgInfo`,
and `GITypeInfo` types.

The first step here is to get an understanding of all of the arguments
and types that the function expects, and what the function's return
type is.

## [80059c66e25cc04521a0173e7d67059347957209][formatargs]

After some renaming and some more function calls, we're left with an
API that will look up a function based on a name, and then print out a
string that represents the args that it needs and the type it returns:

    > ((introspection "Gst") "version_string")
    "fun () -> 'GI_TYPE_TAG_UTF8"
    > ((introspection "Gst") "init_check")
    "fun ('GI_TYPE_TAG_INT32 argc 'GI_TYPE_TAG_ARRAY argv) -> 'GI_TYPE_TAG_BOOLEAN"
    > ((introspection "GIRepository") "type_info_get_tag")
    "fun ('GI_TYPE_TAG_INTERFACE info) -> 'GI_TYPE_TAG_INTERFACE"

Cool! The next step is to actually construct a lambda that transforms
its arguments into the right C types to `invoke` this C function.

I'm still working through what the API of my GIR module should be,
then it'll be about learning enough Racket to be able to shape and
implement that API.

So much to learn!

– Mark


[introspection]: https://github.com/mwunsch/overscan/commit/7e846551e4f09b86b9bad807b555e7208709c675

[collections]: https://docs.racket-lang.org/guide/module-basics.html#%28part._.Library_.Collections%29

[find_by_name]: https://github.com/mwunsch/overscan/commit/0329371c278d80e2f23d8349a36c4402e41ce7bb

[lambda-prettify]: https://github.com/mwunsch/emacs.d/commit/5e8a914a44240a26a189138c8a42fa5e7d28219b

[infos]: https://github.com/mwunsch/overscan/commit/f92f0efa7b3e0c78b2ca13fcaf6634520d2e5f80

[gerror]: https://github.com/mwunsch/overscan/commit/e8776c92d9ed42ec752951b2007ff88fa0a4dac8

[gerror-guide]: https://developer.gnome.org/programming-guidelines/stable/gerror.html.en

[callable_info]: https://github.com/mwunsch/overscan/commit/9c10e00b0b2ac687048ec1bf0975582d3fcaf548

[formatargs]: https://github.com/mwunsch/overscan/commit/80059c66e25cc04521a0173e7d67059347957209
