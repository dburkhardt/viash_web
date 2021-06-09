---
title: "viash ns build"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-08T12:28:35+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 440
toc: true
---



Build a namespace from many viash config files.

Usage:

``` bash
viash ns build [-n nmspc] [-s src] [-t target] [-p docker] [--setup] [---push] [--parallel] [--flatten]
```

## Arguments

### –config

A [viash config file](/docs/reference_config/config) (example:
`config.vsh.yaml`). This argument can also be a script with the config
as a header.

### -c, –config\_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/reference_config/config_mods).

### -f, –flatten

Flatten the target builds, handy for building one platform to a bin
directory.

### -l, –parallel

Whether or not to run the process in parallel.

### -p, –platform <arg>

Acts as a regular expression to filter the platform ids specified in the
found config files. If this is not provided, all platforms will be used.
If no platforms are defined in a config, the [native
platform](/docs/reference_config/platform-native) will be used. In
addition, the path to a platform yaml file can also be specified.

### –push

Whether or not to push the container to a Docker registry \[[Docker
platform](/docs/reference_config/platform-docker) only\].

### -q, –query <arg>

Filter which components get selected by name and namespace. Can be a
regex. Example: “^mynamespace/component1$”.

### –query\_name <arg>

Filter which components get selected by name. Can be a regex. Example:
“^component1”.

### -n, –query\_namespace <arg>

Filter which namespaces get selected by namespace. Can be a regex.
Example: “^mynamespace$”.

### –setup

Whether or not to set up the platform environment after building the
executable.

### -s, –src <arg>

A source directory containing viash config files, possibly structured in
a hierarchical folder structure. Default: src/.

### -t, –target <arg>

A target directory to build the executables into. Default: target/.

### -w, –write\_meta

Write out some meta information to RESOURCES\_DIR/viash.yaml at the end.

### -h, –help

Show help message

## Examples

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/reference_config/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
