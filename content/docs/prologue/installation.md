---
title: "Installation"
description: "Installation requirements and instructions."
lead: "Installation requirements and instructions."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-04T12:59:10+00:00"
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
following command to download and run the bootstrap tool:

``` bash
wget -qO- get.viash.io | bash
```

To verify your installation, run the following command:

``` bash
bin/viash --help
```

### Installation options

Additional options can be set immediately or during a second run of the
bootstrap tool using the following syntax:

``` bash
wget -qO- get.viash.io | bash -s -- OPTIONS
```

For example, this command installs a release candidate of viash in a
directory named ‘applications’:

``` bash
wget -qO- get.viash.io | bash -s -- -bin applications -tag 0.5.0-rc3
```

Here’s the full list of options:

    --bin
    type: file
    default: bin
    Target dir for viash scripts and tools

    -r, --registry
    type: string
    default:
    Docker registry to use, only used when using a registry.

    --namespace_separator
    type: string
    default: _
    The separator to use between the component name and namespace as the image name of a Docker container.

    -c, --config_mod
    type: string, multiple values allowed
    Modify a viash config at runtime using a custom DSL. For more information, see the online documentation.

    -t, --tag
    type: string
    Which tag/version of viash to use, leave blank for the latest release

    --viash
    type: file
    A path to the viash executable. If not specified, this component will look for 'viash' on the $PATH.
