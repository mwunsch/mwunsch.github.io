---
title: The Programs of the Week the Groundhog Saw Its Shadow
message_id: <oktbvm.1s7o4xfthrueq@markwunsch.com>
---

This Week's Program: Jan 30 - Feb 3
===================================

Sometimes I feel confident that I know about computers. This week I
realized how little I know about computers. An innocuous little thing
scratched an itch in my brain and before too long I found myself deep
in a rabbit hole.

This week I kept working on setting up a comfy development environment
on my FreeBSD server with Ansible. I encountered one of those things
that reaffirmed that doing something out of the typical Linux-world
brings a host of interesting questions. I made a lot of small commits
this week, so I'll highlight some of the more interesting ones.

## [db1edadb6fb75d2136860d9183213d99aaac2126][dotfiles]

I add authorized keys to my remote user from my GitHub public SSH
keys. Then in another Ansible play, I clone
my [dotfiles](https://github.com/mwunsch/dotfiles), unpack them into
my home directory with [Stow](https://www.gnu.org/software/stow/), and
then clone my [emacs.d](https://github.com/mwunsch/emacs.d). Now it
feels like home!

In other commits, I install Ruby with [rbenv](http://rbenv.org) and
OpenJDK and Leiningen.

## [9ad744071f8348d5553726a1ea36c93a77a30ece][roles]

In this commit, I break out my Ansible tasks into 3
distinct [*Roles*][ansible-roles]: `bootstrap`, `packages`, and
`user`. This helps organize the Playbook and also allows me to reuse
things if I ever decide to spin up multiple FreeBSD systems.

## [a9286cf21e60cd04460c49ac51b4dc669b48b488][termcap]

I made this commit yesterday, but really my entire week had led up to
this. I put a `.termcap` file in my remote home directory with this
content:

    xterm-256color|xterm with clear screen capabilities:\
        :Co#256:pa#32767:\
        :AB=\E[48;5;%dm:AF=\E[38;5;%dm:\
        :tc=xterm-clear:

What is this file? Why does the file have this content? Why is it in
my home directory? What is this syntax? What does it mean‽

Friends, **I don't know about computers**.

## Termcap

I did not know this was even a thing until this week.

Do you have a Mac, like I do? Open your Terminal. Do some stuff in
that terminal session. Open your `$PAGER` or Vi and then close
it. What happened? What happens on my Terminal is that the man page or
Vi opens and fills the entire screen. When it closes, that screen
disappears entirely putting your Terminal back into it's previous
state as though Vi had never been there.

If you use GNU Screen, maybe you're familiar with the [`altscreen`][redisplay]
configuration command. In a terminal you can have an "alternate" or
"secondary" screen where something like `less` or `vi` can open and
when it closes it will put you back on the "primary" screen.

This wasn't happening on my FreeBSD server. I would open `less` and
when I quit out of it, the contents would just stay there. I found it
a minor annoyance, different than what I expected. I wondered why this
wasn't working like I expected it to. I googled. Then I fell down the
hole.

Try this on your Mac. Do some work on your terminal and then run:

    tput smcup

Your terminal should now be in a nearly new state, with your prompt
still there. Do some other stuff and then run:

    tput rmcup

You should be back in the previous Terminal state. The [`tput`][tput]
command will perform a capability of your terminal. In this case the
capabilities of `smcup` & `rmcup`. In the case of a Mac or Linux,
these capabilities are defined in the [`terminfo`][terminfo]
database. `tput` looks at your `$TERM` environment variable, looks up
that terminal in the terminfo database, sees how that terminal
performs that capability and then executes that. With programs that
use [`curses`][curses] or equivalent (like `less` or `vi`), typically
they instruct the terminal to carry out these capabilities.

From [Wikipedia](https://en.wikipedia.org/wiki/Terminfo):

> Terminfo is a library and database that enables programs to use
> display terminals in a device-independent manner. Mark Horton
> implemented the first terminfo library in 1981-1982 as an
> improvement over termcap.
>
> …
>
> Terminfo was included with UNIX System V Release 2 and soon became
> the preferred form of terminal descriptions in System V, rather than
> termcap (which BSD continued to use).

So Terminfo is a *newer* (i.e. 1980's) implementation of the *older*
(i.e. 1970's) [Termcap][man-termcap] library and database which the BSD
derivatives, including FreeBSD, continue to use.

The purposes of these databases is to generalize Terminal capabilities
and match Terminal types to how they execute those capabilities. This
is wild to me, because my entire experience of using a terminal has
been through an [xterm](http://invisible-island.net/xterm/)-like
terminal emulator. But back when Termcap and Terminfo were devised,
Terminals were a whole thing. When you look at
a [Termcap file][termcap-file], you'll see a whole bunch of references
to older terminals. The [VT100](https://en.wikipedia.org/wiki/VT100)
is there. So is
the
[Infoton 400](http://terminals-wiki.org/wiki/index.php/Infoton_400)
and
the
[Texas Instruments Silent 700](https://en.wikipedia.org/wiki/Silent_700) and
the [IBM 3101](https://en.wikipedia.org/wiki/IBM_3101).

There's a [reference][minitel] to the
Philips-manufactured
[French Minitel](https://en.wikipedia.org/wiki/Minitel), used
for [Videotex](https://en.wikipedia.org/wiki/Videotex) services and
brought to the United States by *US Videotel* where my wife, Vera,
used one of these terminals for her [first experiences][yak] on the
Internet.[^1]

All of these artifacts of computer history are there, in your termcap
database. Terminals of every era and manufacture and their
capabilities. *All* of them.

So why won't my screen clear after I close a manpage?

Turns out that a lot of folks don't like this
functionality. A [2009 patch][xterm-clear] to FreeBSD removes this
capability from xterm terminals, but adds an `xterm-clear` entry that
you can use to make a similar terminal with the `tc` capability. My
`~/.termcap` file that I committed makes `xterm-256color` inherit this
capability.

I had never encountered `termcap` before. I had never
thought deeply about the capabilities of older Terminals. I had never
thought much about `xterm` or what it means to emulate a terminal and I
had certainly never thought that Unix systems carried references to
legacy systems around with them in this manner. Now I know, and I know
what I don't know.

Now when I close vim, the screen resets to its previous state. It's
the little things.

💾 Mark

[^1]: If anyone knows where I could buy one of these *please* let me know.

[dotfiles]: https://github.com/mwunsch/mechwarper/commit/db1edadb6fb75d2136860d9183213d99aaac2126

[roles]: https://github.com/mwunsch/mechwarper/commit/9ad744071f8348d5553726a1ea36c93a77a30ece

[ansible-roles]: http://docs.ansible.com/ansible/playbooks_roles.html#roles

[termcap]: https://github.com/mwunsch/mechwarper/commit/a9286cf21e60cd04460c49ac51b4dc669b48b488

[redisplay]: https://www.gnu.org/software/screen/manual/screen.html#Redisplay

[tput]: http://man7.org/linux/man-pages/man1/tput.1.html

[terminfo]: http://man7.org/linux/man-pages/man5/terminfo.5.html

[curses]: https://en.wikipedia.org/wiki/Curses_(programming_library)

[man-termcap]: https://www.freebsd.org/cgi/man.cgi?query=termcap&apropos=0&sektion=5&manpath=FreeBSD+11.0-RELEASE+and+Ports&arch=default&format=html

[termcap-file]: https://github.com/freebsd/freebsd/blob/master/share/termcap/termcap

[minitel]: https://github.com/freebsd/freebsd/blob/master/share/termcap/termcap#L1012-L1021

[yak]: http://blog.markwunsch.com/post/40196800288/the-yak

[xterm-clear]: https://github.com/freebsd/freebsd/commit/c11b08a13feb3063076c0f358bdaf4b56bbad5ed
