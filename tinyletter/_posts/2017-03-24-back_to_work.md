---
title: The Programs of the First Week of Spring
message_id: <onby31.22elqhlw4myuz@markwunsch.com>
---

This Week's Program: Mar 20 - Mar 24
====================================

Last week, I abstained from committing code, and I didn't send my
Tinyletter. Without going into too much detail, I had some health
issues. One thing I really learned to appreciate last week was how
talented folks in the medical field are. I have a new-found respect
for the systems and machinery of health care.

In the spirit of that experience it seems fitting to once again
shout-out [Professor Matt Might](http://matt.might.net). Prof. Might,
if you recall from [a previous letter][previous-letter], is somewhat
responsible for pushing me over the edge to trying out Racket. He
recently [announced][matt-might] that he is switching his area of
focus from Computer Science to Medicine. That's really amazing. I'm
glad to know that there's _real_ leadership from computer science and
software engineering working to advance medicine and health care.

Putting my mind back to code has helped me recover and get back to
normal. In addition to having a strong week in **Racket**, I also gave
an introductory talk about **Elm** to the folks
at [Code Driven NYC](http://firstmarkcap.com/driven/code-driven/). The
video of that talk will be released soonish, but in the meantime you
can check out [my slides][slides] and this [Gist][gist] of Elm
boilerplate code.

Catching back up
with [`overscan`](https://github.com/mwunsch/overscan/), I had left
off writing some new Racket FFI bindings for *GObject Introspection*
(`libgirepository` aka _GIR_).

## [36d993a9bd1151b2466ebf11334beef0ad339fcd][direction]

I wire up the bindings to get information on function argument
_direction_ in C. Call by reference interfaces in C are really common,
and so it's important to know when passing in arguments what direction
to expect data to flow. GIR has ways to detect this, and when invoking
a function via introspection, you must separate out the "inbound"
functions and the "outbound" functions.

## [61fee2f45d911df25b8b97a8da1182019c42178d][gi-argument]

I'm inching closer and closer to being able to invoke a function using
my GIR library. The next step is to model out `GIArguments` which is
a [C union](https://en.wikipedia.org/wiki/Union_type) that is used for
function invocation. I have to convert Racket arguments to a C
function to this union type, and use this to convert the return type
of the C function back to a suitable Racket value.

In this commit I define the FFI for GIR function invocation:

    (define-gir g_function_info_invoke
        (_fun _gi-base-info _pointer _int _pointer _int (r : _pointer) (err : (_ptr io _gerror-pointer/null) = #f)
        -> (invoked : _bool)
        -> (if invoked r (error (gerror-message err)))))

That's a little much, and I'll be refining this…

## [d67ddd1a0b8ff77dee6e2c20c6622d37095332b5][giarg-list]

Like so:

    (define-gir g_function_info_invoke
        (_fun _gi-base-info
            [inargs : (_list i _gi-argument)] [_int = (length inargs)]
            [outargs : (_list i _gi-argument)] [_int = (length outargs)]
            [r : _pointer]
            (err : (_ptr io _gerror-pointer/null) = #f)
            -> (invoked : _bool)
            -> (if invoked r (error (gerror-message err)))))

Here you can get a better sense of what the arguments to this function
are doing. I've changed this so that instead of passing C array
pointers around, I can pass a Racket list of `_gi-argument` into the
function and everything will just work. Previously, I had to
explicitly pass the length of the array storing the arguments. Now
that's computed on the fly.

## [3e3d24339ed8789b48cd66476888d0a6ddcbcb17][invocation]

Breakthrough! I invoke a C function through my Racket FFI library for
GObject Introspection! This is really rough, and only works for cases
where a C function has only inbound arguments (versus
call-by-reference style outbound arguments). I convert the argument
type that GIR tells me I get to the union type, and then do the
reverse on the return type of the function invocation.

Now I can call something like this in the REPL:

    (((introspection "Gst") "version_string"))

And get back:

    "GStreamer 1.10.3"

The next several commits afterward refine this further. This code is
still sloppy, and I'm still also trying to figure out what the best
API for all this ought to look like. Strings and parens are fun and
all but we can do better.

Time to look at Racket Macros. I've been pouring over Greg
Hendershott's [Fear of Macros][fear-of-macros], which is an excellent
introduction to the topic. Macros might be overkill (they usually
are), but I think I have a pretty good use case in mind. In the
meantime, I'm still slowly reading through the Racket Guide, but now
I've been consulting the much
denser [Reference](https://docs.racket-lang.org/reference/) more
frequently.

Stay healthy,<br />
🏥 Mark

[previous-letter]: http://www.markwunsch.com/tinyletter/2017/02/niko.html

[matt-might]: http://www.uab.edu/medicine/news/latest/item/1411-white-house-strategist-to-lead-uab-s-personalized-medicine-institute

[slides]: https://speakerdeck.com/mwunsch/elm-in-theory-and-in-practice

[gist]: https://gist.github.com/mwunsch/99e70f774a9f065bac778aed505d4f9b

[direction]: https://github.com/mwunsch/overscan/commit/36d993a9bd1151b2466ebf11334beef0ad339fcd

[gi-argument]: https://github.com/mwunsch/overscan/commit/61fee2f45d911df25b8b97a8da1182019c42178d

[giarg-list]: https://github.com/mwunsch/overscan/commit/d67ddd1a0b8ff77dee6e2c20c6622d37095332b5

[invocation]: https://github.com/mwunsch/overscan/commit/3e3d24339ed8789b48cd66476888d0a6ddcbcb17

[fear-of-macros]: http://www.greghendershott.com/fear-of-macros/index.html
