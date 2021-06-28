---
title: "viash ns list"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-28T06:55:13+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 460
toc: true
---



List a namespace containing many viash config files.

Usage:

``` bash
viash ns list [-n nmspc] [-s src] [-p docker] [--tsv file.tsv]
```

## Arguments

### -c, –config\_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/advanced/config_mods).

### -k, –keep <arg>

Whether or not to keep temporary files. By default, files will be
deleted if all goes well but remain when an error occurs. By specifying
–keep true, the temporary files will always be retained, whereas –keep
false will always delete them. The temporary directory can be
overwritten by setting defining a VIASH\_TEMP directory.

### -l, –parallel

Whether or not to run the process in parallel.

### -p, –platform <arg>

Acts as a regular expression to filter the platform ids specified in the
found config files. If this is not provided, all platforms will be used.
If no platforms are defined in a config, the [native
platform](/docs/reference_config/platform-native) will be used. In
addition, the path to a platform yaml file can also be specified.

### -q, –query <arg>

Filter which components get selected by name and namespace. Can be a
regex. Example: “^mynamespace/component1$”.

### –query\_name <arg>

Filter which components get selected by name. Can be a regex. Example:
“^component1”.

### -n, –query\_namespace <arg>

Filter which namespaces get selected by namespace. Can be a regex.
Example: “^mynamespace$”.

### -s, –src <arg>

A source directory containing viash config files, possibly structured in
a hierarchical folder structure. Default: src/.

### -t, –tsv <arg>

Path to write a summary of the list results to.

### -h, –help

Show help message

## Examples

### List a namespace without arguments

When no arguments are given, the `ns list` command prints a **parsed**
version of all [config files](/docs/reference_config/config) in a
subdirectory named **src** to the terminal. This includes all fields,
even those that were not given values in the config file itself.  
See [Namespaces](/docs/projects/namespaces) for an overview of how you
should structure your components for this to work correctly.

``` bash
viash ns list
```

After running this command, you’ll see a list similar to this:

``` bash
- functionality:
    name: "download_files"
    namespace: "my_namespace"
    authors: []
    arguments:
    - type: "string"
      name: "url"
      alternatives: []
      required: false
      direction: "Input"
      multiple: true
      multiple_sep: " "
    - type: "string"
      name: "--filter"
      alternatives: []
      required: false
      direction: "Input"
      multiple: false
      multiple_sep: ":"
    resources:
    - type: "bash_script"
      path: "script.sh"
      is_executable: true
...
```

### Specifying a source folder and a namespace

In order for namespace querying to work, make sure your config files
include a [namespace
field](/docs/reference_config/functionality/#namespace-string). The
command below searches the **my\_components\_dir** directory for all
Viash components in the **my\_namespace** namespace and prints out the
config information to the terminal.

``` bash
viash ns list --src 'my_components_dir' -n 'my_namespace'
```

### Filter a specific component to list

This lists any Viash components where the name contains “parse”:

``` bash
viash ns list --query_name  "parse"
```

### Override a namespace with config mods

List a Viash namespace and use a [config
mod](/docs/advanced/config_mods) to override the [config
files](/docs/reference_config/config).

``` bash
viash ns list -p docker \
  -c '.platforms[.type == "docker"].setup_strategy := "pull"' \
  -c '.platforms[.type == "docker"].image := "bash:latest"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
-   [Namespaces](/docs/projects/namespaces)
