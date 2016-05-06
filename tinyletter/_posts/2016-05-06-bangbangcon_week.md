---
title: Job Transition Week 2
message_id: <o6repx.133qjeq2pbi7t@markwunsch.com>
---

This Week's Program: May 2 - May 6
==================================

My focus this week, like last week, has been on talk preparation for
[**!!con**](http://bangbangcon.com).

Next week, I'm very excited to begin a new job at
[**Harry's**](https://www.harrys.com), the men's shaving company. I'll
be managing their platform engineering efforts. I'm _very_
stoked. I've gotten some FAQs about joining the team there; here are
my answers: I will _not_ be shaving my beard. I am, in fact, a Harry's
customer because a good beard requires maintenance and the product is
_good_. _Yes_, a razor company requires a strong, dedicated software
team because Harry's sells its wares on-line and good custom software
is necessary for a vertically integrated company to succeed. Rails on
Heroku.

This week, I returned to coding but I did not focus on
`sonic-sketches`.

## [4028dfe7573447ce6996314e806d292ab4970b62][travis]

It's been nearly a year since I last released
[`rumoji`](https://rubygems.org/gems/rumoji), my Ruby Gem for
translating between emoji Unicode codepoints and
[emoji cheat sheet codes](http://www.emoji-cheat-sheet.com). I had
mostly moved on since it did what I needed it to do. As new emoji were
released, I accepted pull requests, but hadn't released the gem in a
while. Apparently, people actually use it in production! This felt
like the right time to get the latest code packaged and released.

First, I had to get the repo building again. Newer versions of Ruby
moved `minitest` out of the standard library.

## [065d59015cc11c0c8b41cd512e64e41773138ece][readme]

When I first created Rumoji, it started with a ranty blog post. Most
browers did not support native emoji display. The advice I gave in the
blog post was to alter user-generated content before writing to the
database by transcoding emoji unicode codepoints. My reasoning was
this: most folks did not (and still do not) understand String encoding
throughout their stack. I've kind of calmed down a bit from this
notion, but I think Rumoji is still a useful tool for handling user
content. I update the README to reflect my newer attitude.

## [<span style="font-weight:normal;">🏷</span> v0.5.0][tag]

[Rumoji 0.5.0](https://rubygems.org/gems/rumoji/versions/0.5.0) is now
available on RubyGems.org.

## [lol im so random!][talk]

My conference talk is all about random number generation. In
preparation for the talk I explored PRNG's in a smattering of
different programming languages:

+ [JavaScript](http://www.ecma-international.org/ecma-262/6.0/#sec-math.random)
+ [Mathematica](https://reference.wolfram.com/language/tutorial/RandomNumberGeneration.html)
+ [Clojure](https://clojuredocs.org/clojure.core/rand)
+ [Java](https://docs.oracle.com/javase/8/docs/api/java/util/Random.html)
+ [Haskell](https://hackage.haskell.org/package/random-1.1/docs/System-Random.html)
+ [Ruby](http://ruby-doc.org/core-2.2.0/Random.html)
+ [Python](https://docs.python.org/3/library/random.html)
+ [Julia](http://docs.julialang.org/en/release-0.4/stdlib/numbers/#random-numbers)
+ [Bash](http://www.tldp.org/LDP/abs/html/randomvar.html)
+ [AWK](https://www.gnu.org/software/gawk/manual/html_node/Numeric-Functions.html#DOCF43)
+ [BASIC](https://www.c64-wiki.com/index.php/RND)

My hope is that my talk provides several jumping-off points for folks
interested to dive a bit deeper. The conference will be livestreamed
at <http://confreaks.tv/live/bangbangcon2016>. My talk is on Sunday
right around noon. Hope you'll be able to tune in!

‼ Mark

[travis]: https://github.com/mwunsch/rumoji/commit/4028dfe7573447ce6996314e806d292ab4970b62

[readme]: https://github.com/mwunsch/rumoji/commit/065d59015cc11c0c8b41cd512e64e41773138ece

[tag]: https://github.com/mwunsch/rumoji/commit/74c5080a8e2b6db059e6012ebbc7390b5ad942c6

[talk]: http://bangbangcon.com/speakers.html#mark-wunsch

