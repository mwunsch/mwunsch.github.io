---
title: Tumblelog POSSE
tumblr_id: 124842033165
---

For some time, I've had a strong interest in the principles of the [Indie Web](https://indiewebcamp.com/) movement.
Having seen many large corporate web platforms unceremoniously dismantled,
I'd like to protect my personal works regardless of platform affiliation.
It's all just `string`s after all.

Inspired by [Tantek](http://tantek.com/) and [Jeremy](https://adactio.com/),
I'm experimenting with the Indie Web's publishing model called [**POSSE**](https://indiewebcamp.com/POSSE):
_Publish (on your) Own Site, Syndicate Elsewhere_.

I think Tumblr is cool. I like the community features, I like the UI, and I appreciate its origin story.
However, I think everyone who publishes something on the Web should retain a healthy level of skepticism
for their platform (particularly when the platform derives revenue from an unassociated entity).

I recently migrated my [personal website](http://www.markwunsch.com/) to [Jekyll](http://jekyllrb.com/) and [GitHub Pages](https://pages.github.com/).
I've been experimenting with using plain text to publish to Tumblr for [awhile](http://staff.tumblr.com/post/441453675/the-tumblr-gem)
so it did not feel unnatural for me to author tumblelog posts in Jekyll and syndicate them to Tumblr.

I created a [Jekyll Generator](http://jekyllrb.com/docs/plugins/#generators) that would look for posts in the `tumblelog` category
and publish them to Tumblr, and then abort the Jekyll build process on success.
The Generator, along with the rest of the code, is [open source](https://github.com/mwunsch/mwunsch.github.io/blob/master/_plugins/publish_to_tumblr.rb).
I have a Git [pre-push hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) installed that runs `jekyll build`
whenever a new tumblelog post is authored (that's the reason for aborting the process).
You can see the code for the hook in the [`Rakefile`](https://github.com/mwunsch/mwunsch.github.io/blob/master/Rakefile).

The result is that the source for this post is first published to my Jekyll site before being syndicated to Tumblr.

The next steps are:

+ build out syndication for different tumblelog post types
+ implement [**PESOS**](https://indiewebcamp.com/PESOS) to pull my Tumblr archive into my Jekyll repository
