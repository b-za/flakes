# Introduction

Create a flake that has a ok Neovim setup

Eventually create a flake for every app that I use that has configs

Then just import those flakes into the darwin or home manager configs

Add all the flakes into one github repo unless there is some reason to have separate repos

keet the flakes repo at ˜/.flakes on my systems.

everything is a flake even the main system config

# Core Nix components

## Nix

A build tool and package manager used to create declarative, reproducible software systems.

https://zero-to-nix.com/concepts/nix

## Nix language

A language for instructing Nix how to build packages, environments, and systems.

https://zero-to-nix.com/concepts/nix-language

## NixOS

A Linux distribution built on Nix with its core principles in mind.

https://zero-to-nix.com/concepts/nixos

## Nixpkgs

A vast collection of Nix packages, libraries, and helper functions.

https://zero-to-nix.com/concepts/nixpkgs


# Nix learning sources

## Zero to Nix

https://zero-to-nix.com/

# Installing Nix

Use the determinate systems installer

## Install command

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Update command

```bash
sudo -i nix upgrade-nix
```

## Uninstall command

```bash
/nix/nix-installer uninstall
```

## Sources

https://determinate.systems/posts/determinate-nix-installer/

https://github.com/DeterminateSystems/nix-installer

---


# Flakes

Flakes lock the versions of packages in at the version they where when the command was ran. 
So even if using the unstable channel the package versions will stay locked at the versions in the flake.lock file

## Creating a flake

in the folder you want the flake to be in

```bash
nix flake init 
```

## Example flake

```nix
{
  description = "my epic vims collection";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # devShells means if the flake is a shells you can run it with
    # nix develop
    # instead of
    # nix develop .#bob
    devShells.${system}.default =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.neovim
            pkgs.vim
          ];

          shellHook = ''
            echo "hello mom"
          '';
        };
    bob =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.neovim
            pkgs.vim
          ];

          shellHook = ''
            echo "hello mom"
          '';
        };
  };
}
```

## Testing a flake

In the folder the flake is in

```bash
nix develop
nix develop .#bob
```

Maybe the nix develop has something to do with devShells.${system}.default?

## Building a flake

```bash
nix flake build?? 
```

## See available nix run targets

```bash
nix flake show github:DeterminateSystems/riff
```

## Running a flake

In the folder the flake is in

???? Note sure what this does Running a flake
```
nix flake run??
```

## Updating a flake

Updated the versions of the inputs in the flake

In the folder the flake is in

```bash
nix flake update
```



## Sources

[Nix flakes explained](https://www.youtube.com/watch?v=S3VBi6kHw5c)

---

# Important Tools

## github:numtide/flake-utils

Pure Nix flake utility functions.

The goal of this project is to build a collection of pure Nix functions that don't depend on nixpkgs, and that are useful in the context of writing other Nix flakes.

https://github.com/numtide/flake-utils

Example
$ examples/each-system/flake.nix as nix

```nix
{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = rec {
          hello = pkgs.hello;
          default = hello;
        };
        apps = rec {
          hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
          default = hello;
        };
      }
    );
}
```


# Usefull Links

https://determinate.systems/posts/nix-run/

- Very good post

https://nixos.org/manual/nixpkgs/unstable/

https://gist.github.com/edolstra/40da6e3a4d4ee8fd019395365e0772e7

https://nixos.wiki/wiki/Flakes

https://github.com/nix-community/NUR

# Example Flakes

## pwzsh

https://github.com/zmre/pwzsh/tree/main

- zsh with good nvim

```bash
nix --extra-experimental-features "nix-command flakes" run github:zmre/pwzsh
```

## b-za:zsh

https://github.com/b-za/zsh/tree/main

- zsh with good nvim

```bash
nix --extra-experimental-features "nix-command flakes" run github:bbham/bbham-zsh --no-write-lock-file
```

## DeterminateSystems:riff

https://github.com/DeterminateSystems/riff/blob/main/flake.nix

https://determinate.systems/posts/nix-run/



# Example Configs

https://github.com/caarlos0/nur

https://github.com/malob/nixpkgs

https://github.com/kclejeune/system

https://github.com/zmre/nix-config

https://github.com/zmre/mac-nix-simple-example

https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

https://github.com/Misterio77/nix-starter-configs
