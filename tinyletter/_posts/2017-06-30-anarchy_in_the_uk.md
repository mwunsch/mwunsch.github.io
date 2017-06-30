---
title: The Programs of the Week of Harry's Launch in the UK
message_id: <osdmjn.311y4nh653sd7@markwunsch.com>
---

This Week's Program: June 26 - June 30
======================================

Last week I was kind of sneaky and said that at
my [work job](https://www.harrys.com/en/us), my team had reached a big
milestone. This week, my employer Harry's unveiled what that
was: [**Harry's is now live in the UK!**][instagram]

My team has been hard at work planning and executing this launch for
the past year. This is some damn fine engineering. We've been
releasing incremental changes over the past several months,
culminating in us changing a line or two of configuration last week,
opening up the site for UK customers. I'm so proud of my team, and am
so thrilled to have been a part of such a smooth launch. If you're in
the United Kingdom, _Keep Calm and Buy Some Razors From My Company
Please_.

This was so exciting, and kept me away from doing anything really
meaningful in Overscan, but I managed to sneak in a few commits here
and there.

## [faca7c5fc96802d7d793e73d8b68a8ad9317c2dc][pip]

In this commit, I remove a bunch of code related to building the scene
for picture-in-picture. This had been kind of gnarly. By moving the
burden of making sure scaling and videorates were working correctly I
could finally get something relatively stable.

## [244609bb783aaa0eeab591080c216c65de39bca4][camera-src]

Similarly, in this commit I push caps and `videorate` into scene
creation. This lets me circumvent last week's odd uprezzing behavior.

## [83dcec92fda7d2ab88bcf22ed51c0fa0c66a8988][outargs-1]

The rest of the week I spent on rationalizing using outbound,
call-by-reference arguments. Arguments in C with GObject Introspection
are annotated with a `direction`: they either are inputs, outputs, or
serve as both. I had been having a huge amount of trouble dealing with
C output arguments.

This first commit is a rough draft but gets me 90% there. When there's
an `out` argument, I do a `malloc` of the type of the argument and
have that sent to the `invoke` function. In the values returned by
invocation (which has multiple return values just for this purpose), I
loop through the output arguments and dereference the pointers.

An example of using that in GStreamer is something like the C
function, [`gst_util_double_to_fraction`][double-to-fraction]. This
function takes a Double and two output pointers to Integers and
returns Void. The outputs are called-by-reference and are set as the
numerator and the denominator for a fraction.

    void util_double_to_fraction (gdouble src, gint32 *dest_n, gint32 *dest_d)

Fractions are used all over the place in GStreamer for things like
Aspect Ratios and Framerates. I could not get this function to work
earlier. Now with this new commit I can do:

    > (define double->fraction (gst 'util_double_to_fraction))
    > (double->fraction 0.75)
    3
    4
    > (double->fraction 0.5)
    1
    2

Nice! So here I only call this function with its input arguments, and
output arguments are automatically created and returned. But this
still isn't quite right.

## [8ae908ce1e953ef7c34ced0815a092c7469f0b18][outargs-2]

The last bit here was making sure that `inout` arguments worked
correctly, which required a bit more refinement. I cleanup function
invocation quite a bit and build some abstractions (like the new
function `gi-type-malloc`). I also go in and clean up a bunch of C
Array handling code. Hey here's this:

    > (define fraction->double (gst 'util_fraction_to_double))
    > (fraction->double 1 2)
    0.5
    > (fraction->double 2 3)
    0.6666666666666666

It all comes full circle. Now I can do that _real_ sick C programming
but not actually in C.

I hope you have a great weekend!

💂 Mark


[instagram]: "https://www.instagram.com/p/BV4hu2ZnQd6/?taken-by=harrys"

[pip]: https://github.com/mwunsch/overscan/commit/faca7c5fc96802d7d793e73d8b68a8ad9317c2dc

[camera-src]: https://github.com/mwunsch/overscan/commit/244609bb783aaa0eeab591080c216c65de39bca4

[outargs-1]: https://github.com/mwunsch/overscan/commit/83dcec92fda7d2ab88bcf22ed51c0fa0c66a8988

[double-to-fraction]: https://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gstreamer-GstUtils.html#gst-util-double-to-fraction

[outargs-2]: https://github.com/mwunsch/overscan/commit/8ae908ce1e953ef7c34ced0815a092c7469f0b18
