---
title: The Programs of the Week of America's Birthday
message_id: <oa04ke.yeqyh1vwj4dn@markwunsch.com>
---

This Week's Program: July 4 - July 8
====================================

I took this Monday off to celebrate the birth of this great
nation. I don't have anything original or encouraging to offer about
current events in this country. There are voices that are more
important than mine in these matters. I'm staying focused on work and
the code.

Last week was crackerjack. This week, I hit another big milestone.

## [516d5e691d700e25f5a0c0f1d7a44d99a551da43][iamrole]

In this commit, I'm adding an [IAM Instance Profile][instance-profile]
to the EC2 Instance. The Instance Profile is a container for an
[IAM Role](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html). The
Role is used for the EC2 instance to communicate to other AWS
resources. For the purpose of `sonic-sketches`, this is the S3 bucket
that houses the wav files. I make the role _super_ permissive and
that's something I should probably revisit; both for security purposes
but also as a way to learn more about IAM policies generally.

## [41113058da798ff9b422f44dcc4f9370b0beed3b][amazonica-credentials]

In this commit, I remove the credential map that `amazonica` uses to
[authenticate](https://github.com/mcohen01/amazonica#authentication)
to AWS. Without this, Amazonica will use the `CredentialProviderChain`
mechanism to find credentials. For local purposes, this is will be the
default profile in the credentials file. When `sonic-sketches` runs in
EC2, this will end up using the Instance Profile in the EC2 metadata.

Here was the big milestone. I spun up this CloudFormation stack,
shelled into the instance, ran `jackd`, installed `git` (through
`apt-get install`), and cloned the `sonic-sketches` repo. I was able
to `lein trampoline run` sonic-sketches, and ended up with a song in
my S3 bucket.

[Here's a song for Wednesday.](https://soundcloud.com/mwunsch/wednesday-1255119215948521291)

That song was created entirely in the AWS cloud. Feels great.

## [6b801960270f17c7687082d72072b238fbe3e455][codedeploy-application]

I stub out the work to add a
[CodeDeploy Application][codedeploy-resource] resource to my
CloudFormation template. This will be my second encounter with
CodeDeploy. The first time I had no idea what I was doing. This time I
have more of an idea what I'm doing, but that's not saying much. I'm
ready.

The goal for next week will be getting the `sonic-sketches` repository
onto the EC2 instance in a repeatable manner with CodeDeploy.

Until then,<br />
– Mark

[iamrole]: https://github.com/mwunsch/sonic-sketches/commit/516d5e691d700e25f5a0c0f1d7a44d99a551da43

[instance-profile]: http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html

[amazonica-credentials]: https://github.com/mwunsch/sonic-sketches/commit/41113058da798ff9b422f44dcc4f9370b0beed3b

[codedeploy-application]: https://github.com/mwunsch/sonic-sketches/commit/6b801960270f17c7687082d72072b238fbe3e455

[codedeploy-resource]: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codedeploy-application.html

