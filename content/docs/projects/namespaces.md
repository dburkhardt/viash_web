---
title: "Namespaces"
description: ""
lead: ""
date: 2021-06-07T14:00:00+00:00
lastmod: "2021-06-25T12:03:03+00:00"
draft: false
images: []
menu:
  docs:
    parent: "projects"
weight: 100
toc: true
---



Once you start to develop a number of Viash components, you may want to
group them together for improved maintenance and a separation of
concerns. In addition, multiple developers could work on different sets
of components in parallel and later bring them together in a larger
project.

We call a group of components a **namespace**.

### Building a namespace

You can assign a component to a namespace by defining its namespace
attribute in the [viash config file](/docs/reference_config/config):

``` yaml
functionality:
  name: some_component
  namespace: my_namespace
```

Alternatively, the namespace can be automatically inferred by
structuring the components hierarchically. In the example below, there
are two namespaces: **file\_processing** and **network\_tools**. Each of
these namespaces has one or more components assigned to them:

``` bash
src
├── file_processing
│   ├── parse_images
│   │   ├── config.vsh.yaml
│   │   └── script.sh
│   └── render_mp4
│       ├── config.vsh.yaml
│       └── script.sh
└── network_tools
    └── download_files
        ├── config.vsh.yaml
        ├── output
        │   └── download_files
        └── script.sh
```

To build a namespace to a set of executables, use the [viash ns build
command](/docs/reference_commands/ns-build).
