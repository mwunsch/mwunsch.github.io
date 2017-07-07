---
title: The Programs of the Week of Independence Day
---

This Week's Program: July 3 - July 7
====================================

Not gonna lie, fam. I did not care much about computers this
week. This week was the Fourth of July here in the United States of
America and I was feeling those *summer vibes*. I took the Fourth off
from my coding streak and just managed to squeeze in a couple of
commits throughout the week.

## [e4f79d626e317cbee68eb5bff0ccde164c91272a][better-defaults]

Experimenting with some Emacs stuff I thought "hey I know what I'll do
I'll just update all of my packages". First mistake, bozo. On Monday I
made a [commit][tool-bar-mode] to try to fix some stuff that had all
of a sudden popped up. Like the Emacs tool bar. Get out of here tool
bar I don't want you! `(tool-bar-mode -1)`.

Later on I realized that
the [better-defaults](https://github.com/technomancy/better-defaults)
package was updated and now I have to explicitly require it.

While I'm writing this tinyletter I've also found that the Markdown
package was updated and now I have to get into a new habit for
creating links. Why do you change your interface Emacs packages?!
Lesson learned: never update anything.

## [5c41268ca3b93e3efa826d63eb85d4b297705e73][caps]

I further flesh out `gstreamer/caps.rkt` and add some helper functions
for quickly creating [`capsfilters`][capsfilter]. Capsfilters are used
everywhere in GStreamer and their job is to refine what is flowing
through the pipeline. You use capsfilters to say "the data moving
through here ought to be raw video at this framerate and this aspect
ratio" and GStreamer _negotiates_ capabilities on the upstream and
downstream elements to make sure they can fulfill that contract.

One of the helper functions I create is the `(video/x-raw)` function
which creates `capsfilters` just for sending video around. Next week,
I'm going to pick this thread up and evolve this `gstreamer` module
into a well-behaved, idiomatic Racket library that has handy functions
just like this.

## [7ad57afd3c2f551430820030c2ed495b70d1e01a][TeX]

For some reason I got a bee in my bonnet and decided I needed to
really jam on some [LaTeX](https://www.latex-project.org). I was like
"I need to typeset something in really high quality and make it look
like a scientific paper." "I need to waste a huge amount of time going
in depth to learn yet another markup language to produce PDF's that
make me look like I have some scientific credibility," I thought. So I
started down this miserable road for whatever reason.

I installed [AUCTeX](https://www.gnu.org/software/auctex/), which is,
I suppose just the thing for stuff like this, but I still can't figure
out what it adds. I also make sure to add the directory
that [MacTeX](https://www.tug.org/mactex/) puts all of its
executables to my exec-path:

    (add-to-list 'exec-path "/Library/TeX/texbin/")

I do this in Emacs and not in my shell's `$PATH` because I don't want
that stuff cluttering around in there!

After all this rigmarole I can turn a LaTeX buffer into a PDF. Big
whoop. I'll be sticking with the quite
good [ShareLaTeX](https://www.sharelatex.com) for now but why I've
decided I really need to learn the ins and outs of TeX is quite beyond
me. I guess my subconscious just really wants a markdown language to
produce quality typeset documents!

Next week I hope to shift some focus back on Overscan and try to
accomplish a couple of things:

+ Start making the `gstreamer` module something with actual utility.
+ Documentation with Scribble.

Until then I'm all about those *summer vibes*.

🎆 Mark

[better-defaults]: https://github.com/mwunsch/emacs.d/commit/e4f79d626e317cbee68eb5bff0ccde164c91272a

[tool-bar-mode]: https://github.com/mwunsch/emacs.d/commit/555cbd5a6885eb918b3946f96c79e8d0f91bc8ca

[caps]: https://github.com/mwunsch/overscan/commit/5c41268ca3b93e3efa826d63eb85d4b297705e73

[capsfilter]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer-plugins/html/gstreamer-plugins-capsfilter.html

[TeX]: https://github.com/mwunsch/emacs.d/commit/7ad57afd3c2f551430820030c2ed495b70d1e01a
