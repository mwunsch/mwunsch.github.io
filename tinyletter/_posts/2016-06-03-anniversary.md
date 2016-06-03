---
title: The Programs of the Week of My Wedding Anniversary
message_id: <o877la.15qlcft00kkui@markwunsch.com>
---

This Week's Program: May 30 - June 3
====================================

🎉 Nine years ago today, the incredible Vera agreed to be my wife!  She
is the most wonderful, supportive, caring, funny, thoughtful,
beautiful friend that I could ever ask for. I'm forever grateful that
she's stuck with me from one wacky scheme and head-scratching
distraction to the next. She's my muse and my ghostwriter. No
newsletter author could ask for a better subscriber. No man could ask
for a better partner. Hi my love! Happy anniversary! 💟

I'll keep this brief.

I took Memorial Day off from writing code; the long weekend helped me
refocus on this next stage of `sonic-sketches`. I've so enjoyed
writing in Clojure, and it's been hard to accept that what I really
need to do is shift gears away from the musical exploration of
`sonic-sketches` and approach this next stage of development as
something new. It's time for me to better understand the
[_Infrastructure as Code_](https://en.wikipedia.org/wiki/Infrastructure_as_Code)
movement.

I spent some time over the long weekend getting a stronger footing
with EC2 and the kind of thing Packer is really suited for. Choosing
Packer might have been an overcorrection, but in any case I spent this
week tangling with AMI creation. Following last week, my Packer build
failed.

## [94c3c65f778782b12571a1751c11ff64124f5b41][precise-ami]

This changes the Packer source AMI to pull use
[Ubuntu 12.04 Precise Pangolin](http://releases.ubuntu.com/precise/). The
original AMI was
[Ubuntu 14.04 Trusty Tahr](http://releases.ubuntu.com/trusty/). My
build was failing because my provisioning script is shared with my
Vagrantfile. My Vagrant box builds from _Precise_. When that
provisioning script runs against _Trusty_, it just doesn't
work. Packages are different. Wanting to keep this symmetry between
Vagrant and EC2, I decided to stick with what I knew worked and move
the AMI onto Precise.

After the Packer build step completes, I have an AMI that I could spin
up into an EC2 instance, ssh in, and verify that all the dependencies
are there. Next, I'll be evaluating
[AWS CodeDeploy](https://aws.amazon.com/codedeploy/) to see how to get
my code from GitHub onto my EC2 box and have its dependencies set up
and ready to go.

## [4a632ba9da1060823f97356f344dcfdec599fe75][clojurescript]

I also did some work in a separate track from my Packer and _IaC_
explorations. In this commit, I brought the
[**ClojureScript**](https://github.com/clojure/clojurescript) compiler
into the project.

## [c3285728b50a202537ac67a9118853e76bc3a344][cljsbuild]

Then, I brought in the
[lein-cljsbuild](https://github.com/emezeske/lein-cljsbuild) plugin
and set it up to compile an empty ClojureScript file.

Why am I bringing in ClojureScript? Because I know at some point I'll
want to do some work within AWS Lambda. I think I'd like to have that
code live alongside the `sonic-sketches` repo. I'd love to write AWS
Lambda functions in ClojureScript and deploy them as JS. I'm taking
this slow.

That's all for now. Have a fantastic weekend!

– Mark

[precise-ami]: https://github.com/mwunsch/sonic-sketches/commit/94c3c65f778782b12571a1751c11ff64124f5b41

[clojurescript]: https://github.com/mwunsch/sonic-sketches/commit/4a632ba9da1060823f97356f344dcfdec599fe75

[cljsbuild]: https://github.com/mwunsch/sonic-sketches/commit/c3285728b50a202537ac67a9118853e76bc3a344

