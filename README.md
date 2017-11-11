conf-edit.sh
============

Bash function to automatically store a configuration file in Git
before and after editing it.

Installation
------------

* Set `$EDITOR` in your `.bashrc` to your favorite editor, e.g. `EDITOR=vim`
* Set `$CONF_REPO` in your `.bashrc` to a Git repository in which to store configuration files, e.g. `CONF_REPO=/home/ubuntu/conf`
* Source `conf-edit.sh` in your `.bashrc`, e.g. `source /path/to/conf-edit/conf-edit.sh`
* Initialize `$CONF_REPO` as a Git repository:

    mkdir -p $CONF_REPO && cd $CONF_REPO && git init && git config core.name "conf-edit.sh" && git config core.email "conf-edit@localhost"

Usage
-----

Edit configuration files with `conf-edit`.
The command automatically runs your editor under `sudo` when needed. Example:

```
ubuntu@ubuntu:~$ conf-edit /etc/hosts
[sudo] password for ubuntu:
```

After editing, you can see the Git commits in `$CONF_REPO`:

```
ubuntu@ubuntu:~$ cd $CONF_REPO
ubuntu@ubuntu:conf$ git log
commit ff4002a5494fc6c900f77aed44cd0945675b9168
Author: conf-edit.sh <conf-edit@localhost>
Date:   Sat Nov 11 17:38:09 2017 +0100

    Update /etc/hosts
```
