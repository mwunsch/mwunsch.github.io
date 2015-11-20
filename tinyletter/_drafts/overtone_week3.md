---
title: Overtone Week 3
---

This Week's Program: Nov 16 - Nov 20
====================================

This was a difficult week for obvious reasons, but also because I
reached that threshold where I want to move the hell on from this
particular problem space. Part of committing to writing code every
(week)day is about avoiding this trap I very frequently find myself
in: I want to explore and experiment with new languages, frameworks,
tools, etc. and inevitably there's some dip where the work becomes
more frustrating than invigorating. Rather than haphazardly move on to
some other fancy, I'd like to commit to seeing this through. The
reward at the end is a deeper set of knowledge. I would rather take a
long period of time chiseling away to gain depth of knowledge than
hastily gain broad but shallow knowledge. I want to gain mastery of
these concepts. Here I am chilling in the J curve of conscious
incompetence. If I abandon now, no mastery will have been
gained. Avanti.

Here's a tweet that I just happened to catch while drafting up this
letter:

> You have to trial and error to learn \*anything\*. You first learned
> to walk by falling over a lot. Lower expectations and play :-)
>
> -- <cite>[@samaaron][1], creator of Overtone</cite>

Software engineering is frustrating because of documentation. How do
you get the code to do what you want it to do? Some libraries and
tools have too little documentation. You must search through the
source code to try to understand what the system can do. Some have too
much documentation. The documentation is not readily scannable or
there's a lot of conflicting information. In my experience, there's no
such thing as "just right" Goldilocks-levels of documentation. Maybe
I'm just impossible to please. I've never met a system I wasn't
annoyed at understanding.

Inevitably I reach a point with any system where I just *get it* and
when people ask me about it I say something along the lines of "It's
there in the documentation."  All systems have either a deficit or
surplus of documentation until you understand it, and only then does
the documentation feel adequate.

Overtone's documentation *feels* inadequate at present. The
[wiki](https://github.com/overtone/overtone/wiki) feels mostly high
level. As I immerse myself more into the **Clojure** community, I
realize that an awful lot of work is done in the
REPL. [`doc`](http://conj.io/store/v1/org.clojure/clojure/1.7.0/clj/clojure.repl/doc/)
seems to be the preferred mechanism to find out more about a function
and I've only begun using CIDER to consult
[Grimoire](http://conj.io/). There's a lot to CIDER. I'm learning that
there's a lot to learn when it comes to searching for a strong signal
in the Clojure community. A large part of this current work stream is
finding a productive stride that is idiomatic for Clojure
developers. If you have any ideas, please let me know.

## sonic-sketches: [0a6d7b4560a65454823e76be69e7df14d31b45d3][shutdown]

Time is a
[fucked concept](http://tilde.club/~rustyk5/?g=Eyk1pkrj8mWEU&w=133598431518).
Especially in computer science. Music depends on time. I want my
program to play a little tune and then exit. The design of Overtone is
such that "playing a little tune" is asynchronous and I have yet to
discover a mechanism that says "play this little tune and after that
do X." Overtone has lots of functions for timing, but most of them are
seemingly used for recursion. A common pattern I see is a recursive
function where the arguments increment time. Overtone has a built-in
*metronome*. I'm struggling with understanding how to use these
patterns to accomplish my result. This code uses an Overtone function
called `after-delay` and right now it might as well be a `sleep`
statement. Dirty, imperative.

I have accepted the truth that I will not be making music in the near
term. The next few weeks will likely focus on understanding Overtone
timing, understanding what a
[unit generator](https://en.wikipedia.org/wiki/Unit_generator) is
(particularly in SuperCollider terms), and figuring out how to write
my sounds to a file. And also, committing myself to seeing this
project through and not picking up another programming language and
another lark. Write. Code. Every. (Week) Day. Suffer. Get better.

Now, dear reader, I must ask a favor of you. Compose a tweet that
either:

+ Instructs your friends and followers to
  [subscribe to this TinyLetter][tweet].
+ Mentions me ([@markwunsch](https://twitter.com/markwunsch)) and
  describes a time that you struggled in the J curve of programming
  enlightement.

I would prefer you do both. Thank you.

🇫🇷 Mark

[1]: https://twitter.com/samaaron/status/667334581348081664

[shutdown]: https://github.com/mwunsch/sonic-sketches/commit/0a6d7b4560a65454823e76be69e7df14d31b45d3

[tweet]: https://twitter.com/intent/tweet?text=I%20am%20really%20enjoying%20%40markwunsch%27s%20TinyLetter.%20I%20encourage%20you%20to%20subscribe.&url=http%3A%2F%2Ftinyletter.com%2Fwunsch&related=markwunsch
