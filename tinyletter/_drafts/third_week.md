---
title: The Programs of the Week the Mets Won
---

This Week's Program: Oct 12 - Oct 16
====================================

After last week's [little email fiasco][last-week], I learned that
TinyLetter wasn't as chill as I thought it would be when it came to
accepting plain text over SMTP. I attempted to send it some plain
text Markdown, thinking "Hey Markdown *is* readable by humans
after all." My ambitions got the best of me, and TinyLetter reacted by
treating that plain text as an HTML document. Undeterred, I insist on
sending you this email over a programmatic SMTP connection hooked into
my normal [Jekyll][jekyll] publishing flow.

Time to learn how to send an HTML email.

## mwunsch.github.io: [7807f3277fbcc2e02e9291f065507c13abcd7cd1][tinyletter-html]

When looking for help (via Google of course) for writing a raw text
buffer to send over SMTP, I could not find a lot out
there. Unlike web development, there doesn't seem to be a supporting
industry for email development. Most searches ended up at libraries
and frameworks in various languages designed to produce the
message. I'm trying to minimize dependencies here. Since all I
have is
[Net::SMTP](http://ruby-doc.org/stdlib-2.2.3/libdoc/net/smtp/rdoc/Net/SMTP.html)
I turned to the original source for
learning about sending HTML email: the spec. [RFC 2045][rfc2045]
*Multipurpose Internet Mail Extensions (MIME)*.

The `multipart/alternative` Content-Type is used and specifies a
*boundary* string to distinguish between the alternate implementations
of the email. The Jekyll Post object calls its
[`Convertible#transform`][jekyll_transform] method to transform the
Markdown into HTML and that is what's sent along through SMTP. A
fresh, handwrought, artisinal HTML email is delivered to your door.

## mwunsch.github.io: [0a57a982be12e00b6e110c0075ce0f5b61eb7bdf][tumblr-link]

This commit is an adjustment to my Tumblelog/Tumblr syndication system
to support Tumblr's link-type posts. I wanted to publish a Link on
Tumblr to my TinyLetter sign-up page.

## mwunsch.github.io: [36d723f5c415cfa32574beb380d0515f68175277][ignore-tumblr-errors]

I think owning the content you create on the web is important. That's
why I have built my personal site to be a
[POSSE](https://indiewebcamp.com/POSSE) system. When trying to publish
the above article, I was getting an error from the Tumblr API. When
my syndication hook encountered the error, it aborted the
process. That meant that when the Tumblr API is in a bad state it
prevents me from git pushing. I altered that code to ignore Tumblr
errors. I was able to publish this blog post to my personal site,
knowing that whenever the Tumblr API behaved as expected again I could
post over it. There's plenty of internet media hand-wringing
when it comes to Medium or Twitter's existential crisis about being a Publisher
or a Platform. I'm a publisher, and I decided to build my own platform
and syndicate my work outword to others. When inevitably
the Platform side of these businesses get the short shrift, it helps
to be have a home base to work from.

Eventually, I was able to publish this post to Tumblr after filing a
support ticket.

## emacs.d: [f5bb19fee0589ec43853455086fa52b64715229f][erc-bye]

I set my default ERC quit message to be the Waving Hand Sign Emoji
with the
[Emoji Modifier Fitzpatrick Type-3](http://www.unicode.org/reports/tr51/#Diversity). Unicode
is neat.

I'd love to hear your thoughts about this newsletter and the code I
present. Please let me know by replying to this email or by mentioning
[@markwunsch](https://twitter.com/markwunsch) on Twitter. If you
appreciate it, please tell your friends to subscribe!

Until next time,<br />👋🏼 Mark

[last-week]: http://tinyletter.com/wunsch/letters/the-sophomore-slump-week-following-up

[jekyll]: http://jekyllrb.com/

[tinyletter-html]: https://github.com/mwunsch/mwunsch.github.io/commit/7807f3277fbcc2e02e9291f065507c13abcd7cd1

[rfc2045]: https://tools.ietf.org/html/rfc2045

[jekyll_transform]: https://github.com/jekyll/jekyll/blob/v2.4.0/lib/jekyll/convertible.rb#L61-L74

[tumblr-link]: https://github.com/mwunsch/mwunsch.github.io/commit/0a57a982be12e00b6e110c0075ce0f5b61eb7bdf

[ignore-tumblr-errors]: https://github.com/mwunsch/mwunsch.github.io/commit/36d723f5c415cfa32574beb380d0515f68175277

[erc-bye]: https://github.com/mwunsch/emacs.d/commit/f5bb19fee0589ec43853455086fa52b64715229f
