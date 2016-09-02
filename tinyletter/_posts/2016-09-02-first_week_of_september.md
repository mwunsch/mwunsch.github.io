---
title: The Programs of the First Week of September
message_id: <ocvsfp.38gbtox2evb29@markwunsch.com>
---

This Week's Program: Aug 29 - Sep 2
===================================

Greetings, friends! I went and gone and did it.

For those of you who might be newer subscribers, and for everyone else
too, let me break down how I author this newsletter. It starts in
Emacs. All of my Tinyletters are written as markdown documents in
my
[personal website's Jekyll repository](https://github.com/mwunsch/mwunsch.github.io). When
I'm ready to publish, a git pre-push hook kicks in and fires off an
SMTP message to Tinyletter's servers.

I've also been trying to figure out how to become reasonably
productive on my iPad Pro, enough to use it as my day-to-day personal
computer. The fly in the ointment here is all of the *"programming"* I
do. Well, now I've got that covered.

I'm writing this newsletter on (and intend to send it from *fingers
crossed*) my FreeBSD server that I've got running on
a [Digital Ocean][digital-ocean] droplet. I'm SSHing into it thanks to
the wonderful Panic Inc.'s
app [Prompt](https://panic.com/prompt/). I took some time this week to
get it all set-up. No Ansible or any other kind of configuration
management, just trying to figure it out as I go. I hope to learn a
bunch of stuff along the way:

+ How to be a decent system administrator.
+ How to security?
+ FreeBSD ins and outs. Ports and `pkg` and jails and zfs...
+ Do I have what it takes to be *leet* (elite)?

We out chea, got my dotfiles, got my `emacs.d`, and now I'm writing my
programming newsletter by connecting to freebsd on my iPad
Pro. Prepare for me to be *more* insufferable.

## [c1c78c8569e3d66507629dc8c5ebd42550ca02a2][usrlocal]

I had to update my dotfiles to not care so much about `brew`. We're
all `/usr/local` here in the land of BSD.

Some small nags about working in Emacs on my iPad. I can't remap the
keys on
my [Apple Smart Keyboard](http://www.apple.com/smart-keyboard/). That
means Caps Lock is still Caps Lock and not Control. The worst
key. Also, the Option key doesn't act as a `Meta` key and that's
throwing me off hard. Luckily Panic put some good software keys to
make this usable, but with just a few tweaks to the keyboard I could
be truly smug.

## [b41c883da75a19755b69aed9147e56f9d1e6e627][hive-city-model]

I wrote some Elm this week, too! Here I'm modeling out a "model" in
Necromunda. The terms here get murky, because the Necromunda rules
frequently refer to a "model" as the physical little miniature that
you move around the game board. I think I really love the ML family of
languages, and Algebraic Data Types are great. Slowly starting to get
a feel for the Elm way of doing things.

## [0651f1bfb70ca25351dbf4a24590fe22466a903c][elm-architecture]

Finally getting the hang of the Elm Architecture. Nothing to impressive
here. I render an `@` in the middle of the screen and when you click
on it it becomes "selected". The next hard part is figuring out enough
SVG to structure the game's graphics. Luckily, there's this
fantastic [roguelike](https://github.com/jweissman/rogue) that someone
has written that I can use as a guide. Thanks Elm Slack!

This is a three-day weekend and then my wife and I will be
attending [XOXO](https://xoxofest.com) in Portland next week (our
first time)(please say "hi" if you're there). I'm not
sure how that will affect my coding and tinyletter schedule, but it
likely will.

Until then,<br />
– Mark

[digital-ocean]: https://m.do.co/c/19d9dc066fc3

[usrlocal]: https://github.com/mwunsch/dotfiles/commit/c1c78c8569e3d66507629dc8c5ebd42550ca02a2

[hive-city-model]: https://github.com/mwunsch/hive-city/commit/b41c883da75a19755b69aed9147e56f9d1e6e627

[elm-architecture]: https://github.com/mwunsch/hive-city/commit/0651f1bfb70ca25351dbf4a24590fe22466a903c

