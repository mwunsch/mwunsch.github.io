---
title: The Programs of a Very Spooky Week
message_id: <oxrzwl.12xxaogn5gb11@markwunsch.com>
---

This Week's Program: Oct 9 - Oct 13
===================================

It is Friday the 13th! The spookiest, scariest thing about this is how
unseasonably warm this October has been in NYC. I am a creature of
autumn weather and there has been far too little fall this fall.

Last week, I missed an important milestone!

Two years ago, on October 2, 2015, I sent out the first _This Week's
Program_ email! **Happy belated two year anniversary to this Tinyletter!**

The stats:

+ I've sent **105 emails** (including this one).
+ As of this writing I have **100 subscribers**, including me. That is
  4 more subscribers than last year. I think I need some _growth
  hacking_. If you subscribe and enjoy reading This Week's Program,
  maybe tell your programmer friends!

Over the course of all my Tinyletters I've written about explorations
in: **CoffeeScript**, **Emacs Lisp**, **Ruby**, **CSS**, **Clojure**,
**JavaScript**, **Bash**, and **Elm**. This year I've written about
working with **D3.js**, **ECMAScript 6**, **Ansible**, and my current
project, _Overscan_: a curious blend of **Racket** and **C**.

That's so much content. Thank you, friends, for opening your inboxes to me
for the past two years.

Now, on to the spooky code I've written.

This week, I'd like to focus on one bug — or rather, some _unexpected
behavior_ that I encountered when working through building out the
GStreamer code.

## [a66b038b8dddf68fa9902bce930be20a2c95c559][args-values]

Let's take a look at this GStreamer C
function: [`gst_element_get_state ()`][gst_element_get_state].

This function is defined as so:

    GstStateChangeReturn
    gst_element_get_state (GstElement *element,
                           GstState *state,
                           GstState *pending,
                           GstClockTime timeout);

The first argument is a pointer to an Element. Through the lens of
GObject Introspection, this is the _self_ argument. My introspection
library is smart enough so that you don't need to include it. When
mixed through all the layers of Introspection, you can consider this
the `get_state` method of the `Element` class, and the first argument
is passed implicitly when invoking the method.

The next two arguments, `state` and `pending`, are pointers to a value
of the State enum. These pointers are used for the purposes of
pass-by-reference mutation. I've written about this a bunch in past
newsletters. GObject Introspection marks arguments to functions with a
direction: `in`, `inout`, or `out`. The `inout` and `out` arguments
are used for the purposes of pass-by-reference: you pass in a pointer,
and when the function returns, that pointer will be pointing to some
new value.

The final argument is a ClockTime (an alias to an unsigned integer) to
be used as a timeout to this function.

This function returns a StateChangeReturn value.

When you set the state of an element, the response you'll usually get
back is a StateChangeReturn that might tell you `async` — meaning, the
state change is happening asynchronously. When you call `get_state`,
the return result tells you if the last state change you made was
successful or is still processing, but the _true_ data you're probably
interested in comes from the two state pointers that you passed by
reference: The first pointer tells you what state the element is
currently in, and the second tells you what state the element is
moving to if the state change hasn't happened yet. The whole of the
information this function returns is in these three values.

This function call was just not working with my introspection
code. The commit above fixed this.

### What was happening

In my GObject Introspection binding code, every introspected function
is represented as a `gi-function` struct, which can be called as a
procedure. The procedure does some clever things around arity. Namely,
any argument that is decorated as an `out` argument should not be
passed in — the introspection code will malloc a pointer of the
appropriate size, set it to NULL, and pass that in. All outbound
pointers are de-referenced and returned along with the return value of
the function, because Racket is baller and
has [multiple return values][multiple-return-values], which are a
great way to represent exactly the kind of thing that `get_state` is
doing.

