---
title: The Programs of a Third Week of Scribbling
message_id: <otto8z.1il5aepe5s1jc@markwunsch.com>
---

This Week's Program: July 24 - July 28
======================================

In the past couple of weeks I've learned how to _build_ and _write_ in
Scribble, Racket's metalanguage for writing documentation and manuals
for programs. This week I continued that trend, but this time,
learning how to automate this process.

You can now see a _very_ early draft of Overscan's in-progress
documentation at <http://www.markwunsch.com/overscan/>

Why am I putting this all this effort into documentation? Several
reasons:

+ A program or library isn't complete until it's documented. In the
  case of a library like Overscan, the main interface _is_ code, and
  the usage of that code should be documented. Otherwise, users of the
  library won't know its capabilities.
+ Much of the idea behind this very Tinyletter was to articulate my
  own progress and learning. A program's documentation is an
  articulation of its context and its reason for being. The
  documentation is a forcing function to demonstrate _why_ the code
  is.
+ Writing documentation for a library can show the holes and gaps in a
  library. If the program can't be described well in prose, it
  probably requires some different thinking. As I wrote some of the
  documentation for `introspection`, I found that there were some
  concepts that just didn't make sense when I tried to describe
  them. I can refine those APIs now.
+ Scribble is a big part of the Racket community, and using the tool
  and writing the docs show that Overscan _belongs_ in Racket.

## [f68d7c34623a6209cb1e24ad19b88a332008bec8][makefile]

If you followed along the development
of [`hive-city`](https://github.com/mwunsch/hive-city) you'll know
that I just love [Make](https://www.gnu.org/software/make/). I write a
Makefile to run the Scribble program and generate the documentation
and put it in a `docs` directory in the repo. [GitHub Pages][pages]
treats the `docs` directory a little special, and can use it as a
publishing source.

Write some docs and bada bing, bada boom they're on the internet.

Next week I'm going to keep writing some stuff and then probably
revise the program as I hit little snags where writing out usage
reveals something funky in the API.

Have a good weekend!

– Mark

[makefile]: https://github.com/mwunsch/overscan/commit/f68d7c34623a6209cb1e24ad19b88a332008bec8

[pages]: https://github.com/blog/2228-simpler-github-pages-publishing
