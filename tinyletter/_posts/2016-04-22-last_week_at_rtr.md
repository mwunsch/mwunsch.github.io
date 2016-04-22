---
title: The Programs of my Last Week at Rent the Runway
message_id: <o61fuv.2z9ygd8oxgpmz@markwunsch.com>
---

This Week's Program: Apr 18 - Apr 22
====================================

After 2+ years as Engineering Director at Rent the Runway, it's time
for me to take my leave and start a new adventure. Today is my last
day. I've got some feelings about it but I'll not share them
here. I'll just say that I worked with some really great folks.

I'm taking some time off between now and my next gig (which I'll
announce later). I might take some time away from coding but we'll see
how I feel when Monday rolls around.

This week, I finished
[yak shaving](https://en.wiktionary.org/wiki/yak_shaving) and now have
a working Vagrant environment for `sonic-sketches`.

## [7e8a50040e4835c166655104488d030381a1feb6][jackd]

After last week's agony, I finally manage to get sonic-sketches to run
inside Vagrant's virtualized Ubuntu environment. This commit
represents a bunch of work to get the machine set up correctly. I pull
in the [openjdk-8-jdk](http://openjdk.java.net/) package from a
[ppa](https://launchpad.net/ubuntu/+ppas). I also pull in the
`supercollider` package. I use
[`debconf-set-selections`][debconf-set-selections] and set
[`DEBIAN_FRONTEND=noninteractive`][debconf] so that I can download
`jackd2` without a
[tty](https://en.wikipedia.org/wiki/Virtual_console). I use `cat` with
a [*here document*](http://tldp.org/LDP/abs/html/here-docs.html)
piping into `tee` to configure priviledges for dbus. Finally I make
downloading lein and the project dependencies part of the provisioning
process.

After some extra commands on the box I finally am able to run `lein
trampoline run` and produce a
[song for **Monday**](https://soundcloud.com/mwunsch/sonic-sketch-monday-6121071153895690929).

I give myself some additional
[`TODOs`](http://c2.com/cgi/wiki?TodoCommentsConsideredHarmful) to
ensure that the system is totally provisioned and set up correctly.

## [3d4eb196fe1facc25dd5822a1107a8665df6cc69][nohup]

Here I add a separate provisioning step, set to always run. This
starts `jackd`. I use
[`nohup`](http://www.gnu.org/software/coreutils/manual/html_node/nohup-invocation.html)
so that the program continues to run even when I log out. I close
`stdin` (that's `0<&-`) and
[redirect](http://www.tldp.org/LDP/abs/html/io-redirection.html) both
`stdout` and `stderr` to a log file. Cheap
[daemons](https://en.wikipedia.org/wiki/Daemon_(computing)) done
quick.

## [d7062d8b116f18e3ccab252b8acea441fcbae92e][herestring]

I use Bash's
[_here string_](http://www.tldp.org/LDP/abs/html/x17837.html) operator
to set `debconf`. This is a neat Unix gag.

## [942122298a90e139559460bb27be6418c043981d][forecast-env]

I mark another `TODO` done when I set up a new provisioning step that
copies the Forecast API Key from the Host environment to the Guest's
(those are virtualization terms) configuration.

## [e4474ce3a6f5e25a86e0e3203320c25fb97dfa71][aws-credentials]

My last `TODO` is completed when I use Vagrant's
[`file`](https://www.vagrantup.com/docs/provisioning/file.html)
provisioner to copy the Host AWS credentials to the Guest.

I can now run `vagrant up`, `vagrant reload`, and run `sonic-sketches`
entirely from within this box. Victory is mine!

I try to use Otto again but ran into this issue that doesn't seem to
be resolved yet: <https://github.com/hashicorp/otto/issues/363>

## [206976878ce766c511b3de2d758fff5a66d863bf][timbre]

I bring in a professional logging library:
[`com.taoensso/timbre`](https://github.com/ptaoussanis/timbre) to
replace my `println` statements.

Now that I have a Linux environment that can reliably run my program,
the next step is to get that environment into *the cloud*. I'll likely
be turning to another HashiCorp product:
[Packer](https://www.packer.io/). I expect to encounter the
unexpected.

Until next time,<br />
🐧 Mark

[jackd]: https://github.com/mwunsch/sonic-sketches/commit/7e8a50040e4835c166655104488d030381a1feb6

[debconf-set-selections]: http://manpages.ubuntu.com/manpages/xenial/en/man1/debconf-set-selections.1.html

[debconf]: http://manpages.ubuntu.com/manpages/wily/man7/debconf.7.html

[nohup]: https://github.com/mwunsch/sonic-sketches/commit/3d4eb196fe1facc25dd5822a1107a8665df6cc69

[herestring]: https://github.com/mwunsch/sonic-sketches/commit/d7062d8b116f18e3ccab252b8acea441fcbae92e

[forecast-env]: https://github.com/mwunsch/sonic-sketches/commit/942122298a90e139559460bb27be6418c043981d

[aws-credentials]: https://github.com/mwunsch/sonic-sketches/commit/e4474ce3a6f5e25a86e0e3203320c25fb97dfa71

[timbre]: https://github.com/mwunsch/sonic-sketches/commit/206976878ce766c511b3de2d758fff5a66d863bf

