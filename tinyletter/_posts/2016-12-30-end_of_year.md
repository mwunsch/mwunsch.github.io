---
title: The Programs of the Last Week of 2016
message_id: <oj0b0e.33wjzz5z2tpi3@markwunsch.com>
---

This Week's Program: Dec 26 - Dec 30
====================================

This is the last Tinyletter I'll be sending in 2016. **Happy New
Year!** 🎉

## 2016 in Review

In 2016, *This Week's Program* hit
its [one year anniversary][anniversary].

In the first half of 2016, I continued the previous year's experiments
in **Clojure** and [Overtone](http://overtone.github.io)
with [`sonic-sketches`][sonic-sketches], picking up spare bits of
Music Theory along the way. On New Year's Day, I wrote code to
generate a version
of
[_Auld Lang Syne_](https://soundcloud.com/mwunsch/sonic-sketch-auld-lang-syne). I
learned to use `core.async` and _Communicating Sequential
Processes_. I wrote a _macro_. I survived a blizzard named _Jonas_ and
attended [IndieWebCamp](https://indieweb.org). I
made
[drum machines](https://soundcloud.com/mwunsch/sonic-sketch-random-drummachine) and
generated
[music based on the weather in NYC](https://soundcloud.com/mwunsch/sonic-sketch-friday-8122984298179943942). I
[got lost in the weeds][vagrant] setting up Vagrant and running
`sonic-sketches` in Linux. I wrote a bunch of **Bash** in provisioning
steps. I dabbled in Vagrant and Packer. I was lost for months in the
waters of **AWS** and declared that "DevOps is the Kale of
programming." I learned to
love [_CloudFormation_](https://aws.amazon.com/cloudformation/). In
mid-August I
released [**@sonic_sketches**](https://twitter.com/sonic_sketches): a
Twitter bot that procedurally generates a daily song based on the
weather in Manhattan with an accompanying
video. I [reflected on its launch][postmortem] and got to demo it in
September at the wonderful [XOXO festival][xoxo].

In 2016 I [left my job][leaving-rtr] at Rent the Runway and [joined the
team][join-harrys] at Harry's. I gave a talk at the
wonderful [!!con](http://bangbangcon.com)
about [pseudo-random number generators][prng].

In 2016 I spun up a [FreeBSD server][freebsd]
on [Digital Ocean](https://m.do.co/c/19d9dc066fc3). I didn't do all
that much with it, but I was able to get Emacs up and running and
commit some code.

In 2016 I picked up the **Elm** programming language to
create [`hive-city`](https://github.com/mwunsch/hive-city/), my first
game.

2016 was a difficult year for a lot of different reasons. In 2016 I
wrote a lot of code and learned a lot of new things. I hope 2017 is
better.

Here's my [review of 2015][lastyear], for the curious.

I took this Monday off from writing code. I made a bunch more progress
on Hive City's `Campaign` module and refactoring. Here are some of the
highlights from the commits:

## [9567bb7d0ff6aeac781c869cff367adbcd11283e][viewcontrols]

I create a new module: `View.Controls`. This is my first time using a
subdirectory to organize the modules in the game, and my first time
moving view concerns into a separate module.

In the new controls, I always display four buttons. Those buttons are
assigned a key: Q, W, E, or R. I was inspired by the controls of
a
[MOBA](https://en.wikipedia.org/wiki/Multiplayer_online_battle_arena). Those
keys are joined to a `Maybe Action` from the list of available actions
of the Player through a clever (if I do say so myself) use of the `foldl`,
`head`, and `drop` List functions. There's probably a more concise way
of doing this pairing, but I found it to be delightfully Lispy.

## [2698889215680ff7e24a8e85956aef4e7b4cc60b][actionkey]

I wire up my new `View.Controls` to the Campaign and do a bit of
refactoring. Now the keys are represented by a sum type called
`ActionKey`.

## [89945f4c155a6fcf89419749dbbfef4027e48267][diceroll]

Back in `Campaign`, I bring back the `Rolling` and `DiceRoll`
functionality, but a bit more refined. Now the `Player.execute`
function always takes a `Dice` argument.

Having learned a few things from my work in Elm's `Task` module, I
feel like this approach is a lot more elegant than what I had in the
previous `Main` module.

## [28a0ff28980a23c89dbebbbd7f7feb50475e0c3e][takeAction]

I wire up keyboard controls here. Because of the `ActionKey` type I
created earlier, key presses just become as simple as

    takeAction Controls.Q

This maps back to the pairing of action keys and actions from the
`View.Controls` module and returns a `Cmd Msg` that will call the
`Command` message with the associated action.

Here's what Hive City looks like now:

<img src="http://www.markwunsch.com/img/hive_city_dec30.png"
width="100%" alt="A screenshot of Hive City with new layout and
controls" />

**Thank you** for reading my writing and my code in 2016. I am so
grateful that you give me this space in both your inbox and in your
day.

Wishing you the best in 2017,<br />
🍾 Mark

[anniversary]: http://www.markwunsch.com/tinyletter/2016/10/tinyletter_anniversary.html

[sonic-sketches]: https://github.com/mwunsch/sonic-sketches

[vagrant]: http://www.markwunsch.com/tinyletter/2016/04/tax_day.html

[postmortem]: http://www.markwunsch.com/tinyletter/2016/08/sonic_sketches_retrospective.html

[xoxo]: http://www.markwunsch.com/tinyletter/2016/09/xoxo_reflections.html

[leaving-rtr]: http://www.markwunsch.com/tinyletter/2016/04/last_week_at_rtr.html

[join-harrys]: http://www.markwunsch.com/tinyletter/2016/05/new_job.html

[prng]: https://www.youtube.com/watch?v=pdUCK_io9SQ

[freebsd]: http://www.markwunsch.com/tinyletter/2016/08/starting_anew.html

[lastyear]: http://www.markwunsch.com/tinyletter/2015/12/christmas_week.html

[viewcontrols]: https://github.com/mwunsch/hive-city/commit/9567bb7d0ff6aeac781c869cff367adbcd11283e

[actionkey]: https://github.com/mwunsch/hive-city/commit/2698889215680ff7e24a8e85956aef4e7b4cc60b

[diceroll]: https://github.com/mwunsch/hive-city/commit/89945f4c155a6fcf89419749dbbfef4027e48267

[takeAction]: https://github.com/mwunsch/hive-city/commit/28a0ff28980a23c89dbebbbd7f7feb50475e0c3e
