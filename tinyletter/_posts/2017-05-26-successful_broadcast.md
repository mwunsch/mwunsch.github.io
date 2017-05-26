---
title: The Programs of the Week of My First Live Stream with Overscan
message_id: <oqkkgs.4oyrygk3rxyx@markwunsch.com>
---

This Week's Program: May 22 - May 26
====================================

**I did it!**

Last week, I proclaimed that I would do my first live-stream using
Overscan on Thursday. This Thursday, I did just that, broadcasting for
just over an hour with software that I made! Here's an image from the
broadcast, of me shrugging about stream quality:

<img
src="http://www.markwunsch.com/img/overscan/2017-05-25-broadcast-selfie.png"
alt="An screenshot from Thursday's broadcast" width="100%" />

I was thrilled to do be able to do this. Thank you so much to everyone
who tuned in! I am giddy to hit another major milestone with this
software. And, as you can see, one of the things I was able to build
this week was the ability to do picture-in-picture. The stream had
some technical bumps and skips, and I had to restart it a couple of
times because of problems with picture or out-of-sync audio and
video. Here's a snapshot of the final segment from
Twitch's [Inspector](https://inspector.twitch.tv/) after completing
the broadcast:

<img src="http://www.markwunsch.com/img/overscan/2017-05-25-stats.png"
alt="A graph of bitrate and framerate from Thursday's broadcast"
width="100%" />

It's interesting to see how the bitrate (and the fps following it) hit
these small plateaus as the stream progresses.

I'm just happy that the stream worked at all. Just before, in several
smaller tests, I was seeing all kinds of stability problems with the
stream. Simply restarting my computer just before broadcasting
alleviated this problem without any real changes to the code. Here's
why I had so many technical problems:

<img
src="http://www.markwunsch.com/img/overscan/2017-05-25-cpu-usage.png"
alt="Activity Monitor showing CPU usage during my broadcast"
width="100%" />

That's `racket`, melting my CPU during my broadcast. It went up higher
than this over the course of the stream.

This week, leading up to the broadcast, I focused on getting my
GStreamer pipeline set up for streaming to Twitch and for writing up
that picture-in-picture example. Getting this all working correctly
feels a bit like some kind of dark magic. I haven't put a lot of
science or rigor into my debugging efforts; I am still brute-forcing
my way to understanding what's happening behind the scenes of this
program. This week was characterized by a bunch of experimentation. My
commits are filled with small pipeline tweaks until something
_appears_ to work.

## [4965e5ec1fee2e08d97c9abc65f32706bf786236][twitch-stream]

I define an RTMP sink, pointing at Twitch's NYC ingest server, pulling
my stream key from the environment.

## [29bb3afdf1b125f2c0924eab13be096fe0cfca6e][rtmp-tee]

I tee my stream out from the FLV muxer out to the recording sink
(writing to a file) and to the RTMP sink. There was something wrong:
this was only sending audio to Twitch. Time to go back to basics...

## [a9ec41183b3a64ccf38da6a91dd1d1270836e4c3][just-stream]

I tear down and then build back up my pipeline, putting just enough in
place to stream to Twitch. Instead of using the previous h264 encoder,
provided by
the [VideoToolbox](https://developer.apple.com/reference/videotoolbox)
framework, I turn
to [x264](http://www.videolan.org/developers/x264.html). I might
revisit this decision again in the future. One thing I learned
somewhat recently is that when doing a bandwidth test the Twitch
Inspector always reports 0 fps.

## [6adda56ba183161c5808e6f1336ab4c11ac4971b][picture-in-picture]

I start the code for supporting a picture-in-picture effect, using
GStreamer's [`videomixer`][videomixer] element. Most of this week was
a struggle as I learned just how tenuous GStreamer can be. Different
a/v sources have different requirements and negotiating those
requirements (in what's called _Caps Negotiation_ — Caps for
"Capabilities") is largely a process of trial and error with different
elements. It's hard to find a one size fits all solution, which I
guess isn't terribly surprising.

The main thing here is that the h264/aac encoding effort requires a
lot of horsepower, and can slow down and block all of the upstream
data flow. Most of the commits this week were all about optimizing the
encoding process and moving and resizing queues throughout the
pipeline.

I turned on some GStreamer warning logs throughout this process of
experimentation. When there was a problem, the logs filled up _real_
fast. Here are some choice picks:

> error: Internal data stream error.

> error: streaming stopped, reason not-negotiated (-4)

These happen when a source can't proceed to the next step, because the
two steps are unable to negotiate their capabilities. Usually this
means inserting some explicit conversion step.

> minimum latency bigger than maximum latency

> WARN x264enc :0::<encode:h264> VBV underflow (frame 729, -328 bits)

I don't know what these mean.

> warning: Can't record audio fast enough

> warning: Dropped 16317 samples. This is most likely because
> downstream can't keep up and is consuming samples too slowly.

These happen because the encoding step is too slow and blocks the
other parts of the pipeline. Video processing can slow down the audio
processing. My solution is to insert `queues` everywhere I didn't have
one before. It's not that successful.

> warning: There may be a timestamping problem, or this computer is
> too slow.

This is just sad.

Yesterday, I also devised a whole new API for `broadcast` that should
give me much more flexibility and hopefully ease the pipeline a
bit.

Here is a visualization of Thursday's broadcast pipeline (click to
embiggen):

<a href="http://www.markwunsch.com/img/overscan/graph-broadcast-2017-05-25.png">
    <img src="http://www.markwunsch.com/img/overscan/graph-broadcast-2017-05-25.png"
    alt="A graphviz diagram of Thursday's broadcast" width="100%" />
</a>

I won't be writing or sending out a Tinyletter next week, and I'll be
taking a bit of time away from coding. Next week, my wife Vera and I
will be celebrating our **Ten Year Wedding Anniversary**! Computers
can take a hike! (Hi Vera! I love you so much! Thank you for all of
your encouragement and support!)

🎞 Mark


[twitch-stream]: https://github.com/mwunsch/overscan/commit/4965e5ec1fee2e08d97c9abc65f32706bf786236

[rtmp-tee]: https://github.com/mwunsch/overscan/commit/29bb3afdf1b125f2c0924eab13be096fe0cfca6e

[just-stream]: https://github.com/mwunsch/overscan/commit/a9ec41183b3a64ccf38da6a91dd1d1270836e4c3

[picture-in-picture]: https://github.com/mwunsch/overscan/commit/6adda56ba183161c5808e6f1336ab4c11ac4971b

[videomixer]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gst-plugins-good-plugins/html/gst-plugins-good-plugins-videomixer.html
