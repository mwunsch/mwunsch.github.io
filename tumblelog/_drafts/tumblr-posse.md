---
title: POSSE Experiment
---

Experimenting with [POSSE](https://indiewebcamp.com/POSSE). 
I am going to attempt to create a build step on a Github hook so that if I publish something to
this Jekyll category, it will be published to Tumblr via API.
Open questions include how do I get my Tumblr OAuth keys into the system securely,
how do I "mark" the post as "published on Tumblr",
and how wacky do I want to get with Tumblr post types and Jekyll frontmatter.
Thoughts are maybe I could use Travis for this kind of build, but unsure how to commit back into the repo...
If the response is different, Travis job will fail. Hopefully, Tumblr returns a `Location` field,
which should be added to the Post object... maybe? How?
Maybe just a good ol' fashioned pre-push Git Hook?
TK.
