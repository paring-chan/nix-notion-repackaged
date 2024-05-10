# Notion Repackaged for Nix

> [!WARNING]  
> This project may not be well maintained;

nix version of [notion-repackaged](https://github.com/dusansimic/notion-repackaged)

## Install

In your flake.nix:

```nix
{
    inputs = {
        # ...
        notion-repackaged = {
            url = "github:pikokr/nix-notion-repackaged";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
}
```

Somewhere you want to use this package:

```
{ inputs, ... }:
{
    # ...
    packages = [
        inputs.notion-repackaged.packages.x86_64-linux.notion-repackaged
    ];
}
```
