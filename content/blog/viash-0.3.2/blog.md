---
title: "Viash 0.3.2"
description: "Changelog of Viash 0.3.2"
date: 2021-02-04T09:00:00+02:00
lastmod: 2021-02-04T09:00:00+02:00
draft: false
images: []
contributors: ["Viash Team"]
---

### Full changelog:

#### BREAKING CHANGES

* `viash build`: Do not automatically generate a viash.yaml when creating an executable. 
  Instead, you need to add the `-w|--write_meta` flag in order to let viash know that it
  should generate a viash.yaml in the resources dir.

#### MAJOR CHANGES

* `NXF`: Add beta functionality for running viash tests in Nextflow.

#### MINOR CHANGES

* Resources: Rework the way resources paths are converted to absolute URIs, should not have any impact on UX.

#### BUG FIXES

* `NXF`: Add temporary workaround for determining the used image name when running a component.
* Docker Platform: Set default setup strategy to "alwayscachedbuild" as this used to be the default viash behaviour.
* `NXF`: Fix issue where resource dir would not get mounted depending on which inputs are provided.
* `NXF`: Accept multiple inputs when component is running as standalone.