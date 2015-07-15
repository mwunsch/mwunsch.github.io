---
title: POSSE Experiment
---

Experimenting with [POSSE](https://indiewebcamp.com/POSSE). 
I am creating a custom [Jekyll Generator](http://jekyllrb.com/docs/plugins/#generators)
that will look through unpublished posts in the "tumblelog" category and attempt
to publish those to Tumblr using the [Tumblr API client gem](https://github.com/tumblr/tumblr_client).
Hopefully, Tumblr returns a `Location` field with the newly published post.
I'll then rewire the Post data to include a link that new, canonical URL and mark it as published.
If the Tumblr API call fails, I will `abort` from the Generator.
I'll then use a Git _pre-push_ hook to publish all tumblelog posts before they get to GitHub.
TK.
