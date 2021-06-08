---
title: "Executables with a Docker backend"
description: ""
lead: ""
date: 2021-06-07T14:00:00+00:00
lastmod: "2021-06-08T08:06:15+00:00"
draft: false
images: []
menu:
  docs:
    parent: "running"
weight: 620
toc: true
---



## TODO

## Docker setup strategies

-   alwaysbuild / build: build the image from the dockerfile (DEFAULT)
-   alwayscachedbuild / cachedbuild: build the image from the
    dockerfile, with caching
-   alwayspull / pull: pull the image from a registry
-   alwayspullelsebuild / pullelsebuild: try to pull the image from a
    registry, else build it
-   alwayspullelsecachedbuild / pullelsecachedbuild: try to pull the
    image from a registry, else build it with caching
-   ifneedbebuild: if the image does not exist locally, build the image
-   ifneedbecachedbuild: if the image does not exist locally, build the
    image with caching
-   ifneedbepull: if the image does not exist locally, pull the image
-   ifneedbepullelsebuild: if the image does not exist locally, pull the
    image else build it
-   ifneedbepullelsecachedbuild: if the image does not exist locally,
    pull the image else build it with caching
-   donothing / meh: do not build or pull anything
-   build / b
-   cachedbuild / cb
-   pull / p
-   push
-   pushifnotpresent
