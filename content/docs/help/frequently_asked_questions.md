---
title: "Frequently Asked Questions"
description: "Frequently Asked Questions"
lead: ""
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-15T07:42:39+00:00"
draft: false
images: []
menu:
  docs:
    parent: "help"
weight: 610
toc: true
---



### Running Components

#### One or more of my output files are owned by root after running a component. Why is this?

In Linux, files created by Docker are owned by root by default.  
You can [set up the chown
attribute](/docs/reference_config/platform-docker/#chown-boolean) in
your config file to automatically transfer the ownership of files to the
user running the component. Any file output where an argument of the
type file with an output direction was used will also have their
ownership transferred.
