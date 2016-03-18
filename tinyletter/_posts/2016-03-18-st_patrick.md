---
title: The Programs of the Week the Clocks Rolled Forward
message_id: <o48qpy.2owlwdfrlly89@markwunsch.com>
---

This Week's Program: Mar 14 - Mar 18
====================================

Last week I built a client to the Dark Sky
[Forecast API](https://developer.forecast.io/). This week I weaved
that data into my song generation algorithm to influence the final
composition.

## [f7b0c42120f029ccf73c8f9f6d2587ad7cef2e8a][and-weather]

I modify the function signature of `gen-song` to accept optional
weather data using the _variadic_ rest parameters form. I knew that I
wanted this attribute to be optional to song generation, but it was a
toss-up between this and using the _multi-arity_ form.

I use that great Clojure destructuring to pull out the latitude,
longitude, and daily summary from the body of the Forecast API
response and send the latter to the `gen-song` function and use the
former two data points as metadata on the S3 object.

## [80e77eceac8f5f0dc144c63cb5db3fbc89970204][apply-merge]

Because I chose the variadic form, the `weather` symbol there will
always be a list. Now, in the body of the function I have to handle
the cases around lists: whether they're empty or they're lists of
nothing. Even though there's extra work involved versus making this
function multi-arity, the API feels cleaner. Knowing that the
`weather` attribute here ought to be a map, I do `(apply merge
weather)` to flatten the list of maps into a single map. I could have
done `(first weather)` but merging feels a bit nicer and produces the
same type of result.

## [98242413de3e568db2977560b0bbf601951eca23][lunar-illumination]

Here's the fun part.

The first datum I pull out of the Forecast response is the day's
[lunar phase](https://en.wikipedia.org/wiki/Lunar_phase). Forecast
models this as a number between 0 and 1 representing the "percentage
complete" of a lunar cycle. To extract this from the response I use

    (or (some :moonPhase (:data today))
        (datagen/float))

The `data` portion of the response is another list of maps, so I use
`some` to pull out the first `:moonPhase`. If for whatever reason this
is `nil` (as in the case where I do not supply weather data to
`gen-song`, I use the random number generator to supply a random
floating point number.

After that, I convert that floating point number to an integer and
send it to the new `lunar-illumination` function. This function
accepts this *phase* number and determines how *full* the moon is at
that particular phase. The hardest part about this week was figuring
out the arithmetic necessary to do this conversion. A full moon is
*50*, so I subtract 50 and take the absolute value of the result. This
is the *distance* of the current phase from 50%. I then divide this by
10 and round to get a number between 0 and 5 inclusive, where 0 is the
full moon at its brightest. This just so happens to correspond to the
number of indices of the `tempo-map`. I use this as an index into that
`tempo-map` with this (slightly reorganized) code:

    (nth (reverse (keys tempo-map)) (lunar-illumination lunar-phase))

**The more *full* the moon is, the faster the song will be.**

## [4c0f83ef2fd77bcc312537aadc704d2431cab996][reverse-illumination]

I could have left it at that, but this API didn't sit right with
me. A scale of 0 to 5 with 0 representing the high end seemed
backward. It was backward: I had to `reverse` the keys of the tempo
map in order for this to make sense. In this commit I subtract 50 and
take the absolute value again to reverse the direction of the
scale. Now 5 represents full illumination and that feels better.

## [ba0f6f07029db527367f2e33036066c1187c3894][lunar-str]

Here's a commit that's just for funsies. I'll walk through the code
step-by-step.

    (->> (range 0x1f311 0x1f319)
         (map int)
         (mapv (partial format "%c")))

The Unicode codepoint range 1f311 thru 1f318 are the Emoji characters
for representing phases of the moon. I turn these into integers to
weave through `format "%c"` which is a decent way to translate Unicode
codepoints to strings.

I divide 100 (because lunar phase is a percentage) by the length of
the emoji list minus 1 (7) to avoid an off-by-one error and then
divide the lunar phase number by this.

Given a lunar phase (a number from 0 to 100), this function returns
the emoji representing the moon at that phase.

    (map lunar-str (range 100))

Shows off all the possible moons.

So now my song generation algorithm is influenced by the moon phase on
the day that it's run. The more illuminated the moon, the faster the
song will be. Next week, I'll work on incorporating more aspects of
the day's weather into the song: precipitation, temperature, length of
day.

🌔 Mark

[and-weather]: https://github.com/mwunsch/sonic-sketches/commit/f7b0c42120f029ccf73c8f9f6d2587ad7cef2e8a

[apply-merge]: https://github.com/mwunsch/sonic-sketches/commit/80e77eceac8f5f0dc144c63cb5db3fbc89970204

[lunar-illumination]: https://github.com/mwunsch/sonic-sketches/commit/98242413de3e568db2977560b0bbf601951eca23

[reverse-illumination]: https://github.com/mwunsch/sonic-sketches/commit/4c0f83ef2fd77bcc312537aadc704d2431cab996

[lunar-str]: https://github.com/mwunsch/sonic-sketches/commit/ba0f6f07029db527367f2e33036066c1187c3894