Here's the relevant chunk of the _before_ code in this implementation:

    (define args+values
            (let* ([arglength (length args)]
                   [arguments (if (and method? (pair? arguments))
                                  (cdr arguments)
                                  arguments)]
                   [vals (append arguments (make-list (- arglength (length arguments)) #f))])
              (map (lambda (arg val)
                     (cons arg
                           (if (eq? (gi-arg-direction arg) 'out)
                               (ctype->_gi-argument _pointer
                                                    (gi-type-malloc (gi-arg-type arg)))
                               (arg val))))
                   args
                   vals)))

This `args+values` definition forms a list of pairs of arguments
anticipated by the underlying C function and the values that
correspond to those arguments. In that initial `let*` statement you'll
see a reference to `args` and `arguments`. This is bad naming on my
part: `args` are a list of the introspected arguments of the C
function; its _formal parameters_. `arguments` are the list of values
passed in to the Racket function.

Here's where the bug came from: where the length of the `args` list
and the `arguments` list didn't match, the `vals` just appended NULL
pointers until they did. This code makes the assumption that `out`
arguments will always appear as the last arguments in the parameter
list. That is incorrect!

Here's the updated code:

    (define-values (args+values vals)
            (for/fold ([res null]
                       [vals (if (and method? (pair? arguments))
                                 (cdr arguments)
                                 arguments)])
                      ([arg (in-list args)])
              (values (reverse (cons
                                (cons arg
                                      (if (eq? (gi-arg-direction arg) 'out)
                                          (ctype->_gi-argument _pointer
                                                               (gi-type-malloc (gi-arg-type arg)))
                                          (arg (car vals))))
                                res))
                      (if (eq? (gi-arg-direction arg) 'out) vals (cdr vals)))))

Here, instead of appending NULL values to the end of the arguments
list, and then mapping over the two lists, I
use [`for/fold`][for/fold] to _fold_ (aka _reduce_) the lists of
arguments and args so that when an `arg` is encountered that is an
`out`, the arguments list is ignored and a NULL pointer is put in that
place for the value.

As you can see, I use quite a bit of `cons` to get this set up. `cons`
is the big-fucking-hammer function for lists in Racket/Scheme: it is
how all other list functions are wrought, and it's also inelegant and
clumsy. I could not find a higher-level list function that would help
me construct this list quite the same way.

But this fixed my problem and now I can do this:

[for/fold]: https://docs.racket-lang.org/reference/for.html#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._for%2Ffold%29%29

## [1efb6d5669701572509a5d54c6c98789d0c793ff][get-state]

Here's the implementation and contract for `get_state` on an
`element%`. I made the timeout optional, providing a sensible default.

    [get-state
        (->*m ()
              (clock-time?)
              (values (gi-enum-value/c state-change-return)
                      (gi-enum-value/c state)
                      (gi-enum-value/c state)))]

So the get-state method takes one optional argument: a `clock-time?`,
and returns three values: the `state-change-return`, the current
state, and pending state.

Easy peasy.

The bulk of this week's commits were implementing more GStreamer
functionality and trying to make a really solid GStreamer binding for
Racket. The tools I created for `ffi/unsafe/introspection` are really
paying off. I'll discuss more of these changes next week, but wanted
to highlight one more thing:

## [3459c1e9ab50c20045291d8a4211206ae89054e3][oop]

I remove all naming conflicts between `racket/class` and
`ffi/unsafe/introspection`. Now they can coexist peacefully!

Next week, I'll be cleaning up the `gstreamer` module and writing a
bunch of documentation for it!

Today is the annual Harry's chili cookoff, and I'm going to go eat
some chili!

Have a spoo-o-ooky Friday the 13th and … _look out behind you!_

🏒 Mark 🔪


[args-values]: https://github.com/mwunsch/overscan/commit/a66b038b8dddf68fa9902bce930be20a2c95c559

[gst_element_get_state]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstElement.html#gst-element-get-state

[multiple-return-values]: https://docs.racket-lang.org/reference/eval-model.html#%28part._values-model%29

[get-state]: https://github.com/mwunsch/overscan/commit/1efb6d5669701572509a5d54c6c98789d0c793ff

[oop]: https://github.com/mwunsch/overscan/commit/3459c1e9ab50c20045291d8a4211206ae89054e3
