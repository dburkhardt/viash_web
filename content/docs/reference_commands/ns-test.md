---
title: "viash ns test"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-28T06:55:14+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_commands"
weight: 450
toc: true
---



Test a namespace containing many viash config files.

Usage:

``` bash
viash ns test [-n nmspc] [-s src] [-p docker] [--parallel] [--tsv file.tsv] [--append]
```

## Arguments

### -a, –append

Append to tsv instead of overwrite

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

Path to write a summary of the test results to.

### -h, –help

Show help message

## Examples

### Testing with no arguments

When no arguments are given. All components in a subdirectory named
**src** are tested. This includes testing if a component can be built
and any tests defined in its [config
file](/docs/reference_config/config). See
[Namespaces](/docs/projects/namespaces) for an overview of how you
should structure your components for this to work correctly.

``` bash
viash ns test
```

After running this command, a test report is printed to the terminal
with the results.

### Specifying a source folder and a namespace

In order for namespace querying to work, make sure your config files
include a [namespace
field](/docs/reference_config/functionality/#namespace-string). The
command below searches the **my\_components\_dir** directory for all
Viash components in the **my\_namespace** namespace and tests them.

``` bash
viash ns test --src 'my_components_dir' --query_namespace 'my_namespace'
```

### Filter a specific component to test

This tests any Viash components where the name contains “parse”:

``` bash
viash ns test --query_name  "parse"
```

### Test a specific platform

This runs a test on all components that utilises the Docker backend:

``` bash
viash ns test --platform docker
```

### Run the tests in parallel

By default, the testing of namespaces is a serial process, meaning every
components gets tested one by one. With the `--parallel` option, you can
run the process in parallel, allowing you to test all of the components
at the same time, potentially saving you a lot of time:

``` bash
viash ns test --parallel
```

### Save the test results in a file

You can export the test results to a tab-seperated values (TSV) file
with the `--tsv` option. In the example below, a file named
**report.tsv** gets generated.

``` bash
viash ns test --tsv "report.tsv"
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
-   [Namespaces](/docs/projects/namespaces)
