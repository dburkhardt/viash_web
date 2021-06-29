---
title: "Dev Environment"
description: "Installation Requirements and Instructions."
lead: "Installation requirements and instructions."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-22T11:22:52+00:00"
draft: true
images: []
menu:
  docs:
    parent: "contributing"
weight: 730
toc: true
---



## Building from source

The following needs to be installed on your system in order to install
Viash:

-   GNU
    [Autotools](https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html#Autotools-Introduction)
-   OpenJDK
-   [sbt](https://www.scala-sbt.org/)

To build and install Viash, run the following commands.

``` bash
./configure --prefix=~
make
make install
```

If you wish to install Viash for all users and not just yourself, run
the following commands instead.

``` bash
./configure
make
sudo make install
```

To verify your installation, run the following command:

``` bash
viash --help
```

## Building from source using docker

If you have Java and Docker installed (but not `sbt`), run this instead:

``` bash
./configure --prefix=~
make docker
make install
```

To verify your installation, run the following command:

``` bash
viash --help
```

## IDE setup

<!-- todo: document -->
