---
title: The Programs of the Week of Tax Day
message_id: <oorz3b.369dljrvub412@markwunsch.com>
---

This Week's Program: Apr 17 - Apr 21
====================================

Who else was blazing some _green_ this week? I'm talking about paying
taxes, of course!

It's been a busy week, but I want to highlight just two commits.

## [8a15987f8c390b16c59c50db9a4a76dc3d9fa15f][quasiclass]

You might recall from [last week][last-week] that one of the few
remaining big hurdles in my GObject Introspection library was putting
in bindings for GObjects. This commit represents a bunch of thinking
I've done over the past several weeks about how I'd like to work with
GObjects from within Racket.

The `gi-object-quasiclass` method
uses [quasiquoting](https://docs.racket-lang.org/guide/qq.html) to
construct a [`racket/class`][racket/class] expression. Comments
elided:

    `(class object%
       (init-field pointer
                   [base-info ,obj])

       (super-new)

       ,@(for/list ([method (gi-object-methods obj)]
                    #:when (gi-callable-method? method))
           (let ([args (map gi-base-sym (gi-callable-args method))])
             `(define/public (,(gi-base-sym method)
                              ,@args)
                (,method pointer ,@args)))))

So what on earth is going on here? The `gi-object-quasiclass` function
takes an `obj` (an introspected GObject "class"). This quasiquoted
form is how to construct classes in Racket. The comma is
for [`unquote`][unquote], and that lets me dip in and out of the
quoted form. An introspected GObject has two fields at initialization:
A pointer to the object in C, and the base info that constructed
it. We iterate over the known methods of the GObject and for each one
declare a public method that will invoke the introspected method.

Then, in the `gi-object->class` function, I [`eval`][eval] it, because
`eval` is the apotheosis of programming.

`gi-object->ctype` is where this gets really good. When I encounter a
C pointer to a GObject, I coerce it to an instance of the
`eval`'d classes:

    (define (gi-object->ctype obj)
      (let ([name (gi-base-name obj)]
            [gobject% (gi-object->class obj)])
        (_cpointer/null name _pointer
                   (curry dynamic-get-field 'pointer)
                   (lambda (ptr)
                     (if ptr
                         (new gobject% [pointer ptr])
                         #f)))))

Now, in my REPL I can start messing with GStreamer…

    > (define src-factory (((introspection 'Gst) 'ElementFactory) 'find "fakesrc"))
    > (object? src-factory)
    #t
    > (send src-factory get-metadata "long-name")
    "Fake Source"
    > (send src-factory get-metadata "description")
    "Push empty (no data) buffers around"
    > (send src-factory create)
    ; create method: arity mismatch;
    ;  the expected number of arguments does not match the given number
    ;   expected: 1
    ;   given: 0
    > (send src-factory create "mysrc")
    (object ...)

Cool! In that example, I find an `ElementFactory` with a factory name
(in this case a "fakesrc" factory), get some metadata about the
factory, and then use the factory to create an `Element` of that
factory type. All of this using the idioms and data structures
provided by `racket/class`. Hey, you got your OOP in my Scheme!
There's still a bunch more to implement (like Signals), but I've got
just enough now to actually go about building up an API for GStreamer!

## [a819ea3d08766058a186f0e3b0947774c05ba446][garray]

Before jumping into GStreamer, I wanted to close out this week by
tidying up my introspection library. One thing I did here was
implement introspection for Array types, and I thought I found a neat
trick for doing that.

    (_array/vector _paramtype
                   (cond
                     [(positive? length) length]
                     [zero-term? (letrec ([deref (lambda (offset)
                                                   (if (ptr-ref ptr _paramtype offset)
                                                       (deref (add1 offset))
                                                       offset))])
                                   (deref 0))]
                     [else 0]))

`_array/vector` is a Racket FFI ctype that will take a C Array and
transform it into a Racket vector. It needs a type and a length. But
for some C arrays, you don't know the length ahead of time. But you
might know that it's terminated by a `NULL`. This function will check
a passed in length parameter and if the length isn't positive, it will
then look to see if the array is `zero-term?`. If so, it
uses [`letrec`][letrec] to set up a recursive binding. Starting at
zero, we recursively try to dereference a pointer at incrementing
offsets until we reach NULL. Once we do, that offset is the length of
the list! Tail-call optimization! Recursion! Scheming!

The result, using the same `src-factory` from the above example:

    > (send src-factory get-metadata-keys)
    '#("long-name" "klass" "description" "author")

The C function, `gst_element_factory_get_metadata_keys ()` returns a
`gchar **`. When called from Racket, we get back a Vector of strings.

The remaining work in the `ffi/unsafe/introspection` library surrounds
documentation. To me, documentation can mean a lot of things. There's
formal documentation, like that written
in [Scribble](https://docs.racket-lang.org/scribble/), Racket's
documentation tool. That needs to be
written. There's
[unit tests](http://docs.racket-lang.org/rackunit/). Those need to be
written. And then there are
Racket
[Contracts](https://docs.racket-lang.org/guide/contracts.html). I need
to write those, too. Over the next couple of weeks, I plan on writing
and providing these different forms of documentation while also
exercising the library by building up tools for GStreamer.

There's more to do on `introspection`, but it feels like I reached
some kind of milestone this week.

💚 Mark


[quasiclass]: https://github.com/mwunsch/overscan/commit/8a15987f8c390b16c59c50db9a4a76dc3d9fa15f

[last-week]: http://www.markwunsch.com/tinyletter/2017/04/jury_duty.html

[racket/class]: https://docs.racket-lang.org/guide/classes.html

[unquote]: https://docs.racket-lang.org/reference/quasiquote.html#%28form._%28%28quote._~23~25kernel%29._unquote%29%29

[eval]: http://www.r6rs.org/final/html/r6rs-lib/r6rs-lib-Z-H-17.html

[garray]: https://github.com/mwunsch/overscan/commit/a819ea3d08766058a186f0e3b0947774c05ba446

[letrec]: https://docs.racket-lang.org/guide/let.html#%28part._.Recursive_.Binding__letrec%29
