---
title: The Programs of the Week of Halloween
message_id: <oyv1nk.1h1ikeucyz2p5@markwunsch.com>
---

This Week's Program: Oct 30 - Nov 3
===================================

Hello ghouls and fiends! I know it's November now, but I'm still in
Halloween mode and I'm not ready to let it go just yet. You may have
noticed that I did not send my Tinyletter last week. Or you may
have not because you were very busy planning your costume and I'm sure
you looked marvelous.

I've spent a whole ton of time writing documentation!

[Read the latest documentation on my Racket GStreamer module.](http://www.markwunsch.com/overscan/gstreamer/)

This is how you write some code with this library, in the literal
programming style:

    #lang racket/base

    (require gstreamer)

    (unless (gst-initialized?)
      (if (gst-initialize)
          (displayln (gst-version-string))
          (error "Could not load GStreamer")))

This loads the `gstreamer` module, initializes GStreamer if it hasn't
already been loaded, and prints the version of GStreamer, or raises an
error if GStreamer can't initialize. Can you find the documentation
for
[`gst-initialized?`][gst-is-initialized],
[`gst-initialize`][gst-initialize],
and [`gst-version-string`][gst-version-string]?

    (define my-pipeline
      (pipeline%-compose "my-pipeline"
                         (element-factory%-make "avfvideosrc")
                         (element-factory%-make "osxvideosink")))

This creates a new GStreamer pipeline called `my-pipeline` by
_composing_, or chaining together elements. Two in this case: an
_avfvideosrc_ (my Mac's camera) and an _osxvideosink_ (a little
preview window). Find the documentation
for [`pipeline%-compose`][pipeline-compose]
and [`element-factory%-make`][element-factory-make]!

    (send my-pipeline set-state 'playing)

This sets the pipeline's state to _playing_, which starts up the
pipeline. I see a little window with a view of myself through my
camera!

    (send my-pipeline set-state 'null)

This sets the pipeline state to _null_, shutting down the pipeline and
closing the camera and preview window. The `pipeline%` class is a
subclass of `bin%`, itself a subclass of `element%`; that's where
you'll find the documentation for the [`set-state`][set-state] method.

Let's get some more information about the _avfvideosrc_ element
factory.

    (let* ([avfvideosrc (element-factory%-find "avfvideosrc")]
           [metadata (send avfvideosrc get-metadata)])
      (displayln (hash-ref metadata 'description)))

This calls the [`get-metadata`][get-metadata] method on the
`element-factory%` instance, pulls out the value for the _description_
key, and displays it. It says:

> Reads frames from an iOS AVFoundation device

Cool. We're working with GStreamer, a robust C media framework, using
conventional, idiomatic Racket.

I need to write a bit more documentation to describe basic usage such
as this. With this solid foundation in place I can get _twisted_ in my
implementation of Overscan.

I love it when I get to say my favorite quote, "I love it when a plan
comes together".

— Mark

<https://www.youtube.com/watch?v=FPQlXNH36mI>

[gst-is-initialized]: http://www.markwunsch.com/overscan/gstreamer/gstreamer-support.html#%28def._%28%28lib._gstreamer%2Fmain..rkt%29._gst-initialized~3f%29%29

[gst-initialize]: http://www.markwunsch.com/overscan/gstreamer/gstreamer-support.html#%28def._%28%28lib._gstreamer%2Fmain..rkt%29._gst-initialized~3f%29%29

[gst-version-string]: http://www.markwunsch.com/overscan/gstreamer/gstreamer-support.html#%28def._%28%28lib._gstreamer%2Fmain..rkt%29._gst-version-string%29%29

[pipeline-compose]: http://www.markwunsch.com/overscan/gstreamer/bin_.html#%28def._%28%28lib._gstreamer%2Fmain..rkt%29._pipeline~25-compose%29%29

[element-factory-make]: http://www.markwunsch.com/overscan/gstreamer/element_.html#%28def._%28%28lib._gstreamer%2Fmain..rkt%29._element-factory~25-make%29%29

[set-state]: http://www.markwunsch.com/overscan/gstreamer/element_.html#%28meth._%28%28%28lib._gstreamer%2Fmain..rkt%29._element~25%29._set-state%29%29

[get-metadata]: http://www.markwunsch.com/overscan/gstreamer/element_.html#%28meth._%28%28%28lib._gstreamer%2Fmain..rkt%29._element-factory~25%29._get-metadata%29%29
