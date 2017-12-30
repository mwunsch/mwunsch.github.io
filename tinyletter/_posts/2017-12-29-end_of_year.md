---
title: The Programs of the Last Week of 2017
message_id: <p1rand.ncyqmvp05li@markwunsch.com>
---

This Week's Program: Dec 25 - Dec 29
====================================

Hello, my pen pals! It's been nearly a month since I last sent this
Tinyletter, and it was nearly a month before that one! As you know,
I've been toiling away at a particularly persnickety problem. Go ahead
and [catch up on that last one][nov27] if you hadn't yet gotten to it
for some important context about what I've accomplished in the month
of December.

This also happens to be the last Tinyletter I'll be sending
in 2017. **Happy New Year!** 🍾

## 2017 in Review

_Two years_ I've been writing this Tinyletter.

At the begging of the year I wrapped up my work
on [_Hive City_](https://github.com/mwunsch/hive-city), my first foray
into game development and first time working in the **Elm**
programming language.

I also began a project
called [_Mechwarper_](https://github.com/mwunsch/mechwarper), a place
to house my experiments and studies in configuration management with
**Ansible**. The playbooks here manage my FreeBSD server. I expect to
pick Mechwarper back up next year.

January of 2017 also saw my first project with the ubiquitous **D3**
JavaScript library: visualizing [my Tinyletter metrics][metrics].

Starting in February, nearly all of my attention and focus with regard
to my side projects has been dedicated to my first ever project with
the **Racket** programming language. In retrospect, I can't believe
I've been working on [_Overscan_](https://github.com/mwunsch/overscan)
for nearly the entire year. I never expected this project to become so
ambitious. I have really enjoyed working on it. Through my work with
Overscan I've learned a whole heck of a lot about software and
computers, and I feel excited enough to keep plugging away at whatever
this thing will shape up to be.

And for the curious, here's my [review of 2016][lastyear].

## `GstGLContext` and `GstVideoFrame`

In my last letter, I wrote quite a bit about my pursuit of building a
cross-platform video display using Racket's own GUI toolkit.

The month since has been, at times, incredibly frustrating and, now,
I'm happy to say, very rewarding.

I went about this in two ways:

+ Understanding everything I could about
  the [GStreamer OpenGL Library][gstreamer-opengl].
+ Understanding everything I could about
  the [GStreamer Video Library][gstreamer-video].

I explored both options at the same time. The OpenGL approach required
a fairly deep knowledge of the APIs
surrounding [`GstGLContext`][gstglcontext], and I was pulling out my
metaphorical hair trying to
get [`gst_gl_context_new_wrapped`][gst_gl_context_new_wrapped] to
work. Eventually, I had to step away from GObject Introspection, and
drop down to the FFI lib level, which was fine and it all works and it
sure beat having to learn [lldb](https://lldb.llvm.org). Oh I said "it
all works". Lol no, spoke to soon. Through all the work needed to
scaffold this, I never got this OpenGL pipeline to actually display
something on the screen.

The thing that I finally got to work was
using [`gst_buffer_map`][gst_buffer_map] to (eventually) get access to
the bytes of each video frame (I never
got [`gst_video_frame_map`][gst_video_frame_map] to output what I
needed). When the `caps` are set to format the video
as [`ARGB`][argb], I can write this bytestring directly to
a [bitmap](https://docs.racket-lang.org/draw/bitmap_.html). What I get
is a smooth animating video running in a little window controlled by
the Racket toolkit.

What a grueling feature. I learned a huge amount in the process of
building it out. My git history is a bit of a mess, and all of this
code needs to be cleaned up and documented, but boy am I happy to
finally get the result I was looking for.

**Thank you** for reading my writing and my code in 2017. I am so
grateful for your readership and the slice of attention you've devoted
to me.

Next week, I'll kick off with my _First Week of 2018_ post (now an
annual tradition). But I'm in a bit of a rut with this Tinyletter,
which you may have picked up on from the lack of consistent posts. I
still see the value that this writing exercise provides, but I'd like
to change things up a bit. And I'm open to suggestions! What would you
like to see _This Week's Program_ look like in 2018? This is, after
all, your inbox, and I'd love to make sure that you get the most you
can out of the experience.

Here's to a fantastic year ahead,<br />
🥂 Mark

[nov27]: http://www.markwunsch.com/tinyletter/2017/12/most_wonderful_time.html

[metrics]: https://bl.ocks.org/mwunsch/f041519e6c2795f5419d09771dd14da2

[lastyear]: http://www.markwunsch.com/tinyletter/2016/12/end_of_year.html

[gstreamer-video]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gstreamer-video.html

[gstreamer-opengl]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-libs/html/gl.html

[gstglcontext]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-libs/html/GstGLContext.html

[gst_gl_context_new_wrapped]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-bad-libs/html/GstGLContext.html#gst-gl-context-new-wrapped

[gst_buffer_map]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/GstBuffer.html#gst-buffer-map

[gst_video_frame_map]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-base-libs/html/gst-plugins-base-libs-GstVideoAlignment.html#gst-video-frame-map

[argb]: https://en.wikipedia.org/wiki/RGBA_color_space#ARGB_(word-order)
