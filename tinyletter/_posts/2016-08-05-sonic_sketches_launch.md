---
title: The Programs of the Week @sonic_sketches Launched
message_id: <obfvwl.15fmmka4pd0vl@markwunsch.com>
---

This Week's Program: Aug 1 - Aug 5
==================================

**Follow [@sonic_sketches](https://twitter.com/sonic_sketches) on
Twitter!**

This week, I put
[`sonic-sketches`](https://github.com/mwunsch/sonic-sketches/) in
production. For you new subscribers or infrequent readers,
`sonic-sketches` has been a long-running exercise for me to learn
about a bunch of different technologies. Its final form is this
[Twitter bot](http://www.newyorker.com/tech/elements/the-rise-of-twitter-bots). Every
morning, @sonic_sketches will tweet a procedurally generated song
using NYC weather data as input.

It feels great to ship this thing.

## [454399f0cf42c92b46e79be0c81bd25ab667f147][mkstatus]

Here, I pull out the latitude and longitude from the song metadata
and, using [Twitter4J](http://twitter4j.org), start with a basic tweet
stating the day of the week.

## [782deb62bd4ac5df678fd73342b8b94843133ece][setMedia]

Next, I use Twitter4J's
[`setMedia`](http://twitter4j.org/javadoc/twitter4j/StatusUpdate.html#setMedia-java.io.File-)
to upload the song, after it's been converted from a wav to an mp4 by
shelling out to [`ffmpeg`](http://ffmpeg.org).

This doesn't work, I get a `400` back from Twitter's API. I think
maybe my mp4 video needs to have some kind of imagery associated with
it, and a very quick Google search shows me how to have FFmpeg convert
the audio data to a
[video waveform](https://trac.ffmpeg.org/wiki/Waveform). That's a
pretty cool added bonus. I find FFmpeg completely inscrutable. This
still doesn't work.

Some more Googling reveals that Twitter4J does not support video
uploading. For uploading video, the Twitter API only supports this
through a relatively newer
[chunked media/upload endpoint](https://dev.twitter.com/rest/media/uploading-media). Looks
like I'll have to get _closer to the metal_.

In the next commit, I pull in the
[`weavejester/environ`](https://github.com/weavejester/environ)
library to make wrangling my Twitter API tokens a bit easier to manage.

## [909641ec8e7533dc3288b317cfdb7bf0ba176b80][upload-media]

My new function `upload-media` uses
[`clj-oauth`](https://github.com/mattrepl/clj-oauth) to sign the
sequential `POST` requests needed to upload chunked media. The
[`INIT`](https://dev.twitter.com/rest/reference/post/media/upload-init)
command tells Twitter how large my media will be and what type of
media it is. The
[`APPEND`](https://dev.twitter.com/rest/reference/post/media/upload-append)
command actually uploads chunks of the video and
[`FINALIZE`](https://dev.twitter.com/rest/reference/post/media/upload-finalize)
signals that the uploading is complete. I get a media id back and use
Twitter4J to associate the media id with the tweet. I can now upload
my programatically generated music video to Twitter.

## [93efb862d94c2a84cf91574c15a06f01828e75ae][emoji]

I pull the concern of rendering a string with the phases of the moon
emoji out into a new namespace. I want my Tweet to display emoji that
represents some of the song input, and it makes sense to move those
concerns into a shared library.

## [00dce8660cb29c5ac80d2a7d8f1504844fd5f01f][precip-str-from-interval]

I do a bit of work to randomly pick the text for the Tweet along with
that emoji namespace.

## [8817379665b680af5413cb3b853402c6f5f48270][ffmpeg-release]

[Apparently](http://askubuntu.com/questions/426543/install-ffmpeg-in-ubuntu-12-04-lts),
Ubuntu Precise doesn't actually install the real `ffmpeg` when you
`apt-get install` it. I instruct my Cloud Formation stack to install a
[static build](http://johnvansickle.com/ffmpeg/) that supports the
features I want. I'm always looking for an opportunity to pipe `wget`
into `tar`.

I update the crontab to also make sure that this `ffmpeg` is on the
`PATH`.

## [73c3f1479d15e08e3224488bd266da7a1d8004df][profiles]

I have the Twitter API tokens be parameters to Cloud Formation, and
use those in instance provisioning to write out the Twitter4J system
properties to `/etc/leiningen/profiles.clj`.

## [b6ce03565643396c5edd8029130424f4d9c2a9ea][tweet-song]

After the song has completed uploading to S3, it gets
tweeted. @sonic_sketches is now live and tweets its first song on
[Wednesday](https://twitter.com/sonic_sketches/status/760822851570204673).

## [51674a0f55116afd6bb985fd0cf1dd25a6bd00a1][async-upload]

I use `core.async` to upload to S3 and Twitter concurrently, and await
the completion of both.

## [2a563dca292c0bfd9d10f78522f2eabf32f71b71][game-of-life]

Then, I start to dig a bit deeper into FFmpeg. I never expected
`sonic-sketches` to become a visual experience, but learning more
about [FFmpeg filtering](https://trac.ffmpeg.org/wiki/FilteringGuide)
led me to a bunch of cool discoveries. I change the color of the
wavform. I bump the resolution up.

I use the same RNG seed that generated the song to run Conway's
[Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
in the background of the waveform. I do that because apparently that's
something that FFmpeg
[can do](http://ffmpeg.org/ffmpeg-filters.html#life) just out of the
box. Why wouldn't I do that? FFmpeg is _amazing_.

[Happy Friday!](https://twitter.com/sonic_sketches/status/761547637749317632)

Next week, I'll work on some logging and a bit more documentation and
do a full retrospective of the `sonic-sketches` project.

⛱ Mark

[mkstatus]: https://github.com/mwunsch/sonic-sketches/commit/454399f0cf42c92b46e79be0c81bd25ab667f147

[setMedia]: https://github.com/mwunsch/sonic-sketches/commit/782deb62bd4ac5df678fd73342b8b94843133ece

[upload-media]: https://github.com/mwunsch/sonic-sketches/commit/909641ec8e7533dc3288b317cfdb7bf0ba176b80

[emoji]: https://github.com/mwunsch/sonic-sketches/commit/93efb862d94c2a84cf91574c15a06f01828e75ae

[precip-str-from-interval]: https://github.com/mwunsch/sonic-sketches/commit/00dce8660cb29c5ac80d2a7d8f1504844fd5f01f

[ffmpeg-release]: https://github.com/mwunsch/sonic-sketches/commit/8817379665b680af5413cb3b853402c6f5f48270

[profiles]: https://github.com/mwunsch/sonic-sketches/commit/73c3f1479d15e08e3224488bd266da7a1d8004df

[tweet-song]: https://github.com/mwunsch/sonic-sketches/commit/b6ce03565643396c5edd8029130424f4d9c2a9ea

[async-upload]: https://github.com/mwunsch/sonic-sketches/commit/51674a0f55116afd6bb985fd0cf1dd25a6bd00a1

[game-of-life]: https://github.com/mwunsch/sonic-sketches/commit/2a563dca292c0bfd9d10f78522f2eabf32f71b71

