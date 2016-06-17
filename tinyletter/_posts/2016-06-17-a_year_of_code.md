---
title: The Programs of a Year of Deliberate Practice
message_id: <o8x8hb.3b0231tdhpfd@markwunsch.com>
---

This Week's Program: June 13 - June 17
======================================

It's a special week in _This Week's Program_! One year ago this week I
started to write some code. And then I committed some code the next
day. Then the day after that. Then the weekend came and I didn't
write code. But then I was right back to it on Monday.

I've been writing code out in public every weekday for one year, with
an occasional break here and there.

[!["My contribution graph on GitHub"][contributions]][blog-post]

It wasn't until October that I began logging the work that I was doing
in this newsletter. It's been really rewarding. My short
[blog post][blog-post] has a good summary of what I've accomplished in
this year.

Here's what I've learned:

+ Streaks are a great way to build habits.
+ Deliberate practice is how you get good at something.
+ Doing things in public helps you hold yourself accountable.
+ Regularly articulating the things you've done helps you measure
  progress.
+ It's important to take breaks.
+ Making tiny, incremental progress delivering a thing is better than
  trying to conceptualize it entirely up-front.
+ To-Do lists, GTD®, the Pomodoro Technique, etc. are all useful
  techniques and tools, but they require habit-building unto
  themselves. Optimizing for meta-productivity is probably not useful.

Okay here's some code.

## [95bb0f6540e78f8ac9105540df61a9662a39c5fd][cloudformation]

I spent a bunch of time this week reading through using AWS
CloudFormation, and had a bunch of commits building out a template. I
still haven't spun up a _Stack_ with this template, yet, but I'm
taking my time reading through CloudFormation best practices and the
different resources available. I think I migh really like
CloudFormation.

An alternative to CloudFormation is Hashicorp's
[Terraform](https://www.terraform.io). I'm not quite ready to leave
AWS island, but I can see Terraform being useful for other projects
down the line.

It's been tough to swallow that the days of making neat sounds in
Clojure are behind me and that my new focus is _DevOps_. On the one
hand, I know that this is stuff that is very important and interesting
and useful and I'm going to be a better programmer knowing these tools
and techniques. On the other hand, it's not holding my interest like
some of the creative explorations and language studies. _DevOps_ is
the Kale of programming.

## [4aebf2f97b0c8c79c584f90fc66391c55dcb4cc5][jekyll-hooks]

For a little respite from DevOps Kale I started hacking around on my
personal website here and there. Here, I'm exploring using a
[Jekyll hook](https://jekyllrb.com/docs/plugins/#hooks) to publish to
a 3rd party ([Medium](https://medium.com/developers) but I'm only
halfway serious).

## [a942091646065e5262321adf92fb8d904ea6612f][tumblr-publishing]

After a bunch of spikes in the Jekyll hook direction I decided that
the generator approach might be for the best, but I decided to clean
up a lot of the code around publishing to Tumblr. I'm not sure if this
code works entirely, just yet, but I'll likely borrow some of the
patterns here for Tinyletter publishing.

That's all for now. Here's to another year of writing code 🍻!

– Mark


[contributions]: http://66.media.tumblr.com/66b49184a56c9129a6ef149b12780507/tumblr_o8u0x9oukU1qzykueo1_1280.png

[blog-post]: http://blog.markwunsch.com/post/145978376025/its-been-one-year-since-i-started-writing-code

[cloudformation]: https://github.com/mwunsch/sonic-sketches/commit/95bb0f6540e78f8ac9105540df61a9662a39c5fd

[jekyll-hooks]: https://github.com/mwunsch/mwunsch.github.io/commit/4aebf2f97b0c8c79c584f90fc66391c55dcb4cc5

[tumblr-publishing]: https://github.com/mwunsch/mwunsch.github.io/commit/a942091646065e5262321adf92fb8d904ea6612f

