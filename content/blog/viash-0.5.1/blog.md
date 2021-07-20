---
title: "Viash 0.5.1"
description: "We're proud to announce that we have released Viash 0.5.0."
date: 2021-07-19T09:08:00+02:00
lastmod: 2021-07-19T09:08:00+02:00
draft: false
images: []
contributors: ["Viash Team"]
---

Viash 0.5.1 adds support for C# scripts and fixes a few bugs.

### Installing Viash

See the [Installation page](/docs/getting_started/installation/) for detailed instructions on how to install Viash 0.5.1 on your linux, macOS or Windows machine.

### C# script support

We've added C# scripts (.csx) as a [supported language](/docs/creating_components/supported_languages/) using **dotnet-script**.  
To run C# scripts natively, you'll need to install [.NET Core](https://dotnet.microsoft.com/download) and execute the following command in a terminal:

```bash
dotnet tool install -g dotnet-script
```

You can now run C# scripts like this:

```bash
dotnet script hello_viash.csx
```

To use C# scripts as components, use the new `csharp_script` type in the functionality section of your [config file](/docs/reference_config/config/): 

```yaml
  resources:
  - type: csharp_script
    path: script.csx
```

Here's an example of a simple C# script with Viash in mind:

```csharp
// VIASH START
var par = new {
  input = "Hello World",
  name = "Mike"
};
// VIASH END

System.Console.WriteLine(input + ", " + name + "!");
```

The language-specific guide for creating C# script components will be added in the near future.

### Bug fixes

First off, these special characters  can now be used in the description, usage, default and example fields of components:

- "
- \`
- \\
- \n
- $ 

Nextflow output files with the same extension won't overwrite each other any more, like it was the case for arguments like this:

```yaml
functionality:
  name: bar
  arguments:
    - name: "--input"
      type: file
      example: input.txt
    - name: "--output1"
      type: file
      direction: output
      required: true
      example: output.txt
    - name: "--output2"
      type: file
      direction: output
      required: true
      example: optional.txt
```

In this case, the two output files would have been identical in the past.
___

### Full changelog:

#### NEW FEATURES

* `CSharpScript`: Added support for C# scripts (`type: "csharp_script"`) to viash.

#### BUG FIXES

* `BashWrapper`: Refactor escaping descriptions, usages, defaults, and examples (#34).

* `NextFlowPlatform`: Refactor escaping descriptions, usages, defaults and examples (#75).

* `NextFlowPlatform`: Add argument to output path to avoid naming conflicts for components with multiple output files (#76).

* `NextFlowPlatform`, `renderCLI()`: Only add flag to rendered command when boolean_true is actually true (#78).

* `DockerPlatform`: Only chown when output file exists.

#### TESTING

* `viash build`: Capture stdout messages when errors are expected, so that they don't clutter the expected output.

* `viash build`: Check `--help` description output on the whole text instead of per letter or word basis.

* `TestingAllComponentsSuite`: Only testing bash natively, because other dependencies might not be available.