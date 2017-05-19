---
title: The Programs of the Week It All Came Together
message_id: <oq7kt6.1w2e67hlhxok8@markwunsch.com>
---

This Week's Program: May 15 - May 19
====================================

Before I get too deep into this week's code, I want to make sure I
don't bury this lede:

**I will be doing my first live-stream with Overscan on Thursday, May
25 at 5:30 PM Eastern Time!**

**Follow
me: [Wunschkraft @ Twitch.tv](https://www.twitch.tv/wunschkraft).**

Oh, how far we've come subscribers! Only just last week I was jerking
around in C interop and now I'm throwing down the gauntlet and
announcing when I'll be premiering Overscan to the world! I really
think that in less than a week's time I will be at a point where I can
use this tool.

In less than a week I will be doing my _first ever live broadcast_
from _software that I wrote_ in a programming language _I learned less
than 5 months ago_.

I got so much done this week, and instead of going commit-by-commit
(I made 23 commits this week and they are really sloppy) I'll go
day-by-day.

## Monday

My development environment is a game of Jenga. I have no idea if I'll
ever be able to reproduce what I have here to make this
work. GStreamer and the plugins that I need require a lot of different
C dependencies, and I'm unsure what incantations give me just what I
need. I [updated the README][install-instructions] with some
installation instructions, in the hope that I can reproduce this
environment on different computers. The dependencies I explicitly need
are
[pango](http://www.pango.org),
[rtmpdump](https://rtmpdump.mplayerhq.hu),
and [faac](http://www.audiocoding.com). Right now, Overscan remains a
Mac-only thing.

I take my camera stream and construct
a [GStreamer Pipeline][camera-tee] for it: the stream is tee'd out to
a preview window (so I can see it) and is also encoded to h264 and
muxed into an mp4 and written to a file. This works and I'm able to
observe my first bit of video produced from within Racket.

## Tuesday

Throughout my work, C [GObject deallocation][gobject-unref] dogs
me. References are destroyed before they ought to be and I don't know
why. More segfaults. GObject Introspection actually provides little
hints about ownership transfer when getting references from functions,
and I wasn't really paying much attention to it. Now I only `unref`
a GObject when GIR tells me that I own it.

In [one giant commit][dsl] I begin the
Overscan
[DSL](https://en.wikipedia.org/wiki/Domain-specific_language). In
Overscan, you won't concern yourself much with the specifics of
GStreamer. Instead you'll work with a much nicer set of functions and
APIs for thinking about live streaming. The main function is
`broadcast` which accepts input that you create with the `scene`
function. A broadcast is kind of just a wrapper around a GStreamer
pipeline and a scene is a GStreamer bin.

As I experiment with the DSL, I make another video with my
camera. Here is an animated gif of me discovering that it worked:

![An animated gif of me seeing myself with Overscan](http://www.markwunsch.com/img/animated-test.gif)

## Wednesday

I set up the scene to have a _video pad_ and an _audio_ pad. You can
think of a GStreamer `Pad` as a channel where data flows. In a
GStreamer pipeline, the pipes are `pads` and the `elements` are the
joiners of those pipes. Maybe that's how it works. This metaphor isn't
very good. Anyway… I now send the video down one path to be encoded
and previewed, and the audio goes to be encoded into AAC. Both streams
get muxed into an FLV and if the user specifies it to be recorded to a
file, it gets written
there. Now, [Overscan supports both video and audio][video+audio]. I
hard-code my camera and microphone as the input sources.

I also extend my GObject Introspection module to support translating
[GLists][glist] between C and
Racket. [GLists](https://developer.gnome.org/glib/stable/glib-Doubly-Linked-Lists.html) are
[doubly linked lists](https://en.wikipedia.org/wiki/Doubly_linked_list). Y'all
should know that Scheme has no problem dealing with linked lists.

Here's a cool thing that GStreamer does. It can
make [graphviz](http://www.graphviz.org) diagrams of pipelines. Here's
one of an Overscan broadcast so far (click to embiggen):

<a href="http://www.markwunsch.com/img/gst-test-pipeline.png">
    <img src="http://www.markwunsch.com/img/gst-test-pipeline.png"
    alt="A graphviz diagram of an Overscan broadcast" width="100%" />
</a>

## Thursday

I use some [hacks and tricks][devices] to get information about the
devices that a user has for video, audio, and screen capture. Now when
you boot up a REPL with Overscan you'll see those devices printed out:

    Welcome to Racket v6.8.
    ﻿>
    GStreamer 1.10.4
    Audio Device 0: Built-in Microph
    Camera 0: avfvideosrc:camera:0
    Screen Capture 0: avfvideosrc:screen:0
    Screen Capture 1: avfvideosrc:screen:1
    main.rkt﻿>

You can call the functions `(camera 0)` to get a GStreamer Element for
the camera or `(screen 0)` for capturing the first screen or `(audio
0)` for the microphone.

A scene accepts a [video source and an audio source][scene], so you
can construct a scene with something like: `(scene (camera 0) (audio
0))`. I also reach for the
GStreamer [`input-selector`][input-selector] element, which allows me
to dynamically switch the input flowing through the pipeline. Now I
can call `(switch (scene (screen 0) (audio 0)))` while a broadcast is
running and it will switch, live, to the scene I've specified.

I write a little function in the `gstreamer`
module: [`gst-compose`][gst-compose]. This function takes a bunch of
GStreamer elements and will stitch them together into a Bin, hooking
up the pads in just the right way.

The remainder of the day was in finding ways to optimize the switching
behavior. All of this data is flowing through my pipeline, but
depending on the pipeline configuration, I can see some real bad
latency and dropped frames. There's all kinds of C incantations I can
perform to really see what's happening here, but right now I'm just
sprinkling buffers around hoping that they land in the right
place. This is something I'll continue working on.

## Friday

[Today I made a test video with Overscan.](https://vimeo.com/218155138)

<a href="https://vimeo.com/218155138">
![Overscan test video on Vimeo](http://www.markwunsch.com/img/overscan-vimeo-embed.png)
</a>

Be warned, there is a loud audio tone at the end.

I'm pretty pleased that I wrote software that made _that_! As you can
see and hear, there's still some kinks to work out of the
system. Sprinkling buffers around. Making sure scaling and cropping
happen. Putting in better debugging tools. And building RTMP into the
pipeline so that I can actually do a live broadcast. I'm pretty
confident I will have that complete by next Thursday, when I'll see
you all on [Twitch.tv](https://www.twitch.tv/wunschkraft)!

I'll leave you all with another graphviz diagram. This one is of the
pipeline made to record that video:

<a href="http://www.markwunsch.com/img/test-record-pipeline.png">
<img src="http://www.markwunsch.com/img/test-record-pipeline.png"
alt="A graphviz diagram of my test video pipeline" width="100%" />
</a>

I hope you'll watch me stream next week!

📹 Mark

[install-instructions]: https://github.com/mwunsch/overscan/commit/d4c16a502051be9f2bd316dac3407f2c58de0d95

[camera-tee]: https://github.com/mwunsch/overscan/commit/8d2f9a333cfb9640ca29709a46d32bbd6ed827b1

[gobject-unref]: https://github.com/mwunsch/overscan/commit/e2daa679a0a0c27638563071beef80cc2c7660b3

[dsl]: https://github.com/mwunsch/overscan/commit/63f34147f946d9a5bc4a72679a8e970424feee66

[video+audio]: https://github.com/mwunsch/overscan/commit/221476be35f29dcfc8511fe51e505edf1125872e

[glist]: https://github.com/mwunsch/overscan/commit/bf876fff9bf5cddb8e3adda33be86311345b4378

[devices]: https://github.com/mwunsch/overscan/commit/a298229ffe7e5c83007a9513ca53fad042133616

[scene]: https://github.com/mwunsch/overscan/commit/bc164839a37820dd15c555406c083ac7c5b37616

[input-selector]: https://github.com/mwunsch/overscan/commit/b82c036781560252664dcfa9d62064d5b1ec5130

[gst-compose]: https://github.com/mwunsch/overscan/commit/0d4477f6f56cc2d928f7fe0fe9523e2bfa5ab1b0
