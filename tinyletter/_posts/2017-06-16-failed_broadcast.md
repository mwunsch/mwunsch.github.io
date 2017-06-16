---
title: The Programs of the Week of a Failed Broadcast
message_id: <orncpy.w3r9avushm8p@markwunsch.com>
---

This Week's Program: June 12 - June 16
======================================

This week was damn frustrating. I've got a handful of git stashes that
I'm not sure are worth exploring further. I did some stuff and later
undid it. I attempted a quick live stream yesterday evening but was
plagued by technical issues with the stream. Worst of all, I feel like
I've ventured into such deep esoteric waters with this software that I
am having an impossible time finding answers to my questions, which
are like:

> Hi, I know nothing about h.264 encoding but why does Apple's
> VideoToolbox encoder not seem to send video to this RTMP stream but
> I'm still able to view it as a saved FLV file?

> Why does the x264 encoder seem to work okay but whenever I use it
> with a GStreamer input-selector it appears as though the stream just
> chokes and stops?

and

> Hi can someone answer my GStreamer questions even though I'm using
> GStreamer through FFI from a Racket REPL?

If you know someone who can help with these questions please send them
my way because I'm about to punch the whole concept of video encoding
right in the kisser.

## [ea8bb621d847ddb66d9de5c7210db031de300e71][await-eos]

Hey here's something cute. A while back I did some fanciness with
Racket [`places`](https://docs.racket-lang.org/reference/places.html)
and set up a thing where a GStreamer Bus can send messages through a
channel for synchronization purposes. Here I use it so that after I
send an end-of-stream ("EOS") event to my pipeline, I listen for that
message to come through before terminating the stream.

Later I undo this commit because the picture freezes and awaits awkwardly for
about ten seconds before the pipeline terminates. Meh!

## [1f39d26c04a5aa1e180b5c8f6dc322442d5deda1][write-text]

Here, for the first time, I bring in the `text-overlay` Element from
GStreamer. I hook it up to my scene and create a function called
`write-text`. This lets me look up the overlay element in the scene
and write to it by setting the "text" property of the element.

## [fc023a7018173a7bf0f85b2cbdf870db011e1337][pixel-aspect-ratio]

I liberally apply the `pixel-aspect-ratio` property to a bunch of my
Caps filters. I was seeing a bunch of things where different video
sources would stretch when scaled. Through experimentation I found
that plastering this everywhere fixed that scaling issue. So much of
my work with GStreamer is trying a bunch of things over and over again
in a completely non-scientific way. Software is so hard sometimes.

## [92e61ccc3af0221cca1f1b818d925a8197cf285d][scene-struct]

Okay here's something cool that I thought was cool and I wanted to
show off. A `scene` is now a struct. That struct contains a GStreamer
`bin` and
an [output port](https://docs.racket-lang.org/guide/i_o.html). The
scene itself behaves as an output port, meaning you can write to it.

In the previous `scene` function, I construct the bin as I had before,
but this time I make an instance of the scene struct. The other thing
I do is start a new worker thread with the read end of the pipe that
the scene can write to. This worker thread will read from the input
port and set that as the text for the text overlay element.

This way, you can create a scene like you normally do, but now you can
write to it as you would any other port:

    (displayln "How meta is this?" pip)

And it will show up as text overlaying the video.

<img
src="http://www.markwunsch.com/img/overscan/2017-06-text-overlay.png"
alt="A screenshot of me showing off text-overlay capabilities in
Overscan. Very meta." style="width:100%" />

In later commits, I set up a `text-port` function to handle more of
this plumbing, and I'll probably formalize that a bit more and tweak
the API to make it really easy to manipulate the text.

I really wanted to show this off, so I took to Twitch for a quick
stream that turned into a total mess. First of all, with my
VideoToolbox encoder, nobody could see any picture! So I brought the
stream down to swap back in the x264 encoder. Now people could see the
picture but the audio was really stuttery because the x264 encoder
chews up my CPU. So I restarted my computer and quit a bunch of other
processes. Then, when I tried switching to different scenes, the
stream just died.

So now, I have to deconstruct my pipeline again and find out what the
heck is going on and how I can optimize. It's hard to know what
problems are from the pipeline being inefficient and what problems
exist because I'm running this on a MacBook Air and it probably has no
idea what it's doing encoding a bunch of live video from different
sources.

Damn frustrating.

😣 Mark

[await-eos]: https://github.com/mwunsch/overscan/commit/ea8bb621d847ddb66d9de5c7210db031de300e71

[write-text]: https://github.com/mwunsch/overscan/commit/1f39d26c04a5aa1e180b5c8f6dc322442d5deda1

[pixel-aspect-ratio]: https://github.com/mwunsch/overscan/commit/fc023a7018173a7bf0f85b2cbdf870db011e1337

[scene-struct]: https://github.com/mwunsch/overscan/commit/92e61ccc3af0221cca1f1b818d925a8197cf285d
