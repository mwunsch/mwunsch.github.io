---
title: The Programs of the Week of the Chinese New Year
message_id: <okg9iu.296eepzh22qsd@markwunsch.com>
---

This Week's Program: Jan 23 - Jan 27
====================================

Hello everyone. I am going to do my best to keep this newsletter a
POTUS free-zone. Like me, you probably are getting doses of this
reality shoved down your throat through several different channels. I
think it's important to stay aware and resilient and fight, but we
shouldn't allow this regime to invade every crevice of our life. I am
choosing to focus on my work with computers, and this newsletter will
be a refuge where we can talk about computers in relative isolation
from the chaos and "carnage" that is being inflicted. I feel like I
have needed to write a disclaimer for each newsletter, apologizing for
not doing my duty. My duty is to continue to produce work that is
meaningful and that helps others. That's what I'll be focusing on.

Last week, I ran `git init`
on [`mechwarper`](https://github.com/mwunsch/mechwarper). That's where
my focus has been this week. If you're newer to this Tinyletter, you
can read about [my interest in FreeBSD][freebsd-tinyletter]. I'm a
sysadmin newb, but now I'm back in DevOps-mode. So far I've found
Ansible to be pretty cool.

## [c0fd164d7d622ad5c7d4c549a0f9a712d5df64ac][install-python]

The first step in administering a FreeBSD server (one bootstrapped by
Digital Ocean), is to install Python. Ansible needs Python to run, but
you can use Ansible's [`raw` module][raw-module] to ensure Python is
on the machine.

This commit failed.

## [e2cddcb0437df385b1122bcf4f5f121b344e6c91][gather_facts]

The previous commit failed because the first thing Ansible does when
running tasks in a Playbook is run a [`setup`][setup-module] step that
"gathers facts about remote hosts." Ansible can't gather facts when
Python is not installed. Luckily, we can disable this step. I also
need to become the root user in order to `pkg install`.

    - hosts: all
      remote_user: freebsd
      gather_facts: no
      become: true
      tasks:
        - name: install python
          raw: env ASSUME_ALWAYS_YES=YES pkg install python


With this, and running `ansible-playbook -i hosts site.yml`, Python is
now in place on the FreeBSD server. Now we're coding some
infrastructure!

## [189007cf950661308ee0b319438ffb5773eaca72][pkgng]

In another "play", with Python installed and Ansible able to do what
Ansible does best, I install `bash` and `git`. Thankfully Ansible has
a [pkgng][pkgng-module] module for FreeBSD. It's important to use the
best Ansible module for the job. Since every task that Ansible runs
needs to be idempotent, using the right module means you can better
express when something has changed state or not.

## [66649be5eabc9c1c79d890c54474224c46338a71][fdescfs]

One thing I frequently see in
FreeBSD [tutorials][freebsd-getting-started] is a line about bash
needing an update in `etc/fstab`:

    fdesc /dev/fd fdescfs rw 0 0

I have never really thought much
about [this file](https://www.freebsd.org/cgi/man.cgi?fstab(5))
before, but now I was curious. When I install bash and run it, nothing
seems to be out of the ordinary. What does this line do and why do I
need it? The file-descriptor file system, or [`fdescfs`][fdescfs-man],
is necessary for
bash [process substitution][process-substitution]. `fdescfs` provides
the `/dev/fd` directory and per-process file descriptors. File
systems — who knew?

Ansible's [mount][mount-module] sets this up.

With bash installed I write some more tasks to create my user and
install some of the other utilities I use, like Emacs.

## [11f56ea5dda6a3babddb158f6b5dc2cb9a1814ed][pkg-info]

One thing that bothered me was that every time I ran the playbook, the
`install python` step would show a _change_, even though nothing was
changed! This was because Ansible's `raw` module doesn't have the
ability to show itself as being changed or not like other modules
do. My solution is to do a check with `pkg info -e` so that I don't
run the `install` command if python already exists. I then `register`
the result of the module and only mark it as
[`changed_when`][changed_when] the stdout of the task is not empty.

I did a few different variations of this before settling here, and you
can see my previous attempt in the diff.

## [d0ddadca91fc396ce2aa7e4aa9cad5b0aeb8b6d1][timezone]

Finally, I update the system timezone to `America/New_York`. Ansible
has a special [timezone][timezone-module] module, but the version of
Ansible that I installed with `pip` doesn't yet support it for BSD.

Then, I make sure that [NTP](http://ntp.org) is running so that my
system time stays correct. I could have used
the [`sysrc`](https://www.freebsd.org/cgi/man.cgi?query=sysrc) command
to make sure this was configured properly, but by using
Ansible's [lineinfile][lineinfile] module I could make sure that the
`changed` state would be set correctly.

Slowly but surely, the setup of my FreeBSD server is being
codified. With Ansible I can always repeat and replay the things I've
done to make a server my own. I'm excited to continue iterating on
making a personal server environment that I feel productive in. I'll
continue making updates to `mechwarper` as I learn more.

Next week I'll also begin ramping-up on Racket.

🐓 Mark

[freebsd-tinyletter]: http://www.markwunsch.com/tinyletter/2016/08/starting_anew.html

[install-python]: https://github.com/mwunsch/mechwarper/commit/c0fd164d7d622ad5c7d4c549a0f9a712d5df64ac

[raw-module]: https://docs.ansible.com/ansible/raw_module.html

[gather_facts]: https://github.com/mwunsch/mechwarper/commit/e2cddcb0437df385b1122bcf4f5f121b344e6c91

[setup-module]: https://docs.ansible.com/ansible/setup_module.html

[pkgng]: https://github.com/mwunsch/mechwarper/commit/189007cf950661308ee0b319438ffb5773eaca72

[pkgng-module]: https://docs.ansible.com/ansible/pkgng_module.html

[fdescfs]: https://github.com/mwunsch/mechwarper/commit/66649be5eabc9c1c79d890c54474224c46338a71

[freebsd-getting-started]: https://www.digitalocean.com/community/tutorials/how-to-get-started-with-freebsd-10-1

[fdescfs-man]: https://www.freebsd.org/cgi/man.cgi?query=fdescfs&sektion=5

[process-substitution]: http://tldp.org/LDP/abs/html/process-sub.html

[mount-module]: https://docs.ansible.com/ansible/mount_module.html

[pkg-info]: https://github.com/mwunsch/mechwarper/commit/11f56ea5dda6a3babddb158f6b5dc2cb9a1814ed

[changed_when]: http://docs.ansible.com/ansible/playbooks_error_handling.html#overriding-the-changed-result

[timezone]: https://github.com/mwunsch/mechwarper/commit/d0ddadca91fc396ce2aa7e4aa9cad5b0aeb8b6d1

[timezone-module]: https://docs.ansible.com/ansible/timezone_module.html

[lineinfile]: https://docs.ansible.com/ansible/lineinfile_module.html
