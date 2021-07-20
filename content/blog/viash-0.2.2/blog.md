---
title: "Viash 0.2.2"
description: "Changelog of Viash 0.2.2"
date: 2020-09-22T09:00:00+02:00
lastmod: 2020-09-22T09:00:00+02:00
draft: false
images: []
contributors: ["Viash Team"]
---

### Allow generating placeholder without VIASH START/VIASH END blocks.

A script does not need to contain a `VIASH START`/`VIASH END` block in order to function.

Previously, each script had to contain a codeblock as follows:

```r
## VIASH START
par <- list(
  input = "foo",
  output = "bar
)
## VIASH END
```

### Full changelog:

#### MINOR CHANGES

-   Allow generating placeholder without VIASH START/VIASH END blocks.

#### BUG FIXES

-   `viash ns build`: Some platforms would sometimes not be detected.
-   `viash run`: Avoid error when no arguments need to be chowned.
