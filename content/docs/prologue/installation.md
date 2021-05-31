---
title: "Installation"
description: "Installation requirements and instructions."
lead: "Installation requirements and instructions."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-05-31T10:15:16+00:00"
draft: false
images: []
menu:
  docs:
    parent: "prologue"
weight: 110
toc: true
---



## Supported Operating Systems

You can run viash on the following operating systems:

-   Linux
-   macOS
-   Windows using [Windows Subsystem for
    Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Prerequisites

-   viash is developed in [Scala 2.12](https://www.scala-lang.org/), so
    you’ll need an [Oracle Java SE Runtime Environment 8
    installation](https://www.oracle.com/java/technologies/javase-jre8-downloads.html)
    or OpenJDK in order to use it.

## Installing viash

### Packaged release

To install viash, download the [latest
release](https://github.com/viash-io/viash/releases/latest) and save it
to the `~/bin` folder or any other directory that is specified your
`$PATH` variable. To verify what directories are included, run this
command:

``` bash
echo $PATH
```

#### Installing viash to \~/bin

In order to add `~/bin` to your $PATH, you need to edit `~/.bashrc` and
add the following line to the end of it:

``` bash
export PATH="$HOME/bin:$PATH"
```

You can use nano for this for example:

``` bash
nano ~/.bashrc
```

Next, create a `~/bin` folder, reload $PATH, download the latest release
of viash to `~/bin` and add executable permissions to viash. Here’s a
one-liner command that does this for you:

``` bash
mkdir ~/bin ; source ~/.bashrc &&
wget "https://github.com/viash-io/viash/releases/latest/download/viash" -O ~/bin/viash &&
chmod +x ~/bin/viash
```

To verify your installation, run the following command:

``` bash
viash --help
```

#### Installing viash to /usr/bin

If you wish to install viash to your usr/bin folder instead, run the
following command:

``` bash
sudo wget "https://github.com/viash-io/viash/releases/latest/download/viash" -O /usr/bin/viash
```

To verify your installation, run the following command:

``` bash
viash --help
```