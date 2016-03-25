---
title: The Programs of the Week of Purim
message_id: <o4lnns.o91xv3exe2h5@markwunsch.com>
---

This Week's Program: Mar 21 - Mar 25
====================================

Had an off-week this week. Decided to take a step away from
sonic-sketches for a bit to work on another project, this one
closed-source. I decided to use [Ember](http://emberjs.com/) for it.

This week has been mostly about learning how Ember works, scratching
out a few of the tutorials, and getting my Emacs set-up for
"ambitious" JavaScript development.

The bulk of commits this week are in my
[`emacs.d`](https://github.com/mwunsch/emacs.d) configuration. It
seems like the preferred community way of approaching Ember, or any
other sort of modern JS project, is with `js2-mode` and `web-mode`. I
struggled with `js2-mode`'s indentation configuration, which serves as
another reminder why Lisp is great. `js2` also has this kind of
on-the-fly syntax checking which I found kind of annoying, especially
when [Flycheck](http://www.flycheck.org/) does this really well.

The JavaScript community's ecosystem was under a fair bit of scrutiny
this week and I'd rather not pile on, but I was certainly weary of the
toolchain heroics that are necessary to get started in a meaningful
way (npm, Babel, eslint, etc.). To be fair that curve is par for the
course for any major language development.

The major change in my Emacs set up was this bit of elisp:

    (setq create-lockfiles nil)

Emacs [Lockfiles][interlocking] were causing pain with
[ember-cli](http://ember-cli.com/)'s file watching/rebuilding. I just
turned them off. Probably will have ramifications down the line.

So far I think Ember is pretty good.

– Mark

[interlocking]: https://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html

