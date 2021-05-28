---
title: "Regarding file formats"
description: "A viash config can be written as a standalone YAML or can be included as a header in the script itself."
lead: "A viash config can be written as a standalone YAML or can be included as a header in the script itself."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-05-28T18:32:45+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_config"
weight: 600
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
