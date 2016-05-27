---
title: The Programs Leading to a Three-Day Weekend
message_id: <o7unvj.1jb6i08xdm0oa@markwunsch.com>
---

This Week's Program: May 23 - May 27
====================================

It's Summer outside. It's about to be a three-day weekend with no
plans. I'm going to phone this email in so you can just enjoy the
clime, wherever you may be. It's okay, because I made very tiny
progress on `sonic-sketches`.

I renamed `example.json` to `packer.json`.

## [810c0ac764a5387f3b792150692119874969625b][provision]

I move the provisioning steps shared between Packer and Vagrant into
its own file under `script/provision`, according to
[GitHub's style](http://githubengineering.com/scripts-to-rule-them-all/).

The important thing here is:

    if [ `uname` == "Darwin" ]; then
      echo "Please no dont" >&2
      exit 1
    fi

If I accidentally run `script/provision` on my Mac (the host machine)
this block will tell me "no dont". Because it's got a lot of `sudo`
commands. And I'm clumsy.

The next couple of commits change some names.

That's it, that's what I did this week. Meh. Maybe I just move this
whole thing into Docker...

🌞 Mark

[provision]: https://github.com/mwunsch/sonic-sketches/commit/810c0ac764a5387f3b792150692119874969625b

