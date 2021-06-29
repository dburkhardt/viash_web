---
title: "viash config view"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-28T06:54:50+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 430
toc: true
---



View the [viash config](/docs/reference_config/config) file after
parsing.

Usage:

``` bash
viash config view config.vsh.yaml
```

## Arguments

### –config

A [Viash config file](/docs/reference_config/config) (example:
`config.vsh.yaml`). This argument can also be a script with the config
as a header.

### -c, –config\_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/advanced/config_mods).

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

### Print a Viash config to the terminal

The `config view` command prints a **parsed** version of a [config
file](/docs/reference_config/config) to the terminal. This includes all
fields, even those that were not given values in the config file itself:

``` bash
viash config view config.vsh.yaml
```

For the [hello\_world example config
file](/examples/hello_world/config.vsh.yaml), this prints out the
following:

``` yaml
functionality:
  name: "hello_world"
  authors: []
  arguments:
  - type: "string"
    name: "input"
    alternatives: []
    required: false
    direction: "Input"
    multiple: true
    multiple_sep: " "
  - type: "string"
    name: "--greeter"
    alternatives: []
    default: "Hello world!"
    required: false
    direction: "Input"
    multiple: false
    multiple_sep: ":"
  resources:
  - type: "bash_script"
    path: "script.sh"
    is_executable: true
    parent: "file:///home/user/hello_world/config.vsh.yaml"
  description: "A very simple 'Hello world' component."
  tests:
  - type: "bash_script"
    path: "test.sh"
    is_executable: true
    parent: "file:///home/user/hello_world/config.vsh.yaml"
  info: {}
platforms:
- type: "native"
  id: "native"
  setup: []
- type: "docker"
  id: "docker"
  image: "bash:4.0"
  namespace_separator: "_"
  resolve_volume: "Automatic"
  chown: true
  setup_strategy: "alwayscachedbuild"
  push_strategy: "pushifnotpresent"
  privileged: false
  setup: []
- type: "docker"
  id: "alpine"
  image: "alpine"
  namespace_separator: "_"
  resolve_volume: "Automatic"
  chown: true
  setup_strategy: "alwayscachedbuild"
  push_strategy: "pushifnotpresent"
  privileged: false
  setup:
  - type: "apk"
    packages:
    - "bash"
```

### Override a config with config mods

Prints out what a **parsed** Viash component config would look like
while using a [config mod](/docs/advanced/config_mods) to override the
[config file](/docs/reference_config/config).

``` bash
viash config view config.vsh.yaml \
-c '.platforms[.type == "docker"].setup_strategy := "pull"' \
-c '.platforms[.type == "docker"].image := "bash:latest"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
