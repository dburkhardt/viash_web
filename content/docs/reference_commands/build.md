---
title: "viash build"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-07-12T12:41:47+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 410
toc: true
---



Build an executable from the provided viash config file.

Usage:

``` bash
viash build config.vsh.yaml -o output [-p docker] [-m] [-s]
```

## Arguments

### –config

A [viash config file](/docs/reference_config/config) (example:
`config.vsh.yaml`). This argument can also be a script with the config
as a header.

### -c, –config_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/advanced/config_mods). (default = List())

### -m, –meta

Print out some meta information at the end.

### -o, –output <arg>

Path to directory in which the executable and any resources is built to.
Default: “output/”. (default = output/)

### -p, –platform <arg>

Specifies which platform amongst those specified in the [viash
config](/docs/reference_config/config) to use. If this is not provided,
the first platform will be used. If no platforms are defined in the
[viash config](/docs/reference_config/config), the [native
platform](/docs/reference_config/platform-native) will be used. In
addition, the path to a platform yaml file can also be specified.

### –push

Whether or not to push the container to a Docker registry \[[Docker
platform](/docs/reference_config/platform-docker) only\].

### -s, –setup <arg>

Which setup strategy for creating the container to use \[[Docker
platform](/docs/reference_config/platform-docker) only\].

### -w, –write_meta

Write out some meta information to RESOURCES_DIR/viash.yaml at the end.

### -h, –help

Show help message

## Examples

### Building with no arguments

Build a Viash component with only the path to the [viash config
file](/docs/reference_config/config) as an argument. This will create an
‘output’ directory and generate an executable inside it with the first
platform defined in in your config. If no platform is found, the [native
platform](/docs/reference_config/platform-native) is used:

``` bash
viash build config.vsh.yaml
```

### Specifying a platform and an output folder

This builds a Viash component based on your [viash config
file](/docs/reference_config/config) in a ‘bin’ folder that will use
Docker to run:

``` bash
viash build config.vsh.yaml --platform docker --output "bin"
```

### Using a Docker setup strategy post-build

Create a build for the Docker platform and afterwards execute a
`---setup` with a specific [docker setup
strategy](/docs/running/executables-docker).

``` bash
viash build config.vsh.yaml -p docker --setup alwaysbuild
```

### Print out meta information

Build a Viash component for the native platform and output information
about the build in the terminal:

``` bash
viash build config.vsh.yaml -p native --meta
```

Here’s an example of what the output might look like:

``` bash
viash version:      0.5.0
config:             config.vsh.yaml
platform:           native
executable:         output/hello_world
output:             output/
remote git repo:    <NA>
```

### Generate a meta file

This builds a Viash component and puts a **viash.yaml** file next to the
executable containing the full configuration information of the
component for later reference:

``` bash
viash build config.vsh.yaml --write_meta
```

### Override a config with config mods

Build a Viash component and use a [config
mod](/docs/advanced/config_mods) to override the [config
file](/docs/reference_config/config). In this case, pull an image from a
docker registry and specify a specific docker registry server URL.

``` bash
viash build config.vsh.yaml -p docker \
  -c '.platforms[.type == "docker"].setup_strategy := "pull"' \
  -c '.platforms[.type == "docker"].container_registry := "url-to-registry"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
-   [Executables with a Docker
    backend](/docs/running/executables-docker)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
