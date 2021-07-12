---
title: "viash test"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-07-12T12:41:51+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 420
toc: true
---



Test the component using the tests defined in the viash config file.

Usage:

``` bash
viash test config.vsh.yaml [-p docker] [-k true/false]
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

### Running a test with no arguments

Test a Viash component with only the path to the [viash config
file](/docs/reference_config/config) as an argument. This will create a
temporary directory in the VIASH_TEMP directory (`/tmp/` by default) and
copy over any test files that are specified in the [viash config
file](/docs/reference_config/config).  
Next, Viash generates an executable inside that directory with the first
platform defined in in your config. If no platform is found, the [native
platform](/docs/reference_config/platform-native) is used.

Finally, Viash will run the test script to do a unit test, with the
results being printed out to the terminal.

``` bash
viash test config.vsh.yaml
```

### Test a specific platform

This runs a test on a component that utilises the Docker backend:

``` bash
viash test config.vsh.yaml --platform docker
```

### Always keep temporary files after running a test

The command below runs a test and prevents the deletion of temporary
files. By default, these files are only retained when an error occured.
Setting `keep` to `false` results in the temporary files being deleted
in all circumstances.

``` bash
viash test config.vsh.yaml -p native --keep true
```

### Override a config with config mods

Test a Viash component while using a [config
mod](/docs/advanced/config_mods) to override the [config
file](/docs/reference_config/config). In this case, pull an image from a
docker registry and specify a specific docker registry server URL.

``` bash
viash test config.vsh.yaml -p docker \
  -c '.platforms[.type == "docker"].setup_strategy := "pull"' \
  -c '.platforms[.type == "docker"].container_registry := "url-to-registry"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
