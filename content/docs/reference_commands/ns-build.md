---
title: "viash ns build"
description: ""
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-28T06:55:11+00:00"
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

### -c, –config\_mod <arg>…

Modify a [viash config](/docs/reference_config/config) at runtime using
a [custom DSL](/docs/advanced/config_mods).

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

### Building with no arguments

When no arguments are given. All components in a subdirectory named
**src** are built with all available platforms to a directory named
**target**. See [Namespaces](/docs/projects/namespaces) for an overview
of how you should structure your components for this to work correctly.

``` bash
viash ns build
```

Here’s the output when running this command with three component that
support the native and docker platforms:

``` bash
Exporting src/parse_images/ (my_namespace) =native=> target/native/my_namespace/parse_images
Exporting src/parse_images/ (my_namespace) =docker=> target/docker/my_namespace/parse_images
Exporting src/download_files/ (my_namespace) =native=> target/native/my_namespace/download_files
Exporting src/download_files/ (my_namespace) =docker=> target/docker/my_namespace/download_files
Exporting src/render_mp4/ (my_namespace) =native=> target/native/my_namespace/render_mp4
Exporting src/render_mp4/ (my_namespace) =docker=> target/docker/my_namespace/render_mp4
```

This is how the structure of the **target** directory might look like
after running this command:

``` bash
target
├── docker
│   └── my_namespace
│       ├── download_files
│       │   └── download_files
│       ├── parse_images
│       │   └── parse_images
│       └── render_mp4
│           └── render_mp4
└── native
    └── my_namespace
        ├── download_files
        │   └── download_files
        ├── parse_images
        │   └── parse_images
        └── render_mp4
            └── render_mp4
```

### Specifying a source folder and a namespace

In order for namespace querying to work, make sure your config files
include a [namespace
field](/docs/reference_config/functionality/#namespace-string). The
command below searches the **my\_components\_dir** directory for all
Viash components in the **my\_namespace** namespace and builds them into
executables.

``` bash
viash ns build --src 'my_components_dir' --query_namespace 'my_namespace'
```

### Filter a specific component to build

This builds any Viash components where the name contains “parse”:

``` bash
viash ns build --query_name  "parse"
```

### Build targetting a specific platform and an output folder

This builds a Viash namespace for just the [Docker
platform](/docs/reference_config/platform-docker) to a directory named
**built\_namespace**:

``` bash
viash ns build --platform docker --target "built_namespace"
```

### Run the build process in parallel

By default, the building of namespaces is a serial process, meaning
every components gets built one by one. With the `--parallel` option,
you can run the process in parallel, allowing you to build all of the
components at the same time, potentially saving you a lot of time:

``` bash
viash ns build --parallel
```

### Flatten the output of the build to a single directory

By running the command below, all of the generated executables will be
put next to each other in a single directory.

Note: Make sure to define a platform when using the `--flatten` option,
the single directory structure doesn’t group the executables together
per platform. Without the `--platform` option, executables will be built
for every defined platform and written away to a single file per
component, effectively overwriting the same file over and over again.

``` bash
viash ns build -p native --flatten
```

The result is a flat target structure:

``` bash
target
├── download_files
├── parse_images
└── render_mp4
```

### Using a Docker setup strategy post-build

Create a build for the Docker platform and afterwards execute a
`---setup` with a specific [docker setup
strategy](/docs/running/executables-docker).

``` bash
viash ns build -p docker --setup alwaysbuild
```

### Generate meta files

This builds a Viash namespace and puts a **viash.yaml** file next to
each executable containing the full configuration information of the
component for later reference:

``` bash
viash ns build --write_meta
```

### Override a namespace with config mods

Build a Viash namespace and use a [config
mod](/docs/advanced/config_mods) to override the [config
files](/docs/reference_config/config).

``` bash
viash ns build -p docker \
  -c '.platforms[.type == "docker"].setup_strategy := "pull"' \
  -c '.platforms[.type == "docker"].image := "bash:latest"'
```

## See also

-   [Config file](/docs/reference_config/config)
-   [Dynamic Config Modding](/docs/advanced/config_mods)
-   [Native platform](/docs/reference_config/platform-native)
-   [Docker platform](/docs/reference_config/platform-docker)
-   [Namespaces](/docs/projects/namespaces)
