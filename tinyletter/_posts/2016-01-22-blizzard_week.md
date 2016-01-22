---
title: The Programs of the Week We Prepared for a Blizzard
message_id: "<o1d3bb.24gmduwkdplam@markwunsch.com>"
---

This Week's Program: Jan 18 - Jan 22
====================================

As the denizens of NYC buy up all the bread and milk in the city for
the coming blizzard, I'm at [IndieWebCamp NYC][indiewebcamp]. I
presented the syndication system that I use to publish to Tumblr and
TinyLetter. I hope to expand that system over the course of the
camp. The week flew by. Here's some code!

## [2ac3273bfbcd5dc9a8623ba406a0a702417732f8][s3upload]

Uploading to Amazon S3 was really easy. I was shocked. I'm using the
[Amazonica](https://github.com/mcohen01/amazonica) Clojure library,
which is a handy idiomatic wrapper for the official Amazon Java SDK.

## [bddcc0e358b83fbc90928c943bf39a156d0f65aa][put-object]

I extracted s3 upload to a new function, and use Clojure's handy
threading macro.

So now, running my program will record Auld Lang Syne and upload it
right to an s3 bucket.

I'm going to take a small break from this repository, I think, while I
learn a bit more about building up synths in SuperCollider and
learning more music theory.

I also spent some time this week caring and feeding for websites.

Stay warm,<br />
⛄ Mark

[indiewebcamp]: https://indiewebcamp.com/2016/NYC

[s3upload]: https://github.com/mwunsch/sonic-sketches/commit/2ac3273bfbcd5dc9a8623ba406a0a702417732f8

[put-object]: https://github.com/mwunsch/sonic-sketches/commit/bddcc0e358b83fbc90928c943bf39a156d0f65aa
