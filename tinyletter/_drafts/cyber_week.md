---
title: The Programs of the Week of ⚡ Cyber Monday ⚡
---

This Week's Program: Nov 30 - Dec 4
===================================

It seems silly that we call a day "Cyber Monday." Truly, all of our
days are Cyber. I've picked up some new subscribers (Welcome) and I
thought it'd be nice to remind everyone (including myself) what this
newsletter is about.

This newsletter is about Living a Cyber Life™. Not so long ago I
started
[a practice](http://blog.markwunsch.com/post/130293473700/the-streak)
of writing and committing code every weekday. This newsletter is both
a forcing function to make sure I keep on doing that and a means to
compose and articulate my thoughts and goals for a given
project. Every Friday, I recap what I've done and what I've
learned. And heck who says we can't have fun, too? Also, I compose
this email in Emacs and with a git
[pre-push hook](http://www.markwunsch.com/tinyletter/2015/10/second_week.html),
publish it through TinyLetter. Drafting and publishing this email
counts toward my code streak. Any accusations that I'm cheating will
result in me feeling bad about myself more than I already do so please
just don't.

The focus of my attention for the past several weeks has been a
repository called
[`sonic-sketches`](https://github.com/mwunsch/sonic-sketches), where
I'm getting more familiar with **Clojure** development through the
lens of [Overtone](http://overtone.github.io/), the audio environment
and client for the [SuperCollider](http://supercollider.github.io/)
synthesis engine.

I hope everyone had a pleasant Thanksgiving, but it's over now and
it's time to shop and computer. This is going to be a long one. Put on
your
[favorite Christmas music](https://open.spotify.com/user/mwunsch/playlist/3q6DSauAcKSTaEHBYb69mM)
and let's talk live coding for audio synthesis.

## [21238504505185a91d00c8a94261e631819c5a65][event-handling]

The tentpole commit this week was all about getting away from that
*sleep*-esque `after-delay`
function. [Last week](http://www.markwunsch.com/tinyletter/2015/11/thanksgiving_week.html),
I mentioned a bit of a breakthrough with CIDER and nREPL. My REPL for
sonic-sketches is now connected at all times in Emacs, and I'm getting
much more comfortable with exploring the Overtone API and
experimenting there (with headphones on). Now that I'm feeling more
empowered with Clojure's tools, I feel like I'm getting closer to
understanding Overtone.

The fundamental atom of Overtone (and SuperCollider) is the
[Unit Generator](https://en.wikipedia.org/wiki/Unit_generator), or
UGen concept. UGens are the basic building blocks of synths and
Overtone is all about using the composition capabilities of Lisp to
construct large graphs of ugens. There's *a lot* of ugens. It is
overwhelming. I encourage you to watch Sam Aaron's video that I
linked, it's a great introduction to all these concepts.

I've also begun some preliminary research into other audio programming
environments. [Extempore](http://extempore.moso.com.au/) is an Open
Source continuation of the
[Impromptu](http://impromptu.moso.com.au/index.html) environment that
uses a Scheme-like language for, um, "cyberphysical programming". It
makes sounds. Rad.

The flexibility about what is possibile with this kind of environment
is maddening.

For now, I'm punting on committing really interesting sounds (I save
that for REPL sessions) and focusing on the lifecycle of synths and
the ability to programmatically start and stop them. This week I dug
into Overtone's event model. You can monitor events as they're
generated. In this commit, I've modified my `play` function from one
that takes a duration to one that takes two `fns`: one that signals a
synth and a callback for when Overtone destroys that synth (which
appears to happen in this case when the synth has completed
playing). I record to a wav file and when the destroyed event for the
synth has completed, I stop the recording and call the fn.

Next week I want to explore the metronome tools of Overtone to
construct bars, and explore event lifecycles in that context. I have a
hunch I'll be using this as an excuse to try
[core.async](https://github.com/clojure/core.async/) soon enough.

## Let's Encrypt!

This Thursday, [Let's Encrypt](https://letsencrypt.org/) entered
Public Beta. I want to encrypt! *Let's Encrypt* is a free, automated
Certificate Authority. It's great stuff and I thought I'd give it a
try since I do not understand SSL/TLS/any acronym that ends in "S".

The first thing I did was follow
[the instructions](https://letsencrypt.org/howitworks/). When I tried
to run the letsencrypt client on my Mac I got all kinds of
dangerous-looking warnings but went ahead anyway. The client runs on
Python and has a huge amount of dependencies (and ncurses). My belief
is, if you're trying to make a widely-deployed utility for a variety
of hosts, you should build your command line tools in something like
Golang and statically link everything. There's too many vectors for
dissapointment the more dynamic a runtime is. So I decided to abandon
that path and use
[Docker](https://letsencrypt.readthedocs.org/en/latest/using.html#running-with-docker)
to run the client. Running Docker on a Mac is its own form of
self-flagellation, but now the
[tools](https://www.docker.com/docker-toolbox) have gotten much
better.

I decided to serve the website for
[Abstract Factory](https://www.abstractfactory.tv/), the podcast
hosted by myself and [Casey Kolderup](https://twitter.com/ckolderup),
with HTTPS. AbstractFactory.tv is a
[Jekyll site](https://github.com/mwunsch/abstractfactory.tv) deployed
to Amazon S3. In order to get my letsencrypt cert I had to configure
[AWS Cloudfront](https://aws.amazon.com/cloudfront/) to front the S3
bucket. It was kind of an ordeal. Luckily, a fellow named Nathan Perry
[wrote up](https://nparry.com/2015/11/14/letsencrypt-cloudfront-s3.html)
how he executed this and I followed his instructions with only a few
total disasters along the way.

None of this requires me committing code, just futzing on the command
line. All that changes is you put a little "s" after the "http" and
hey look at that little 🔒. Now I just have to do another song and
dance when the cert expires in 90 days.

A good week for computering. I would love your feedback and thoughts,
and don't forget to [tell your friends and followers][tweet] to
subscribe.

Thank you for reading!<br />
⚡ Mark

[event-handling]: https://github.com/mwunsch/sonic-sketches/commit/21238504505185a91d00c8a94261e631819c5a65

[tweet]: https://twitter.com/intent/tweet?text=I%20am%20really%20enjoying%20%40markwunsch%27s%20TinyLetter.%20I%20encourage%20you%20to%20subscribe.&url=http%3A%2F%2Ftinyletter.com%2Fwunsch&related=markwunsch
