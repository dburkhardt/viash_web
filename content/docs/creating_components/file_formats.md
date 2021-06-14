---
title: "Regarding file formats"
description: ""
lead: ""
date: 2021-06-07T14:00:00+00:00
lastmod: "2021-06-14T07:22:04+00:00"
draft: false
images: []
menu:
  docs:
    parent: "creating_components"
weight: 307
toc: true
---



The following two file formats are equivalent.

## Config format

Metadata `config.vsh.yaml`:

``` yaml
functionality:
  name: hello
  arguments:
    - name: "name"
      type: string
      default: Bob
  resources:
    - type: bash_script
      path: script.sh
platforms:
  - type: native
```

Script `script.sh`:

``` bash
#!/bin/bash
echo Hello $par_name
```

## Script format

Script `script.vsh.sh`:

``` bash
#!/bin/bash

#' functionality:
#'   name: hello
#'   arguments:
#'     - name: "name"
#'       type: string
#'       default: Bob
#' platforms:
#' - type: native

echo Hello $par_name
```
