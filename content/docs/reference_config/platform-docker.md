---
title: "Docker Platform"
description: "Run a Viash component on a Docker backend platform."
lead: "Run a Viash component on a Docker backend platform."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-07-06T10:55:49+00:00"
draft: false
images: []
menu:
  docs:
    parent: "reference_config"
weight: 540
toc: true
---



By specifying which dependencies your component needs, users will be
able to build a docker container from scratch using the setup flag, or
pull it from a docker repository.

## Example

An example of a docker platform yaml can be found below, each part of
which is explained in more depth in the following sections.

``` yaml
- type: docker
  id: custom_platform_name
  image: bash:4.0
  version: "0.1.0"
  target_image: myorganisation/example_docker
  target_registry: path-to-target
  target_tag: latest
  chown: true
  port: [80, 8080]
  registry: url-to-registry
  tag: 4.0

  workdir: /app
  setup:
    - type: docker
      build_args: 
        - GITHUB_PAT="$GITHUB_PAT"
    - type: apt
      packages:
        - imagemagick
    - type: r
      cran:
        - tidyverse
        - dynutils
    - type: docker
      run: 
        - "git clone https://github.com/data-intuitive/randpy.git"
```

## id \[string\]

As with all platforms, you can give a platform a different name. By
specifying `id: foo`, you can target this platform (only) by specifying
`-p foo` in any of the Viash commands.

Example:

``` yaml
id: foo
```

## version \[string\]

The version of the platform specifications. This will automatically be
used as a tag for the target docker image name.

Example:

``` yaml
version: "0.1.0"
```

## image \[string\]

The base container to start from. You can also add the tag here if you
wish.

Example:

``` yaml
image: "bash:4.0"
```

## target\_image \[string\]

If anything is specified in the `setup` section, running the `---setup`
will result in an image with the name of `<target_image>:<version>`. If
nothing is specified in the `setup` section, simply `image` will be
used.

Example:

``` yaml
target_image: myfoo
```

## target\_registry \[string\]

The URL where the resulting image will be pushed to.

Example:

``` yaml
target_registry: https://my-docker-registry.org
```

## target\_tag \[string\]

The tag the resulting image gets.

Example:

``` yaml
target_tag: 0.5.0
```

## chown \[boolean\]

In Linux, files created by a Docker container will be owned by `root`.
With `chown: true`, Viash will automatically change the ownership of
output files (arguments with `type: file` and `direction: output`) to
the user running the Viash command after execution of the component.
Default value: `true`.

Example:

``` yaml
chown: false
```

## port \[list of strings\]

A list of enabled ports. This doesn’t change the Dockerfile but gets
added as a command-line argument at runtime.

Example:

``` yaml
port:
  - 80
  - 8080
```

## registry \[string\]

The URL to the a [custom Docker
registry](https://docs.docker.com/registry/).

Example:

``` yaml
registry: https://my-docker-registry.org
```

## tag \[string\]

Specify a Docker image based on its tag.

Example:

``` yaml
tag: 4.0
```

## workdir \[string\]

The working directory when starting the container. This doesn’t change
the Dockerfile but gets added as a command-line argument at runtime.

Example:

``` yaml
workdir: /home/user
```

## setup \[list\]

A list of requirements for installing apt, apk, R, Python, JavaScript
packages or specifying other Docker setup instructions. The order in
which these dependencies are specified determines the order in which
they will be installed.

### R requirements \[list\]

Specify which R packages should be available in order to run the
component.

Example:

``` yaml
setup: 
  - type: r
    cran: [ dynutils ]
    bioc: [ AnnotationDbi ]
    git: [ https://some.git.repository/org/repo ]
    github: [ rcannood/SCORPIUS ]
    gitlab: [ org/package ]
    svn: [ https://path.to.svn/group/repo ]
    url: [ https://github.com/hadley/stringr/archive/HEAD.zip ]
    script: [ 'devtools::install(".")' ]
```

### Python requirements \[list\]

Specify which Python packages should be available in order to run the
component.

Example:

``` yaml
setup:
  - type: python
    pip: [ numpy ]
    git: [ https://some.git.repository/org/repo ]
    github: [ jkbr/httpie ]
    gitlab: [ foo/bar ]
    mercurial: [ http://... ]
    svn: [ http://...]
    bazaar: [ http://... ]
    url: [ http://... ]
```

### JavaScript requirements \[list\]

Specify which JavaScript packages should be available in order to run
the component.

Example:

``` yaml
setup:
  - type: javascript
    npm: [ packagename ]
    git: [ https://... ]
    github: [ owner/repository ]
    url: [ https://... ]
```

### Aptitude requirements \[list\]

Specify which apt packages should be available in order to run the
component.

Example:

``` yaml
setup:
  - type: apt
    packages: [ sl ]
```

### Alpine requirements \[list\]

Specify which apk packages should be available in order to run the
component.

Example:

``` yaml
setup:
  - type: apk
    packages: [ sl ]
```

### Docker requirements \[list\]

Specify which Docker commands should be run during setup.

Example:

``` yaml
setup:
  - type: docker
    build_args: [ GITHUB_PAT=hello_world ]
    run: [ git clone ... ]
    resources: 
      - resource.txt /path/to/resource.txt
```
