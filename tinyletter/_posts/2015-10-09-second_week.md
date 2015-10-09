---
title: "The Programs of the Sophomore Slump Week"
---

This Week's Program: Oct 5 - Oct 9
==================================

This week, email was on my mind. I'm fascinated with TinyLetter. Not just
because it facilitates a new (old) form of creative expression. It's also
because the systems that make email happen are neat. Having spent nearly my
entire career speaking HTTP to different computers, it was time to try a new
protocol: [SMTP](https://tools.ietf.org/html/rfc5321).

The goal for this week's code was simple: Send this TinyLetter email programmatically.

Here are the major commits from this week to make that happen:

## emacs.d: [007c9c46aeddddfe3a634ccf396873bc2b429cba][emacs-smtp]

I set up Emac's
[Message mode](http://www.gnu.org/software/emacs/manual/html_mono/message.html)
to send mail through my SMTP server. Now I can just type `C-x m` to pull up a
compose mail buffer while in Emacs. Every time I do something that seems so
typically Emacs-ian, I can't help but feel a sense of triumph.

## mwunsch.github.io: [a402cbbcad1a1939ac362a49e85240764b30c868][gh-netrc]

Buoyed by my ability to send mail from Emacs, it was time to send email from my
blog. In last week's letter I referenced how I publish blog posts from GitHub
pages to Tumblr in a git pre-commit hook
(cf. [Tumblelog POSSE](http://blog.markwunsch.com/post/124842033165/tumblelog-posse)). I
wanted to do the same thing with this TinyLetter. I think TinyLetter is neat,
but I'd love to **own** my work and publish it wherever and however I see fit
thankyouverymuch. This commit starts the work of setting up a **Ruby**
[Net::SMTP](http://ruby-doc.org/stdlib-2.2.3/libdoc/net/smtp/rdoc/Net/SMTP.html)
connection.

This code uses the [*netrc*](https://github.com/heroku/netrc) gem to extract
credentials for my SMTP server from my
[`~/.authinfo`](https://www.gnu.org/software/emacs/manual/html_node/auth/index.html)
file. This is the same file that Emacs uses to find those same SMTP
credentials.

## mwunsch.github.io: [3af36ecc5772a7f17596299c34589e0c85a94d6e][gh-messages]

Finishing out this functionality. I look for the special TinyLetter address in
my `ENV` and compose [a message][rfc5322] from a categorized Jekyll blog post. I
had fun learning how to generate Message IDs by implementing
[this recommendation](https://www.jwz.org/doc/mid.html).

If all goes well with this code, when I try to do a git push, you'll see this in
your inbox! (Though it will likely be some plain-text markdown.)

Next week, I think I'm going to focus on making this email look good. Until
then, [follow me on Twitter](https://twitter.com/markwunsch) and
[GitHub](https://github.com/mwunsch). Maybe more of my code
subtweets will end up cited in
[Today in Tabs](http://www.fastcompany.com/3052020/today-in-tabs/today-in-tabs-the-night-the-tabs-went-out-in-georgia).

Your pal,
Mark

[emacs-smtp]: https://github.com/mwunsch/emacs.d/commit/007c9c46aeddddfe3a634ccf396873bc2b429cba
[gh-netrc]: https://github.com/mwunsch/mwunsch.github.io/commit/a402cbbcad1a1939ac362a49e85240764b30c868
[gh-messages]: https://github.com/mwunsch/mwunsch.github.io/commit/3af36ecc5772a7f17596299c34589e0c85a94d6e
[rfc5322]: https://tools.ietf.org/html/rfc5322
