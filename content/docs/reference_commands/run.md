---
title: "viash run"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-07-12T12:41:51+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 400
toc: true
---



Executes a viash component from the provided viash config file. viash
generates a temporary executable and immediately executes it with the
given parameters.

Usage:

``` bash
viash run config.vsh.yaml [-p docker] [-k true/false]  -- [arguments for script]
```

## Arguments

### –config

A [viash config file](/docs/reference_config/config) (example:
`config.vsh.yaml`). This argument can also be a script with the config
as a header.

### -c, –config_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/advanced/config_mods). (default = List())

### -k, –keep <arg>

Whether or not to keep temporary files. By default, files will be
deleted if all goes well but remain when an error occurs. By specifying
–keep true, the temporary files will always be retained, whereas –keep
false will always delete them. The temporary directory can be
overwritten by setting defining a VIASH_TEMP directory.

### -p, –platform <arg>

Specifies which platform amongst those specified in the [viash
config](/docs/reference_config/config) to use. If this is not provided,
the first platform will be used. If no platforms are defined in the
[viash config](/docs/reference_config/config), the [native
platform](/docs/reference_config/platform-native) will be used. In
addition, the path to a platform yaml file can also be specified.

### -h, –help

Show help message

## Examples

### Running without arguments

Simply run a Viash component with its default platform and no script
arguments:

``` bash
viash run config.vsh.yaml
```

### Passing script arguments

Run a component with script arguments:

``` bash
viash run config.vsh.yaml -- --input="Hello!" -o=my_file.txt
```

### Preserve temporary files

Here’s how you run a Viash component using the [Docker
platform](/docs/reference_config/platform-docker) and keep the temporary
files:

``` bash
viash run config.vsh.yaml --platform docker --keep true
```

### Combining run options with script arguments

This example runs a component using the [native
platform](/docs/reference_config/platform-native) and passes arguments
to the script:

``` bash
viash run config.vsh.yaml --platform native -- --input="Hello!" -o=my_file.txt
```

### Override a config with config mods

Run a Viash component using a [config mod](/docs/advanced/config_mods)
to override the [config file](/docs/reference_config/config). In this
case, pull an image from a docker registry and specify a specific docker
registry server URL.

``` bash
viash run config.vsh.yaml -p docker \
  -c '.platforms[.type == "docker"].setup_strategy := "pull"' \
  -c '.platforms[.type == "docker"].container_registry := "url-to-registry"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
