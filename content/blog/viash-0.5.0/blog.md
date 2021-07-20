---
title: "Viash 0.5.0"
description: "We're proud to announce that we have released Viash 0.5.0."
date: 2021-07-12T09:08:28+02:00
lastmod: 2021-07-12T09:08:28+02:00
draft: false
images: []
contributors: ["Viash Team"]
---

We're proud to announce that we have released Viash 0.5.0.  
This new version has some improvements to the way components with a Docker backend can be ran and the Nextflow platform has some argument changes.

### Installing Viash

See the [Installation page](/docs/getting_started/installation/) for detailed instructions on how to install Viash 0.5.0 on your linux, macOS or Windows machine.

### Improvements to Docker backend

In the past, you needed to perform `--setup` on your [Docker-based components](/docs/reference_config/platform-docker/) and executables in order for the image to be built before you could run the component or executable. Now you can simply run your component or executable and Viash will do the image building automatically by default if it detects an image isn't present yet. This behaviour can be changed by using a [Docker setup strategy](/docs/running/executables-docker/#docker-setup-strategies). For example:

```bash
viash build config.vsh.yaml -p docker --setup alwayscachedbuild
```

### Nextflow gets some argument changes

Arguments for the [Nextflow platform](/docs/reference_config/platform-nextflow/) now have optional `required` and `default` values, just like their native and Docker counterparts. For example:

```yaml
  arguments:
    - name: --name
      type: string
      description: Input name
      required: true
    - name: --repeat
      type: integer
      description: Times to repeat the name
      default: 100
```

Take a look at the [Functionality page](/docs/reference_config/functionality/) for more information on arguments and their properties.  
As long as you use long-option arguments (e.g. `--my-option`) in the [config file](/docs/reference_config/config/) for required arguments, the way of specifying argument values for the Nextflow platform is identical to the Docker platform. You still access non-required arguments via this syntax: `--<component_name>__<argument_name> <value>`. For example:

```bash
my_component -- --my_component__input Hello!
```

### Verbosity levels for viash run

Executables now have 8 levels of verbosity:

0. emergency
1. alert
2. critical
3. error
4. warning
5. notice
6. info
7. debug

The default verbosity level is **notice**.
You can pass the `-v` or `--verbose` option to bump up the verbosity by one level. By passing `-vv` the verbosity goes up by two levels. You can manually set the verbosity by using the `--verbosity <int_level>` option. For example, if you wanted to only show errors or worse:

```bash
viash run config.vsh.yaml -- --verbosity 3
```
___

### Full changelog:

#### BREAKING CHANGES

* `DockerPlatform`: A Docker setup will be performed by default. Default strategy has been changed to `ifneedbepullelsecachedbuild` (#57).
  `---setup` strategy has been removed and `---docker_setup_strategy` has been renamed to `---setup`.
  This change allows running a component for the first time. During first time setup, the Docker container will be pulled or built automatically. 

* `NativePlatform`: Deprecated the native setup field.

#### MAJOR CHANGES

* `NXF`: This version changes the handling logic for arguments. An argument can be either `required` or not and can have a `default: ...` value or not. Checks are implemented to verify that required arguments are effectively provided _during_ pipeline running.

* `NXF`: If one sticks to long-option argments in the viash config, for all arguments that are _required_, the way of specifying the arguments on the CLI is identical for the Docker and NextFlow platforms. Non-required arguments can still be accessed from CLI using `--<component_name>__<argument_name> ...`.

* `NXF`: Running a module as a standalone pipeline has become easier.

* `viash run`: Implement verbosity levels (#58). viash executables now have 7 levels of verbosity: emergency, alert, critical, error, warning, notice, info, debug.
  The default verbosity level is 'notice'. Passing `-v` or `--verbose` bumps up the verbosity level by one, `-vv` by two. The verbosity level can be set manually by passing `--verbosity x`.

#### MINOR CHANGES

* `Docker Platform`: Added `privileged` argument, allowing to run docker with the `--privileged` flag.

* `Docker Requirements`: Allow specifying environment variables in the Dockerfile.

* Config modding: Added a `+0=` operator to prepend items to a list.

* `viash run`: Added a `--version` flag to viash executables for viewing the version of the component.

* `Functionality`: Added checks on the functionality and argument names.

* `viash run`: Added examples to functionality and arguments. Reworked `--help` formatting to include more information and be more consistent (#56).

#### BUG FIXES

* `Docker R Requirements`: Install `remotes` when using `{ type: r, packages: [ foo ] }`.

* `config`: Throw error when user made a typo in the viash config (#62). 

#### TESTING

* `NXF`: Add an end-to-end test for running a nextflow pipeline using viash components.

* `Docker`: Reorganized viash docker build testbench into a main testbench with smaller auxiliary testbenches to keep them more manageable and clear what happens where.

* `viash ns`: Added a basic testbench for namespace tests.

