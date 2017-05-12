---
title: The Programs of a Week of GStreamer
message_id: <opuxbx.1vwnpir9j0s28@markwunsch.com>
---

This Week's Program: May 8 - May 12
===================================

Sixteen commits on Overscan this week, all of them of peak
quality. 😙👌

Last week, I hit a major milestone with my ability to interact
with [GStreamer](https://gstreamer.freedesktop.org). I think GStreamer
is a fine library. This week I've attempted to continue to work my way
through the tutorials and to try to understand how GStreamer works. My
GObject Introspection module seems steady enough, though kind of
scattered and messy, and I've made some small changes to it as I
needed more support from the API, or thought of ways to make the API a
better citizen of the Racket ecosystem.

This week, I also gave a variation of a talk I'm calling _Elm: Theory
& Practice_: an introduction to the Elm language based on my
experiences
building
[Hive City][hive-city-retrospective]. [**Here's a video of the talk**](https://youtu.be/O_Lsp_woGXk),
back when I first delivered it about a month ago.

## [c8ed73c24d22eedc45727d9aa598cbe39d011691][signal-worker]

When a _Signal_ is emitted, instead of applying the callback in the
main thread, I now pass it off to a worker thread. I'm dipping my toe
into the waters of concurrency in
Racket. [Threads](https://docs.racket-lang.org/guide/concurrency.html)
in Racket have "mailboxes", which are multi-producer single-consumer
FIFO queues. Sending something into the mailbox (with `thread-send`)
is asynchronous, while receiving something (`thread-receive`) blocks
until something is available. This means that you can have threads
behave close enough to CSP style concurrency (like one finds in
`core.async`, which I used a bunch
in [`sonic-sketches`](https://github.com/mwunsch/sonic-sketches)). In
addition to threading primitives, there's all sorts of synchronization
mechanisms available in Racket, which I use more of a bit later.

I create a worker thread for each kind of signal and all callbacks
emitted for that signal get run on this worker thread, with what I
learned about `#:async-apply` in FFI last week.

Racket threads
are [green threads](https://en.wikipedia.org/wiki/Green_threads). I
was still running into
some [deadlock](https://en.wikipedia.org/wiki/Deadlock) issues in
certain circumstances.

## [998ef26c1dd60d155efd3c8a7e0b45212df6b7f9][remove-keep]

I remove
the [`box`](https://docs.racket-lang.org/reference/boxes.html) that I
used to keep the callback handle around. It turns out I didn't need
it. By removing this code, I fixed some crashes when running this
program in DrRacket. DrRacket has much more aggressive garbage
collection and my box was being collected too soon.

## [41617c6fa6ce09bd45935481ea5a0ec98d328c43][registered-types]

GObjects and Structs that have been introspected by GIR behave really
similarly. So much so that I would like to pretend that they are
basically the same. This code makes it so that their common ancestor
(`gi-registered-type`) can be used to lookup methods and fields, and
that the forms I use to provide an object-oriented API (e.g. `send`,
`get-field`, etc.) can be used for both GObjects and C Structs.

## [6a47ecc540ba39b0869903e9a00ead9b509e42b8][return-values]

This code makes it so that when invoking an introspected function, if
there are any by-reference arguments, those will be returned along
with the function return type. I built this specifically for functions
like
[`gst_element_query_position()`][gst_element_query_position]. This
function returns a boolean, but also takes a by-reference argument of
an integer, and that integer reference actually provides the
information you want to know!

Racket has [multiple return values][multiple-values] and they end up
making a lot of the program weird. In this case, it means sprinkling
in lots of `call-with-values` and `let-values` functions, but this
feels "right".

## [971a0731b41927ae00a9aa8587ab8e468e6cd0eb][bus]

I'm working my way
through [*Basic Tutorial 4: Time management*][tutorial4] and keep
bumping into the previously discussed deadlock problem. The solution
for true parallelism in Racket is [Places][places]. Places are cool
because you have similar channel messaging like you do with threads,
but you're restricted on the types of values that can be passed back
and forth.

In my new `gstreamer/bus` module, I provide a new function
`make-bus-channel`. This function wraps a common GST Bus
operation,
[`gst_bus_timed_pop_filtered()`][gst_bus_timed_pop_filtered], used in
most of the Tutorials. This C function is executed in a new `place`,
and whenever a new message comes off the bus, it gets pushed into a
channel. That channel is then wrapped, with `wrap-evt` so that the
data coming out of the place is always in the expected form and
returned to the caller. Now I can poll this channel and read out the
messages from the bus without blocking or deadlocking or anything like
that.

    (thread (lambda () (let loop ()
                      (define msg (sync pipe))
                      (println (get-field type msg))
                      (unless (memf (lambda (x) (memq x '(eos error)))
                                    (get-field type msg))
                        (loop)))))

This code starts a new thread that begins a loop. Each pass of the
loop reads data out of the bus. That `sync` call doesn't know anything
about the implementation of my bus place, it just blocks until
something is available. Whenever a message comes through, it prints
the type of message it is. If the message is a type of _EOS_
("end-of-stream") or _Error_, it stops the loop and returns.

Two warnings I saw periodically in the logs when working through this
code:

> !!! BUG: The current event queue and the main event queue are not
> the same. Events will not be handled correctly. This is probably
> because _TSGetMainThread was called for the first time off the main
> thread.

> CoreAnimation: warning, deleted thread with uncommitted
> CATransaction; set CA_DEBUG_TRANSACTIONS=1 in environment to log
> backtraces, or set CA_ASSERT_MAIN_THREAD_TRANSACTIONS=1 to abort
> when an implicit transaction isn't created on a main thread.

I don't know what either of these mean. They don't seem to be related
to my usage of Places. Googling them doesn't return anything
fruitful. I'm guessing they have to do with the `playbin` Element. I
need to do some more experimentation here.

## [eb7fcf8edac72c9758f2f4f89e0ae0d73901fcbb][equality]

I rig up `gi-base=?` for testing equality between two introspected
info types. This provides the basis for `is-a?`, which can say if a
GObject instance is an instance of an introspected type. With that
comes `is-a?/c`, which is a contract that I can use to enforce a
function boundary. With this in place, any caller that attempts to
call `make-bus-channel` on something that isn't a `Bus` will have
broken the contract and produced an exception.

    main.rkt﻿> (make-bus-channel "this is wrong")
    ; make-bus-channel: contract violation
    ;   expected: (is-a? GstBus)
    ;   given: "this is wrong"
    ;   in: the 1st argument of
    ;       (->*
    ;        ((is-a? GstBus))
    ;        ((listof symbol?)
    ;         #:timeout
    ;         exact-nonnegative-integer?)
    ;        evt?)
    ;   contract from:
    ;       <pkgs>/overscan/gstreamer/bus.rkt
    ;   blaming: <pkgs>/overscan/gstreamer/main.rkt
    ;    (assuming the contract is correct)
    ;   at: <pkgs>/overscan/gstreamer/bus.rkt:8.24

## [e8cda07d61274c797c475e49bb12ce24a34ceda0][readme]

I update the Overscan README. This project has changed quite a bit
since its inception. Now, I lay out what exactly I'm doing here:

> Now, this project's ambition is to provide a comprehensive
> live-coding environment for video compositing and broadcasting.

Yup. Doing that.

Next week, I hope to actually create (and then share with you of
course) some examples of videos put together with
Racket+GStreamer. This will probably involve me rebuilding a bunch of
GStreamer plugins, many of which require additional C lib
dependencies.

Have a great Mother's Day weekend!

👨‍🍳 Mark

[hive-city-retrospective]: https://medium.com/@markwunsch/five-months-of-gamedev-with-elm-62be2de75ca2

[signal-worker]: https://github.com/mwunsch/overscan/commit/c8ed73c24d22eedc45727d9aa598cbe39d011691

[remove-keep]: https://github.com/mwunsch/overscan/commit/998ef26c1dd60d155efd3c8a7e0b45212df6b7f9

[registered-types]: https://github.com/mwunsch/overscan/commit/41617c6fa6ce09bd45935481ea5a0ec98d328c43

[return-values]: https://github.com/mwunsch/overscan/commit/6a47ecc540ba39b0869903e9a00ead9b509e42b8

[gst_element_query_position]: https://gstreamer.freedesktop.org/data/doc/gstreamer/stable/gstreamer/html/GstElement.html#gst-element-query-position

[multiple-values]: https://docs.racket-lang.org/reference/eval-model.html#%28part._values-model%29

[bus]: https://github.com/mwunsch/overscan/commit/971a0731b41927ae00a9aa8587ab8e468e6cd0eb

[tutorial4]: https://gstreamer.freedesktop.org/documentation/tutorials/basic/time-management.html

[places]: https://docs.racket-lang.org/guide/parallelism.html#%28part._effective-places%29

[gst_bus_timed_pop_filtered]: https://gstreamer.freedesktop.org/data/doc/gstreamer/stable/gstreamer/html/GstBus.html#gst-bus-timed-pop-filtered

[equality]: https://github.com/mwunsch/overscan/commit/eb7fcf8edac72c9758f2f4f89e0ae0d73901fcbb

[readme]: https://github.com/mwunsch/overscan/commit/e8cda07d61274c797c475e49bb12ce24a34ceda0
