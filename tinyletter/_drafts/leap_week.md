---
title: The Programs of the Week of the Leap Day
---

This Week's Program: Feb 29 - Mar 4
===================================

Last week I said:

> Next week, I'll be exploring more of the functionality of
> `core.async` to better handle song control flow...

I did that! I also switched
[AbstractFactory.tv](https://www.abstractfactory.tv/)'s SSL (or is it
TLS?) cert away from [*Let's Encrypt*](https://letsencrypt.org/). I
wrote about moving to Let's Encrypt
[last December](http://www.markwunsch.com/tinyletter/2015/12/cyber_week.html)
and now my 90-day cert was expiring. Let's Encrypt makes automating
all of this easy, but I couldn't be bothered with that whole Docker
thing again. In the past 90-days another major development in free SSL
certificates emerged,
[AWS Certificate Manger](http://aws.amazon.com/certificate-manager/). Since
AbstractFactory.tv is hosted on AWS CloudFront, moving to AWS
Certificate Manager was super easy. I still think Let's Encrypt is a
fantastic service, and free SSL/TLS certificates are something that is
generally great.

Before getting into this week's code, I want to highlight a commit
from last week, after I wrote the TinyLetter. In order for my
publication to TinyLetter to work, I had to patch a bit of code:

## [5c55f89d7a81e76d8124d2331e74b28154eaabcb][jekyll-update]

GitHub has been
[pretty vocal](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0)
about updating Jekyll for GitHub Pages, so I went ahead and made that
`bundle update` last week. However, Jekyll's internal API had changed
quite a bit (which was expected, it was a major version release, after
all). However, because my publishing to TinyLetter functionality is
built as a Jekyll plugin, I had to do a bit of extra work to make that
happen.

I was a bit dismayed by what I saw in Jekyll's internals. The
[`Jekyll::Document`](https://github.com/jekyll/jekyll/blob/v3.0.3/lib/jekyll/document.rb)
class is just a big mutable
object. [Local state is poison](https://awelonblue.wordpress.com/2012/10/21/local-state-is-poison/). In
the latest Jekyll, the data described in the post's front-matter is
merged indiscriminately with the data from the rest of the site's
configuration and is no longer accessible on its own, which is a big
deal for my POSSE-style generators. I have to be really explicit now
when generating front-matter and that's not ideal. I might submit a PR
next week to Jekyll to have a way of accessing just the data captured
in the post's front-matter. I also might move this plugin strategy to
be handled by a Jekyll hook. Whenever I decide to publish to Tumblr
from Jekyll I'll have to encounter this again.

Onward to this week.

## [ad5d427aed9e6f9b7ea010563bcce3b32c09f8e0][async-merge]

Before this commit, the `drummachine` fn would return a collection of
async channels. The way I was reading from these channels was with the
[`core.async/alts!!`](https://clojuredocs.org/clojure.core.async/alts!)
function. `alts!` and it's sister function `alts!!` work like **Go**'s
[`select`](https://gobyexample.com/select): it awaits multiple
channels until one of them arrives. That's *okay*, but I really want
to set up this operation so that the entirety of the drummachine
completes at once. I want the drummachine API to appear like it is a
single sequence.

To do that, I had to go a little deeper into `core.async` and I pulled
out two useful functions.

The first is `core.async/merge`, which takes a collection of channels
and linearizes their output into a single channel. Using this, when
each instrument of the sequence completes, it will be an input into
this composite signal.

The next is `core.async/into`. Like Clojure's core `into` function,
this is a *pouring* function: a collection of one type pours into the
collection of the other. `core.async/into` returns a channel who's
value is all of the output of one channel poured into a collection.

The result is a single composite channel that blocks reading until all
of it's sub-channels complete, returning a vector of their
output. When used in both the drummachine and the `gen-song` function,
the API is vastly simplified.

## [1b53e07f83721a61c08060570cda9035f2739116][async-multi]

In this commit, I change the drummachine to use a multiple of the
clock signal channel using
[`core.async/mult`](https://clojuredocs.org/clojure.core.async/mult). This
makes it so that closing the master clock signal will close all of the
components of the drummachine. I no longer need the `step-sequencer`
function and later I change the name of `play-sequence` to
`sequencer`.

## [be90000c5a050cfbdca0d9cd8f451e38ad4291d2][atom]

Finally, I use Clojure's [`atom`](http://clojure.org/reference/atoms)
to synchronize all the active clock signals. This let's me stop all
or a portion of the actively playing sequencers. *This* is how you do
global state.

Next week I'll be focusing more on the music composition and theory
parts of the program.

– Mark

[jekyll-update]: https://github.com/mwunsch/mwunsch.github.io/commit/5c55f89d7a81e76d8124d2331e74b28154eaabcb

[async-merge]: https://github.com/mwunsch/sonic-sketches/commit/ad5d427aed9e6f9b7ea010563bcce3b32c09f8e0

[async-multi]: https://github.com/mwunsch/sonic-sketches/commit/1b53e07f83721a61c08060570cda9035f2739116

[atom]: https://github.com/mwunsch/sonic-sketches/commit/be90000c5a050cfbdca0d9cd8f451e38ad4291d2
