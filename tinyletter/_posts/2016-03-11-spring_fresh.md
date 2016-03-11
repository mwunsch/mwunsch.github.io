---
title: The Programs of the Week NYC Got a Hint of Spring
message_id: <o3vs8a.17jx2yga9f0re@markwunsch.com>
---

This Week's Program: Mar 7 - Mar 11
===================================

*deep inhalation* 🌷🍃🌈🐣

This week, New York got its very first hint of Spring. The weather was
lovely and warm. The sun was out. I made it a point to step away from
my computer often and enjoy a nearby park bench. I realized how
affected I am by the climate. This week's code is all about weather.

## [0679d41e23ab9f315759342960cbaf54e071d5f6][rand-tempo]

First, I use the random number generator to choose a tempo. Now my
songs are always in D minor (the saddest of all keys) but will be at
random speeds. I also move some of the `println` statements into this
function. I think I might need to invest in true logging next.

Because I've changed the song generation algorithm, in the next commit
I bump the project version up to `0.3.0-SNAPSHOT`.

In the commit after that, I bring in the
[`clj-http`](https://github.com/dakrone/clj-http) library. I intend to
connect to a Web API.

## [9e2fd55b608bb614ec0b3c49e3eebbf4a2c3f344][forecast]

Earlier in this project, I attempted to bring in a library for
connecting to Dark Sky's
[Forecast API](https://developer.forecast.io/). Now, I'm going to roll
a little client on my own. I set up a new file and new namespace:
`forecast`. I make a simple `forecast/call` function that takes a
latitude and longitude and makes a request to the API. I call it like
this:

    (apply forecast/call forecast/nyc-geo)

Lol this is not actually the lat/long for NYC.

## [5b2cfd7ad911703c0f7fe5dd49f2422ab17b6df8][forecast-time]

Here I fix my geo coordinates and also make call accept a `time`
parameter as well. This way, I can feed my RNG Seed (which is just
`now`) into this call and get the weather information at the time the
song was constructed. I also use `update` to parse the body of the
HTTP response as JSON using the standard, boring `clojure.data.json`.

## [645aed3e3c40f7663932424b1f9dd8ebaedb530f][nyc-at]

Finally, I refine this a bit by making a special function,
`nyc-at`. This is a clever bit of function composition if I do say so
myself. I create a `partial` function by applying the `nyc-geo`
coordinates to `call`. Now I have a generic call to the Forecast API
that I use to compose a more specific function for getting the weather
over Grand Central Terminal at a specific time. I shrink the response
by just requesting a daily summary of the weather.

Here's where this is going...

I recognize that I am affected by the weather. I want part of the song
generation algorithm to be affected by the weather, as well. Song
generation should take into account temperature, humidity,
precipitation, moon phase, length of day, etc. That way, the song is
not just some random spec, but a response to my surroundings.

This week, I used Clojure to connect to a web API and parse
some JSON. Next week I'll use that data to influence song generation.

🌼 Mark

[rand-tempo]: https://github.com/mwunsch/sonic-sketches/commit/0679d41e23ab9f315759342960cbaf54e071d5f6

[forecast]: https://github.com/mwunsch/sonic-sketches/commit/9e2fd55b608bb614ec0b3c49e3eebbf4a2c3f344

[forecast-time]: https://github.com/mwunsch/sonic-sketches/commit/5b2cfd7ad911703c0f7fe5dd49f2422ab17b6df8

[nyc-at]: https://github.com/mwunsch/sonic-sketches/commit/645aed3e3c40f7663932424b1f9dd8ebaedb530f

