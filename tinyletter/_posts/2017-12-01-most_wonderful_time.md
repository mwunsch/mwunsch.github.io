---
title: The Programs of the Hap-Happiest Season of All
message_id: <p0bcm1.7j8adm99lt15@markwunsch.com>
---

This Week's Program: Nov 27 - Dec 1
===================================

Hello there friends! It's been awhile! I haven't written my Tinyletter
since the week of Halloween; I've been focused on writing some
code. Actually, _focused_ isn't quite right. It would be more accurate
to say I'm nearing Ahab-levels of obsession, picking at some
unexpected behavior and working deep in the bowels of GStreamer.

Here's the main problem: Recall that GStreamer moves media in a
pipeline from a _source_ to a _sink_. The primary _video sink_
available to me is the `osxvideosink` element, which is designed to
display a video inside of a macOS window. Whenever I use this element
either in DrRacket or the `racket` command line, the program crashes.

The alternative to `osxvideosink`, without pulling in X11, is to use
something called a `glimagesink`. As you might tell from the name,
this sink processes video as [OpenGL](https://www.opengl.org/)
textures. For this sink to work well, I need to call a function from
GStreamer's [`GstVideoOverlay`][gstvideooverlay] class called
`gst_video_overlay_set_window_handle`. I can pass a pointer to a
window to this function and let my window manage the sink.

To get this machinery set-up for using and understanding this sink, I
first need to get a better grasp of using [_Signals_][signals] with my
GObject Introspection library.

## [5e7b48bc73bb7f9e7de42de6e4d1a9324d119b9f][gobject-gtype]

Introspection data only gives a picture of what the program is
doing. It describes the types a thing _could_ be, but not what it
actually is. In the case of making a `glimagesink`, creating one
actually gives me an instance of an object that extends several
different C interfaces, including the `GstVideoOverlay` interface. To
connect a signal, instead of using the introspected type of this
instance, I need to get its _true_ type — it's _GType_. This commit
helps me get that.

Some [type punning](https://en.wikipedia.org/wiki/Type_punning)
and some ffi wiring helps me write the `gobject-gtype` function. Given
a GObject instance, I can now get to its true GType.

## [303a9da2c3833a932a51b61417779627a4fedcd7][signal-query]

From there, I can look up and query a signal for more information,
like the GTypes of its parameters and return type.

## [gstreamer/gui][gstreamer-gui]

This is where the madness begins. I do some other stuff in the
following weeks: set up devices, wire up some message parsing… it's
all build up to this. This most frustrating behavior.

I create `gstreamer/gui` to house some of my work on bridging
`GstVideoOverlay` with `glimagesink`. This pulls in
the [`racket/gui`](https://docs.racket-lang.org/gui/) metalanguage. My
thinking here is that I should use the windowing toolkit provided by
Racket itself in order to house this GStreamer element.

It works and it also doesn't.

I create a window by instantiating a `frame%` object, then have that
be a parent to a `canvas%` object. I call `(send canvas
get-client-handle)` to get a pointer to the canvas and attach that to
the above described `set_window_handle` function.

It works in that I can see an image in my freshly created Racket GUI
window. It doesn't work in that the image is not
animating. [It just sits there.](https://screenhole.net/mark/~Y48sgb)

Why isn't it animating? This question would drive me absolutely nuts
for a week+ (it's still driving me nuts). Here are the names of some
of the methods I call to try to understand this behavior better:
`refresh`, `refresh-now`, `flush`, `resume-flush`, `swap-gl-buffers`,
`on-paint`. These are all real method names in the Racket GUI
framework and none of them seemed to do anything. When I had a friend
try this code on Linux, their window animated without much fanfare but
then crashed. What on earth is going on?

The layers of indirection are so dense that, at this point, I have no
idea what's going on. Between the Racket code interfacing with Cocoa
working with the GStreamer framework that's being called though my
Introspection layer there's just too many variables to reason about
what the hell is going on. And somewhere in the middle of all this is a
double buffer waiting to be swapped.

I've learned more about OpenGL and GUI toolkits in the past week than
over my entire career.

I gave up on `glimagesink`. Here's where I am now:

## [appsink%][appsink]

I create a new subclass of `element%` called `appsink%`. This class
will correspond to a GStreamer element conveniently
called [`appsink`][appsink-tutorial]. The `appsink` element is used to
extract data out from the pipeline into the application. GStreamer
provides an API, [`GstAppSink`][gstappsink], for grabbing that data
from the sink.

My goal is to use this element, along with some of these other
GStreamer gimmicks I've picked up over the past couple of weeks, to
find a way to draw a video to a window.

The result will hopefully be a reliable, cross-platform way to view a
video as it streams. This seems like an awful lot of hard work to do
that, but it really seems important.

Check back in next week for some sick C/Racket FFI kickflips.

— Mark



[gstvideooverlay]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/GstVideoOverlay.html

[signals]: https://developer.gnome.org/gobject/stable/signal.html

[gobject-gtype]: https://github.com/mwunsch/overscan/commit/5e7b48bc73bb7f9e7de42de6e4d1a9324d119b9f

[signal-query]: https://github.com/mwunsch/overscan/commit/303a9da2c3833a932a51b61417779627a4fedcd7

[gstreamer-gui]: https://github.com/mwunsch/overscan/blob/2ae88c51ecead5bd5591b4fb881cae738fb84784/gstreamer/gui.rkt

[appsink]: https://github.com/mwunsch/overscan/commit/530be08001d7188d3c85e4fade16a1be164b2cbf#diff-49a27f098372ccb1ccc99ad4bd7fdbfe

[appsink-tutorial]: https://gstreamer.freedesktop.org/documentation/tutorials/basic/short-cutting-the-pipeline.html

[gstappsink]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-appsink.html
