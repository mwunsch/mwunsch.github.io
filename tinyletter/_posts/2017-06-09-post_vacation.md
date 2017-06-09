---
title: The Programs of the Week After a Vacation
message_id: <oraf3z.10bn635ripja8@markwunsch.com>
---

This Week's Program: June 5 - June 9
====================================

I'm back from a week-long vacation. Vacations are wonderful things. It
was wonderful to step away from the computer. This week I've slowly
adjusted to getting back into the coding groove, and spent the time
thinking critically about how I wanted to shape and evolve this
API. It seems like forever since I
did [my first live broadcast][successful-broadcast] with
Overscan. There's still so much I'd like to refine about this project
though, and this week I took a few spikes that ended up not really
going anywhere, but now I have a greater sense of what direction I
want this project to head in.

## [bfe15032c8236e152d6a5ed8908e1b1ba77e4ac1][link-to-twitch]

Here's Monday's vacation commit, quickly written on my iPad from my
FreeBSD server. I just add a link
to [my Twitch profile](https://www.twitch.tv/wunschkraft)
to [my website](http://www.markwunsch.com).

Make sure to follow me on Twitch
@ [Wunschkraft](https://www.twitch.tv/wunschkraft). I'm going to be
focusing most of my broadcasting energy to Twitch. I thought I might
spend some time preparing streaming to YouTube or Facebook Live, but I
think I'd rather focus on building out the API around `scenes` and
mixing video and audio sources on one streaming platform before
attacking the others.

I haven't done another broadcast since May 25, and I'd like to build
out a little bit more functionality before my next one.

## [801d141419f3d8cfe57be86b230346d300f0452d][gobject-set-infer]

Tuesday's commit changes the signature of `gobject-set!` just
slightly. This is the function used to set properties of GObjects, and
GStreamer uses properties really frequently. Before this change I had
to explicitly indicate what ctype the property I was setting was. The
contract is here:

    [gobject-set!
        (-> gobject? string? any/c ctype? void?)]

This contract says this function takes a GObject instance, a String
property name, any value, a C-Type, and returns `void`. Internally,
Racket's FFI attempts to coerce the value to the given C-Type.

After this commit, the contract has changed to this:

    [gobject-set!
        (->* (gobject? string? any/c)
             ((or/c ctype? (listof symbol?)))
             void?)]

This change to the function signature shows that `gobject-set!` now
accepts a GObject instance, a String property name, and a value, and
optionally takes either a C-Type or a List of Symbols.

If this optional argument is not given, it is inferred based on the
value that's been passed in. If a list of symbols is given, that list
is automatically transformed into a C Enum type.

This makes for a much cleaner API up in the GStreamer layers, where we
can now do things like:

    (gobject-set! videosrc "device-index" 0)

Instead of

    (gobject-set! videosrc "device-index" 0 _int)

This means that modules that rely on GObject Introspection might not
need a deep knowledge of Racket's FFI and the C types being used.

## [7ec07b088f64d1f43199c10afa29111cdd5cecde][gobject-with-properties]

This commit introduces another function around setting GObject
properties: `gobject-with-properties` accepts a GObject instance and a
Hash map of keys and values, and returns the GObject instance after
setting properties.

Frequently in the `overscan` code you see something like:

    (let ([el (send avfvideosrc create "screen")])
        (gobject-set! el "capture-screen" #t _bool)
        (gobject-set! el "device-index" ref _int)
        el)

In this code I'm instantiating a GObject (in this case, a GStreamer
`Element`), setting some properties on it, and then returning the
instance.

With the `gobject-with-properties` function, this code is equivalent
to:

    (gobject-with-properties (send avfvideosrc create "screen")
                             (hash 'capture-screen #t
                                   'device-index ref))

Which is nicer, I think. I was also thinking of making this a macro of
something along the lines of:

    (gobject-with-properties ([capture-screen #t]
                              [device-index ref])
        (send avfvideosrc create "screen"))

What do you think of that syntax? Do you have a preference? I'm on the
fence, but I think the Hash style might be better.

## [90dddc52a8fbf469783f2ef7e1bfd8df2c3425d4][video-toolbox]

In this commit I swap out
the [x264](http://www.videolan.org/developers/x264.html) encoder back
to
Apple's
[VideoToolbox](https://developer.apple.com/reference/videotoolbox)
hardware encoder. This encoder, besides being provided by Apple, takes
advantage of the GPU, so my hope is that this can free up some of the
CPU that video encoding normally consumes. We'll see how this impacts
the stream.

This week I also did a spike that I ended up scrapping on changing the
`broadcast` API.

Right now the `broadcast` function accepts a list of scenes and a
place to stream to (and some optional params for previewing,
monitoring, and recording). I tried to change this a little bit to
accept a list of `sources` along with a list of scenes. The idea being
that each scene would become a function of available sources. The
problem was I couldn't quite figure out an API that made this
easy. Each source would have to have an associated `tee` Element to
output to possibly multiple scenes. It wasn't clear how to filter down
the source list to get just the sources you want in a way that seemed
natural. I stashed this in Git and decided it wasn't worth exploring
now.

I might try to instead have the `scene` functionality be entirely
focused on video, and have a separate audio mixer parameter to the
`broadcast` function. This way, scenes always share the same
audio. Still brewing this idea.

Here's a short list of things that I'd like to try to work on in the
coming weeks:

+ *Documentation*. Racket has a robust documentation tool
  called [Scribble](https://docs.racket-lang.org/scribble/) that
  appears to me to be pretty critical for the Racket ecosystem. I'd
  like to start writing some documentation, especially around some of
  the GObject Introspection work, now that it's stabilized.
+ *Text Overlays*. Before Overscan was _Overscan_ it was called
  _Chyron_. This whole project started as a way to do compositing for
  live streaming video. Now that I have the basics, I'd like to add
  the ability to dynamically overlay text on the scene.
+ *Separation of Concerns*. I think now is a good time to begin
  splitting out parts of the codebase into different files. For
  example, separating out the interface for GObjects that mimic
  Racket's Class collection.

I expect that I'll do a blend of these things over the course of the
next week, and might jump on Twitch to demo and try some things out.

– Mark



[successful-broadcast]: http://www.markwunsch.com/tinyletter/2017/05/successful_broadcast.html

[link-to-twitch]: https://github.com/mwunsch/mwunsch.github.io/commit/bfe15032c8236e152d6a5ed8908e1b1ba77e4ac1

[gobject-set-infer]: https://github.com/mwunsch/overscan/commit/801d141419f3d8cfe57be86b230346d300f0452d

[gobject-with-properties]: https://github.com/mwunsch/overscan/commit/7ec07b088f64d1f43199c10afa29111cdd5cecde

[video-toolbox]: https://github.com/mwunsch/overscan/commit/90dddc52a8fbf469783f2ef7e1bfd8df2c3425d4
