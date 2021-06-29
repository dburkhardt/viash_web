---
title: "Creating a Nextflow Pipeline"
description: "Developing a pipeline in Nextflow with Viash."
lead: "Developing a Pipeline in Nextflow with Viash."
date: 2021-05-28T14:00:00+00:00
lastmod: "2021-06-22T08:41:57+00:00"
draft: false
images: []
menu:
  docs:
    parent: "creating_pipelines"
weight: 402
toc: true
---



## Introduction

### Pipelines / Workflows

It’s possible to *convert* a Viash component into a NextFlow module.
Viash uses NextFlow’s DSL2 for this, effectively creating *modules* that
can be imported in a `main.nf` pipeline definition that deals with the
*logic* of the pipeline rather than the low-level machinery.

When it comes to this low-level machinery and the way Viash creates a
module, we refer to [the step-by-step introduction about
DiFlow](https://www.data-intuitive.com/diflow).

### Parallelization

NextFlow, as any other pipeline platform is able to run tasks in
parallel if the pipeline logic allows for that. In order to keep
different parallel branch unique, we add a unique identifier `id`. This
identifier can be a sample identifier, or a plate id (sequencing),
versions of reference files to consider, etc.

In a pipeline, one is often interested in running some computation on
different datasets, inputs or parts of an input. This means that
obviously we need to keep track of where the input chunks are located.
But more importantly, we can not just simply name an output file because
multiple parallel processes might just overwrite each other’s output
files.

### Output Filenames

Therefore, it’s important to keep output files distinct across different
steps of the pipeline but also between different parallel runs. In order
to assure this, a module will define its own output file name. It is
constructed from 3 ingredients:

1.  The unique `id` of the data going into the process
2.  The name of the current component/task
3.  An extension

The extension is derived from the component configuration if a
`default: ...` attribute is present for the corresponding output
argument. If no such default value is provided, the *name* of the option
is used.

As an example, the following argument for a component `comp`

``` yaml
name: --log
type: file
direction: Output
```

will result in `<id>.comp.log`, while the following

``` yaml
name: --log
type: file
direction: Output
default: log.txt
```

will become in `<id>.comp.txt`.

The config can define a directory as output as well, it will be named
accordingly.

**Remark**: If the output is a directory, `type: file` should still be
used, but the corresponding script/code should take care of writing the
content to that directory.

## Tips

### How to specify multiple inputs?

If a component deals with just one input file, that input file should be
provided as the second element in the
[DiFlow](https://www.data-intuitive.com/diflow/) triplet. In other
words, if this is the first component in a (sub)workflow, two options
are available:

``` groovy
Channel.fromPath(<...>).map{ file -> [ <id>, file, params ] }
```

or

``` groovy
Channel.from(<...>).map{ filename -> [ <id>, file(filename), params ] }
```

It is crucial that this second element in the triplet is of type `Path`.

If multiple inputs are to be provided corresponding to the same option
for the underlying process or tool a `List` of `Path` objects can be
provided.

For example, say we ran multiple parallel workflows for a single sample
and want to join the result of that. The way to express this in NextFlow
would be something like:

``` groovy
concatenate_ = singleSample_ \
    | toList \
    | map{ it -> [ it.collect{ b -> b[0]}, it.collect{ a -> a[1] }, params ]} \
    | concatenate
```

In other words, we pass a `List` of Path objects to the concatenate
module.

In some cases, multiple input arguments deal with different input files,
for instance `fastq` files and a reference file for mapping and
counting. One can pass this to the concatenation module by means of a
`Map`. This approach, for instance can be used to merge meta information
(from a file) to an `h5ad` file:

``` groovy
    singleSample_ = input_ \
        ...
        | combine(meta_) \
        | map{ id, output, params, meta ->
            [ id, [ "input" : output, "meta" : meta ], params ]
        } \
        | annotate
```

Where the `meta_` `Channel` points to the meta file to be used.

In other words, we either provide a `List` of Path values or in the case
multiple options take different files we use a `HashMap`.

Remark: Be sure to mark the arguments at hand as being of `type: file`
and `direction: input`.

## Multiple outputs

Internally, DiFlow uses a similar approach to keeping track of outputs
as discussed for inputs. What comes out of a module, however, is
slightly different. Since a `workflow` can not emit a multi-channel
object, we are forced to put all outputs on the same `Channel` and so we
use a `Map` again to distinguish both. This is only done for multiple
outputs, though.

By means of an example: Say a module outputs one file, then the triplet
that is returned from the module looks like this:

    [ <id>, file, params ]

If our tools has two output files, say for instance `outputfile.txt` and
`logfile.txt` (as indicated by the command line for the tool that looks
for instance like this:
`.... --output outputfile.txt --log logfile.txt`), we still get one
`Channel` back, but on that `Channel` there are now two *events* and
those look like this:

    [ <id>, [ output: outputfile.txt ], params ]
    [ <id>, [ log: logfile.txt ], params ]

It’s up to the receiving end of the module to split this downstream. The
implicit workflow defined in all the generated module contains some
example code to that, for instance:

``` groovy
result \
  | filterOutput \
  | view{ "Output for output: " + it[1] }

result \
  | filterLog \
  | view{ "Output for log: " + it[1] }
```

Where the `filterLog` process for instance is defined like so:

    // A process that filters out output from the output Map
    process filterOutput {

      input:
        tuple val(id), val(input), val(_params)
      output:
        tuple val(id), val(output), val(_params)
      when:
        input.keySet().contains("output")
      exec:
        output = input["output"]

    }

Alternatively, one could also use methods on the `Channel` itself:

    result \
      | filter{ it[1].keySet().contains("output") }
      | map{ [ it[0], it[1]["output"], it[2] ] }
      | view{ "Output for log: " + it[1] }

One more option is to use the `branch` or `multiMap` `Channel` forking
operators in NextFlow.

## Access arguments from the `nextflow` CLI (`v0.4.1+`)

We provide a way to access the argument values for all the arguments for
every component from the NextFlow CLI. All components store their
respective arguments under a component-specific key that corresponds to
the component name.

Furthermore, the value that will effectively be passed to the process
depends on the following attributes for an argument:

``` yaml
required: true/false
default: ...
```

If an argument is `required: true`, it can have

-   a `default: ...` value: It will use this default value on the CLI
    unless you override it on the CLI
-   no default value: In this case, one has to provide a value when
    starting a NextFlow pipeline. Otherwise Viash will give a warning
    and NXF will throw an error.

If an argument is `required: false`, it can have

-   `a default: ...` value: It will use this default value unless you
    override it from the CLI
-   no default value: In this case, this argument will not be present on
    the CLI, but it can still be overridden from the CLI

Please refer to [this
issue](https://github.com/viash-io/viash/issues/46) for more
information.

Given the above, its possible to override any of these using the
following scheme:

    --<component_name>__<argument_name> <value>

For instance:

    nextflow run main.nf --filter__threshold 0.2
