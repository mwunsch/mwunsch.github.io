---
title: The Programs of My Second Week at Harry's
message_id: <o7hbzk.2sltbyypc39z3@markwunsch.com>
---

This Week's Program: May 16 - May 20
====================================

It's my second week at Harry's and I'm in full-on
engineering-manager-mode. I'm typically away from my desk and in
meetings most of the day. I enjoy working in that mode and it only
reinforces my need/desire to continue doing these small coding tasks
to keep the mind and keyboard sharp.

GitHub recently changed how they display their
[contributions graph](https://github.com/blog/2173-more-contributions-on-your-profile),
which acts as my checklist for "did I commit some code today?"
GitHub's decisions on what counts as a contribution has been a source
of controversy. Some folks think that the graph encourages burn-out or
gaming. I see the validity of those points. For me, the contribution
graph is a way to hold myself accountable to my deliberate
practice. I'm proud of my contribution graph. I think GitHub has done
the right things to show that it's not all about those green boxes and
to discourage *gamification*. If you are a hiring manager and you look
at a contribution graph to discern a candidate's ability you are doing
it _so wrong_.

This week I didn't commit a lot but I really operated on the edge of
my knowledge and ability.

## [37ab27d07d4e1b2a88d891467961b5f6c38b08ee][vagrant-env]

I was noticing that in my Vagrant box `jackd` almost never started
correctly. I moved the `env` variable that has to be present into the
keyword args of the provisioner. Works reliably now.

## [fbf783820f436baf9488ac2d50cf921005892037][packer-example]

I had been procrastinating the next steps for `sonic-sketches`:
getting a capable machine up and running in *the cloud*. I knew I
wanted to explore the *infrastructure as code* realm of tools. I start
small by using Packer's introductory
[example template](https://www.packer.io/intro/getting-started/build-image.html).

[Packer](https://www.packer.io/), if you don't know, is a…

> …tool for creating machine and container images for multiple platforms
> from a single source configuration.

Brought to you by the good folks at
[Hashicorp](https://www.hashicorp.com/). With Packer, you use a JSON
template to describe steps to build and provision different machine
images. Using Packer gives me the ability to experiment on getting a
machine up in EC2, but optionally build out a Digital Ocean Droplet if
I wanted to without much fuss. My goal this week was to consistently
create an
[AMI](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html)
that mirrored the Vagrant box I had been using.

## [55abc324ba7cbdb8f4eaad50ef34095a13f198ae][provision]

I start by copying the basic provisioning steps out of my Vagrantfile
into the Packer template. At some point, I'm going to have to figure
out how to have these provisioning steps not be duplicated in both
places, but I can worry about that later. These steps install the
software necessary to run `sonic-sketches`.

## [aa550a143c52b6cb39abc1e2fb4f5634f499e4ce][virtualbox]

I tried to build a VirtualBox image by finding the location on my
system for
[`hashicorp/precise64`](https://atlas.hashicorp.com/hashicorp/boxes/precise64),
the box I use for Vagrant. This doesn't work. I have no idea what I'm
doing.

## [f88d548682559d3c1b10298b4aa0a0187a614866][json-mode]

At this point I'm getting frustrated with editing this JSON file and
realize there's a `json-mode` for Emacs. Let's use that.

## [0bc05d2f393fc7a2055fffa65943fee09826cff8][redirection]

Provisioning my machine fails because the `<<<` operator is a
Bash-ism, and that's not the shell that's running. You could say my
dreams of easy provisioning have been
[dashed](https://en.wikipedia.org/wiki/Almquist_shell)…

After updating my AWS IAM roles I've got a little AMI chilling in my
EC2. I haven't tried SSH'ing into it or doing anything more with
it. I'll save that for next week. Frankly I'm a bit sick of
`sonic-sketches` at this point, but I embrace the opportunity to learn
more about automating the deployment of machines and software to *the
cloud* and to familiarize myself with the tooling.

Until next time,

🌧 Mark

[vagrant-env]: https://github.com/mwunsch/sonic-sketches/commit/37ab27d07d4e1b2a88d891467961b5f6c38b08ee

[packer-example]: https://github.com/mwunsch/sonic-sketches/commit/fbf783820f436baf9488ac2d50cf921005892037

[provision]: https://github.com/mwunsch/sonic-sketches/commit/55abc324ba7cbdb8f4eaad50ef34095a13f198ae

[virtualbox]: https://github.com/mwunsch/sonic-sketches/commit/aa550a143c52b6cb39abc1e2fb4f5634f499e4ce

[json-mode]: https://github.com/mwunsch/emacs.d/commit/f88d548682559d3c1b10298b4aa0a0187a614866

[redirection]: https://github.com/mwunsch/sonic-sketches/commit/0bc05d2f393fc7a2055fffa65943fee09826cff8

