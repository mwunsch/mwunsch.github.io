---
title: The Programs of the Week of Writing Documentation
message_id: <ouwcmw.3c46f5les0mi4@markwunsch.com>
---

This Week's Program: Aug 14 - Aug 18
====================================

It's been a slow week, programming friends. All of my commits are
about writing documentation. On the Racket Google Group, someone posed
a question about _GObject Introspection_ and some other person replied
with a link to [Overscan](https://github.com/mwunsch/overscan)! I know
a thing or two about GObject Introspection now, especially with regard
to Racket. I feel an obligation to finish up some of the
documentation, specifically around `introspection`, so that's what
I've been doing. Writing documentation is really hard work. It taxes a
lot of brain power, and I'm finding I have less and less brain power
to spare these days.

In the interest of keeping this Tinyletter _fresh_ and exciting,
instead of linking you to my commits for that documentation, I thought
I would share some interesting links to other things that I've been
reading lately.

+ [*What to Know Before Debating Type Systems*][debating-type-systems]
  — Through the years of writing this Tinyletter (hi yes it's true;
  I've been writing this thing for _years_) and through the years of
  just being a professional programmer, no debates have raged as
  fierce as the ones that are about static vs. dynamic typing. I think
  that debate is totally bullshit. I think I can safely say that I've
  explored more programming languages than the average professional
  programmer, and this article sums up the way I think about type
  systems better than I could. The conclusions of the article:

    > * That “static typing” and “dynamic typing” are two concepts
    >   that are fundamentally unrelated to each other, and just
    >   happen to share a word.
    > * That “static types” are, at their core a tool for writing and
    >   maintaining computer-checked proofs about code
    > * That “dynamic types” are, at their core, there to make unit
    >   testing less tedious, and are a tool for finding bugs.
    > * That the two are related in the way I outline: that one
    >   establishes lower bounds on correctness of code, while the
    >   other establishes upper bounds, and that questions about their
    >   real world use should come down to the possibility and
    >   effectiveness of addressing certain kinds of bugs by either
    >   computer-checked proof, or testing.
+ [*Aphorisms on programming language design*][aphorisms] — A list of
  principles for designing programming languages, but also a good list
  of principles when just working with programming languages. Some
  really good stuff here but this one sticks out:

  > Every decision that matters is a tradeoff. There never was, and
  > never will be, a perfect language. As humans have many purposes,
  > so must programming languages.

  I would also like to add that parentheses are awesome and I love
  working in Lisps.
+ [*What can developers learn from being on call?*][on-call] — In my
  last two jobs I've had the responsibility of organizing and
  gardening my team's on-call process. A good on-call process is one
  of the best ways to learn about engineering systems. Also, Julia
  Evans is a fantastic, consistent writer on technical topics and an
  inspiration for this Tinyletter. See
  also: [The Spring 2017 issue](https://increment.com/on-call/) of
  _Increment_ magazine.

That's it for now. There's a lot of stuff I ought to be working on!

– Mark



[debating-type-systems]: https://cdsmith.wordpress.com/2011/01/09/an-old-article-i-wrote/

[aphorisms]: http://www.rntz.net/post/2017-01-27-aphorisms-on-pl-design.html

[on-call]: https://jvns.ca/blog/2017/06/18/operate-your-software/
