---
title: "Installation"
description: "Installation requirements and instructions."
lead: "Installation requirements and instructions."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-01T13:43:27+00:00"
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
-   You will need [Docker](https://docs.docker.com/get-docker/) to
    install viash and use it to its full potential.

## Installing viash

To install viash to a **bin** folder in your current directory, run the
following command:

``` bash
wget -qO- get.viash.io | bash
```

To verify your installation, run the following command:

``` bash
bin/viash --help
```
