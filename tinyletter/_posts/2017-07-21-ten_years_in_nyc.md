---
title: The Programs of a Second Week of Scribbling
message_id: <otgc7n.pz2bjl7x9xa5@markwunsch.com>
---

This Week's Program: July 17 - July 21
======================================

Last week, I figured out how to _build_ documentation with
Scribble. This week, I learned how to _write_ documentation with
Scribble. Also, this week, unfortunately, I had some writer's block.

Here's what I said last week:

> Scribble is effectively a new language. Yeah there's Racket in
> there, but the conventions for calling into it as well as the
> available functions require an additional learning curve.

Here I am, riding the curve.

This is from the [Scribble Manual][at-syntax]:

> The Scribble @ notation is designed to be a convenient facility for
> free-form text in Racket code, where “@” was chosen as one of the
> least-used characters in existing Racket code. An @-expression is
> simply an S-expression in disguise.

The `at-exp` metalanguage enables this expression form. In Scribble,
you have text and then you also have expressions of the form:

    @cmd[datum]{body}

This is roughly equivalent to the S-expression: `(cmd datum
body)`. This syntax allows you to call any Racket expression but have
the syntax tailored for free-form text. Very cool, you can call any
Racket expression in a Scribble document. But then each Scribble
document has its own form. Beyond just the metalanguage that gives you
@-expressions, there's a bunch of different kinds of Scribble
languages, each with their own unique API. Writing a Scribble document
means writing stuff, and then grepping around the Scribble manual to
see if there's an expression that does something like what you needed
to.

For example, I was writing some installation instructions and wanted
to give the reader instructions about running different command line
tools. It took me a heck of a time to figure out how to code this
properly in Scribble. In HTML there's `<pre>` and `<code>` elements —
easy enough. In Scribble there's `@codeblock` and `@racketblock` which
are for writing Racket syntax specifically. There's `@tt` which just
wraps something in a monospace font. Then, finally there's `@exec`
which is closer to what I wanted. And then, down in
the [_Miscellaneous_][commandline] section is `@commandline`, which is
exactly what I wanted.

So slowly (because of the writer's block), I spent this week writing
bits of documentation for Overscan, learning bits and pieces of
Scribble API along the way.

Next week, I hope to have completed a good chunk of this documentation
and make it available online, so you can read it.

I still have writer's block so that's going to be it for me today. I
hope you have a great weekend.

🖋 Mark

[at-syntax]: https://docs.racket-lang.org/scribble/reader.html

[commandline]: https://docs.racket-lang.org/scribble/Miscellaneous.html#%28def._%28%28lib._scribble%2Fmanual..rkt%29._commandline%29%29
