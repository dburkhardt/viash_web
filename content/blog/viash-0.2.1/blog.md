---
title: "Viash 0.2.1"
description: "Changelog of Viash 0.2.1"
date: 2020-09-11T09:00:00+02:00
lastmod: 2020-09-11T09:00:00+02:00
draft: false
images: []
contributors: ["Viash Team"]
---

### Docker chown by default
Running a script using a Docker platform will now chown output files by default, as well as any temporary files. You can turn off this feature by specifying `chown: false` in the yaml of a Docker platform.

### [NXF] Data references
Data references in Map form can now have values being lists. In other words, we can have multiple options which have one or more values.

### viash ns build -P docker --parallel --setup
`viash ns build` has been greatly improved! You can automatically build the docker container by adding `--setup` to the command, as well as make the whole thing run in parallel using the `--parallel` or `-l` flag.

To build a docker container, you can run either of the following:
```
viash run -f path/to/config.yaml -P docker -- ---setup
viash build -f path/to/functionality.yaml -P docker -o target/docker/path/to --setup
```

Note that the first will only build the docker container, whereas the second will build the executable and then build the docker container.

To build a lot of them all at once, run:
```
viash ns build -P docker --parallel --setup
```

## Custom order of platform requirements
You can now choose the order in which platform requirements are installed!

BEFORE:
```yaml
type: docker
image: rocker/tidyverse
target_image: "viash_test/r"
r:
  cran:
  - optparse
  github:
  - dynverse/dynutils@devel
  bioc:
  - limma
apt:
  packages:
  - libhdf5-serial-dev
docker:
  build_arg:
  - GITHUB_PAT="$GITHUB_PAT"
  run:
  - git clone --depth 1 https://github.com/data-intuitive/viash_docs.git && rm -r viash_docs/.git
↑ in which order will these three components be run? Who knows!
```

NOW:
```yaml
type: docker
image: rocker/tidyverse
target_image: "viash_test/r"
setup:
- type: docker
  build_arg:
  - GITHUB_PAT="$GITHUB_PAT"
- type: apt
  packages:
  - libhdf5-serial-dev
- type: r
  cran:
  - optparse
  - dynutils
  github:
  - rcannood/princurve@devel
  bioc:
  - limma
- type: docker
  run:
  - git clone --depth 1 https://github.com/data-intuitive/viash_docs.git && rm -r viash_docs/.git
```

This will ensure that the setup instructions are installed in the given order.

### Full changelog:

#### NEW FEATURES

-   `NXF`: Data references in Map form can now have values being lists. In other words, we can have multiple options which have one or more values.
-   `viash ns build`: Added --parallel and --setup flag.
-   viash build`: Added --setup flag.
-   Allow changing the order of setup commands using the `setup:` variable.
-   Do not escape `${VIASH_...}` elements in default values and descriptions!

#### MINOR CHANGES

-   Remove `---chown` flag, move to `platform.docker.chown`; is set to true by default.
-   Perform chown during both run and test using a Docker platform.

#### BUG FIXES

-   Issue trying to parse positional arguments even when none is provided.
