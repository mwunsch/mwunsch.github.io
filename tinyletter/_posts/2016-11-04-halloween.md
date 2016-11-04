---
title: The Programs of the Week of Halloween
message_id: <og4n8o.vnt7oozfxhno@markwunsch.com>
---

This Week's Program: Oct 31 - Nov 4
===================================

The most frightening this week is how little progress I made on
`hive-city`!

## [b8936a3b41c407c48d865a29f6f72f4f38f8ef75][running]

Using the `Player -> Action -> Instruction` pattern I established last
week, I implement `Running`. A Model can _run_ in Necromunda during
the Movement phase, electing to move twice its normal movement rate
but can not attack in the following Shooting phase.

I add the `Run` Action to the list of available actions in the
`Movement` phase and migrate the UI to use SVG's
[`tspan`](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/tspan)
element.

I add the `canRun` and `run` functions to the Model module. The `Run`
action takes a form very similar to the `Move` action, and executing
the `Running` instruction calls the `Model.run` function.

## [409c1d33d30a194a5abac76fc1847d6ff13a5643][keyboard-shortcut]

I add a keyboard shortcut for the letter "R" to trigger the Run
command, and also stub in recursive calls to the `update` function
with the `NoOp` message so I don't repeat the same code.

## [172a7a54f92175e71d072876da7611240d6cea76][complete]

In the `Complete` message, instead of checking against a particular
action, I check against the phase of the turn to determine what should
happen after an Instruction has been executed.

## [f47a7686952a4195c44ca58634dac6bc341ea26e][contextmsg]

On the `Command` message, I update the game's context message that
appears at the top of the screen to instruct the player on what to do
next.

## [5d633bc604ad6b961285ef3de24bee6bd2cfe7c4][shooting]

Like I did with `Running`, I start the work to implement `Shooting`,
mostly by writing a bit of code around _targeting_ a Model.

Next week, I'm going to make it so that a Model can attack another
Model!

👻 Mark

[running]: https://github.com/mwunsch/hive-city/commit/b8936a3b41c407c48d865a29f6f72f4f38f8ef75

[keyboard-shortcut]: https://github.com/mwunsch/hive-city/commit/409c1d33d30a194a5abac76fc1847d6ff13a5643

[complete]: https://github.com/mwunsch/hive-city/commit/172a7a54f92175e71d072876da7611240d6cea76

[contextmsg]: https://github.com/mwunsch/hive-city/commit/f47a7686952a4195c44ca58634dac6bc341ea26e

[shooting]: https://github.com/mwunsch/hive-city/commit/5d633bc604ad6b961285ef3de24bee6bd2cfe7c4
