---
title: The Programs of the Week the Internet Gets Real Unfunny
message_id: <o4ytl7.8b6crw3ze2kk@markwunsch.com>
---

This Week's Program: Mar 28 - Apr 1
===================================

April Fool's on the Internet is a drag and nobody needs more email
today so let's just plow through these commits:

## [f65eb1c716fce0dfc26ad8f9d6888c7fefbdf697][new-data-points]

New data points to consider in song generation. The average
temperature and the length of the day in hours.

## [f5e43c7f16d37c827cf1d7e929d8b10e6983f4dc][daily-data-map]

Those calculations get moved into a new fn to clean up what happens in
`gen-song`. I do some fancy Clojure destructuring to make this look
easy.

## [e8612d50780290a8cebc0c084c69b88965b35475][datagen]

I make a philosophical API design decision. I want to try to restrict
calls out to the `datagen` functions to occur only within
`gen-song`. Not totally realistic but it restricts side effects
(random number generation is a side effect) to only one place. Clojure
destructuring makes this awesome and easy.

## [fdf17d4e3386ae43bfd14724866991873689231f][key-range]

I define `key-range` which is all the notes in order across three
octaves. I then use temperature and do some scaling to map temperature
to a pitch in that range. Hotter is higher. Daily average temperature
determines the key of the song.

The commits that follow that are mostly cleanup and refactoring
commits. I do some more tricks with destructuring and I abstract some
of the functionality of the program out of the `main` function and
into a function called `generate->record->upload`.

Next week I'll finish up song generation stuff and prepare to
productionize this code.

Keep it classy on April Fools,<br />
🃏 Mark

[new-data-points]: https://github.com/mwunsch/sonic-sketches/commit/f65eb1c716fce0dfc26ad8f9d6888c7fefbdf697

[daily-data-map]: https://github.com/mwunsch/sonic-sketches/commit/f5e43c7f16d37c827cf1d7e929d8b10e6983f4dc

[datagen]: https://github.com/mwunsch/sonic-sketches/commit/e8612d50780290a8cebc0c084c69b88965b35475

[key-range]: https://github.com/mwunsch/sonic-sketches/commit/fdf17d4e3386ae43bfd14724866991873689231f

