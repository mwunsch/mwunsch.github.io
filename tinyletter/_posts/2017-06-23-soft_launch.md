---
title: The Programs of the Week of a Big Work Milestone
message_id: <os0sdc.1tykoymv07sef@markwunsch.com>
---

This Week's Program: June 19 - June 23
======================================

The big story this week is the completion of a huge project for my
team at [work](https://www.harrys.com/). This week, we quietly
released a big new thing into the world. I'll talk about it more next
week, but this is something we've been working on for about a
year. I'm super proud to be a part of it and can't wait to share more
of the details next week.

Last week, my work in Overscan was frustrating. This week I identified
two real causes of that frustration.

## [d7eced4a32951e9a0f88c2cea5840b4284760865][zero-latency]

To start, I tear down most of the pieces of my pipeline and just run
some tests between `vtenc_h264` and `x264enc`. No matter how I tuned
Apple's `vtenc_h64` encoder, I always got a black screen when
broadcasting. Back to the CPU-hungry `x264enc`.

Encoding is frustrating.

After a bit more experimentation I find that setting the `tune`
property to `zerolatency` does something meaningful. I still don't
know what exactly it means, but I was seeing the stream crash whenever
I switched from one input to the other, and with this property set I
wasn't seeing that. I read it has something to do with
latency. Imagine that. I still don't know for certain.

More commits here, all around simplifying the pipeline to have the
least pieces necessary to get a stream up and running.

## [4471d40610faa2d434f7c23baaf3455a9976506c][videoscale]

Normalizing video sources is frustrating.

Let's say you have a video source with a 4:3 aspect ratio that you
need to fill a 16:9 frame. When you ask GStreamer to do this,
GStreamer will awkwardly stretch the source to fill the frame. To stop
this from happening, you need to drop in a `videoscale` element. In
the `Caps` (remember that's GStreamer's shorthand for "capabilities")
before and after the videoscale element, you need to make sure there's
a `pixel-aspect-ratio=1/1` setting. This makes the video appropriately
apply black bars around the video source. If you're using a Mac's
iSight camera, what happens now is that the normally crisp video
source now looks like real bad uprezzed crap.

That's because the camera on a Mac has a set of presets and can only
conform to certain resolutions. Without an explicit Cap saying "hey
camera I want you to be at this resolution", the `avfvideosrc` will
give us a small resolution and scale it up.

Here's my conundrum. I want Overscan to be able to accept any kind of
videosrc in a scene. When you call `(camera 0)`, Overscan should
create an element representing the camera, and putting that in a scene
should just work. But I also want Overscan to produce _good looking_
video. I'm torn about how to make my API generic _and_ do the right
thing vis-à-vis normalizing and scaling video sources to produce the
optimal image.

## [4195d0b1f4364be90be199d3dabb73f37e12dcfe][videorate]

Similar to scaling, one problem I encountered when trying to stream my
screen was I found that I wasn't setting an appropriate
framerate. When I explicitly set an fps of 30 frames per second in my
Caps, my screen capture appears just fine, but the camera connected to
my display can't deal with that! It needs a `videorate` element thrown
in the mix. But the camera on my MacBook Air seems to be fine without
a `videorate`.

How to normalize these things without compromising quality and
increasing complexity in the API. This is the question!

I think at this point I _could_ attempt another live stream without
major incident, but I want to spend another week really tuning stream
quality and getting this API in a good spot to handle a diversity of
video sources without choking.

Until then,<br />
Mark

[zero-latency]: https://github.com/mwunsch/overscan/commit/d7eced4a32951e9a0f88c2cea5840b4284760865

[videoscale]: https://github.com/mwunsch/overscan/commit/4471d40610faa2d434f7c23baaf3455a9976506c

[videorate]: https://github.com/mwunsch/overscan/commit/4195d0b1f4364be90be199d3dabb73f37e12dcfe
