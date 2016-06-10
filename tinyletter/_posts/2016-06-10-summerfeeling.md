---
title: The Programs of a Week in June
message_id: <o8k8cs.3jd4vyll5w7l4@markwunsch.com>
---

This Week's Program: June 6 - June 10
=====================================

When AWS makes you feel like a wizard.<br />
When you have forgotten that January blizzard.<br />
When Hacker News has your career reconsidered.<br />
That summer feeling is gonna
[haunt](https://www.youtube.com/watch?v=TpJvXo6RNu8) you
one day in your life.

Thanks to everyone who sent in well-wishes last week! This week was
slow in code but dense in learning.

## [87bfceb6abe89160a318d69288d2ae1fb3b8eac8][ami-tag]

I added a
[tag](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html)
to my sonic-sketches API. This is just a bit of metadata that will
come into play later.

## [0e2ffd0aae3f9888976cea1504a84bb325b07583][codedeploy]

I add the default
[appspec.yml](http://docs.aws.amazon.com/codedeploy/latest/userguide/writing-app-spec.html)
template for AWS CodeDeploy. This little YAML file will eventually be
used to deploy the latest sonic-sketches revision onto the EC2
instance built by Packer. I'm still acting at the very edge of my
knowledge so I'm not entirely sure how all of this will string
together, but what's another YAML file amongst friends?

## [8c5b5b1dbadc96f2ccb21fd0d71e2540c8caf3a0][yaml-mode]

I add `yaml-mode` to my Emacs configuration. Why isn't everything just
Lisp?

## [f9422620e35d11871a47a6b65151da475bc1f4c3][formation]

I turned my attention then to
[AWS CloudFormation](https://aws.amazon.com/cloudformation/), which
can use that metadata tag to bring up a whole "cloud" of its own. So
far, the `sonic-sketches` cloud requires EC2, S3, potentially
CloudDeploy, potentially Lambda, and potentially other things. I can
group all of these resources together in a
[formation](http://www.beyonce.com/formation/) (🍋). As I'm learning, I
stub out a CloudFormation
[template](https://aws.amazon.com/cloudformation/aws-cloudformation-templates/),
similar to how I did with CloudDeploy.

## [8243f74224354f06ee6091d4dd39ef8834524397][baskerville]

GitHub
[recently announced](https://github.com/blog/2186-https-for-github-pages)
that its hosted pages will now be served over https. That's cool. I'm
not immediately affected by that but I use this opportunity to remove
Typekit from <http://markwunsch.com>. I think Typekit is super great,
but I want my site to be as fast as can be, and I wasn't using the
serif it was pulling in as much as I thought I would have. This is a
subtle change but I really like it.

## [63516b12cd21c927d4847d2d826bf0ffd09f4f12][break-word]

I also change the font-size a bit on mobile breakpoints, mostly to
make sure that the site looks good on an iPad split screen view, which
I utilize a lot.

See you next week. Enjoy that summer feeling!

🐝 Mark

[ami-tag]: https://github.com/mwunsch/sonic-sketches/commit/87bfceb6abe89160a318d69288d2ae1fb3b8eac8

[codedeploy]: https://github.com/mwunsch/sonic-sketches/commit/0e2ffd0aae3f9888976cea1504a84bb325b07583

[yaml-mode]: https://github.com/mwunsch/emacs.d/commit/8c5b5b1dbadc96f2ccb21fd0d71e2540c8caf3a0

[formation]: https://github.com/mwunsch/sonic-sketches/commit/f9422620e35d11871a47a6b65151da475bc1f4c3

[baskerville]: https://github.com/mwunsch/mwunsch.github.io/commit/8243f74224354f06ee6091d4dd39ef8834524397

[break-word]: https://github.com/mwunsch/mwunsch.github.io/commit/63516b12cd21c927d4847d2d826bf0ffd09f4f12

