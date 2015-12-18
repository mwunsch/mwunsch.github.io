---
title: The Programs of the Week Star Wars Premiered
message_id: "<nzkati.3gcbat5hrrnlq@markwunsch.com>"
---

This Week's Program: Dec 14 - Dec 18
====================================

Pardon this distraction from your *Star Wars* related
festivities.

## How to Make a Noise

You start with an oscillator. An oscillator produces a wave. When that
wave is used to vibrate the speakers on a laptop, we hear sound. An
oscillator can produce different shapes of waves, and the frequency
and amplitude of that wave can result in different sounds.

In Overtone:

    (definst foo [] (sin-osc 440))

This produces a SuperCollider Synth that when called as a function
(eg. `(foo)`) produces the sound made by a sine wave with a frequency
of [440 Hz](https://en.wikipedia.org/wiki/A440_(pitch_standard)). From
the Overtone documentation:

> Sine waves are often used for creating sub-basses or are mixed with
>   other waveforms to add extra body or bottom end to a sound. They
>   contain no harmonics and consist entirely of the fundamental
>   frequency. This means that they're not suitable for subtractive
>   synthesis i.e. passing through filters such as a hpf or
>   lpf. However, they are useful for additive synthesis i.e. adding
>   multiple sine waves together at different frequencies, amplitudes
>   and phase to create new timbres.

[Subtractive synthesis](https://en.wikipedia.org/wiki/Subtractive_synthesis)
is a method where the sound wave is modified by filter
mechanisms. [Additive synthesis](https://en.wikipedia.org/wiki/Additive_synthesis)
is where waves are added together.

In Overtone there's also
[sawtooth waves](https://en.wikipedia.org/wiki/Sawtooth_wave):

    (definst bar [] (saw 440))

> The sawtooth wave produces even and odd harmonics in
>   series and therefore produces a bright sound that is an
>   excellent starting point for brassy, raspy sounds. It's
>   also suitable for creating the gritty, bright sounds
>   needed for leads and raspy basses. Due to its harmonic
>   richness it's extremely suitable for use with sounds that
>   will be filter swept.

That means that sawtooth waves are suitable for subtractive synthesis.

An [LFO](https://en.wikipedia.org/wiki/Low-frequency_oscillation) is
a secondary oscillator that produces a low-frequency signal used to
modulate another signal. It could, for example, be used to modulate
pitch, giving the effect of
[vibrato](https://en.wikipedia.org/wiki/Vibrato).

There's a voltage-controlled oscillator, or
[VCO](https://en.wikipedia.org/wiki/Voltage-controlled_oscillator). There's
a voltage-controlled filter, or
[VCF](https://en.wikipedia.org/wiki/Voltage-controlled_filter). There's
a lot of these oscillators and filters in the music synthesis world,
and I only have a rudimentary understanding of them.

The signals that I describe are patched together to create an
instrument. This instrument is the
[Korg Monotron](http://www.korg.com/us/products/dj/monotron/) Analog
Ribbon Synthesizer. It's a super funky instrument. The
[schematics](http://www.korg.com/us/products/dj/monotron/page_3.php)
of the Monotron are publicly available and a fellow named Roger Allen
[made a Monotron](https://github.com/rogerallen/explore_overtone/blob/master/src/explore_overtone/monotron.clj)
in code for Overtone.

## [1ea8231bddbcd12f0cd51c186bcb9ff6976543be][monotron]

Using Roger's Monotron, I create a metronome and pass the two to a new
play function. On each beat, I `choose` a random note from the C major
scale and use Overtone's `ctl` function to send a control message to
the synthesizer to adjust the note. It plays in the REPL until I tell
it to `stop`.

[Here's what that sounded like.](https://soundcloud.com/mwunsch/sonic-sketch-monotron-test)

May the force be with you.

🖖 Mark

[monotron]: https://github.com/mwunsch/sonic-sketches/commit/1ea8231bddbcd12f0cd51c186bcb9ff6976543be
