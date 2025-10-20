# Nix Helpers
This repo contains nix helper functions/overlays that I reuse.



## Installation
In a nix flake, add `nix-helpers` as an input, and expose it in outputs:
```nix
{
  inputs = {
    ...
    nix-helpers.url = "github:lorisj/nix-helpers?ref=main";
  };
  outputs = { nix-helpers, ...}: {
    # ... rest of your flake ...
  };
}
```


Then all of the expressions below should be defined.



## Reference
### `nix-helpers.overlays.devshell-overlay :: Overlay` 
Overlay that adds `mkShellsWithName` to pkgs, which allows you to make an attrset of devShells, and wraps each one to set `$NIX_SHELL_NAME` to its corresponding name.
#### Example
```nix
devShells.${system} =
  pkgs.mkShellsWithName {
    shell1 = {
      packages = [ pkgs.hello ];
      shellHook = ''
        echo $NIX_SHELL_NAME
      '';
    };
    shell2 = {
      packages = [ pkgs.hello ];
      shellHook = ''
        echo $NIX_SHELL_NAME
      '';
    };
  }
  // {
    shell3 = pkgs.mkShell {
      name = "shell3NameOverride";
      packages = [ pkgs.hello ];
      shellHook = ''
        echo $NIX_SHELL_NAME
      '';
    };
  };
```
This lets you display `NIX_SHELL_NAME` in your terminal, so that you can tell which shell you are in.
### `nix-helpers.overlays.nhLib-overlay :: Overlay`
Overlay that adds `nhLib` (which contains all functions in `nix-helpers.lib` to `pkgs`.

TODO: just make overlay for `lib` maybe
### `nix-helpers.lib.find-nix-files :: Path -> [Path]` 
Returns paths of all nix files inside a given directory.

#### Example: 
Say you have dirs
```
./default.nix
./folder1/module.nix
./folder1/subfolder/module.nix
```
running `find-nix-files ./.` would yield `[ ./default.nix ./folder1/module.nix ./folder1/subfolder/module.nix ]`

This is useful for imporing all modules in a given directory. For instance see [github.com/lorisj/nixos-config/blob/main/modules/nixos/default.nix](https://github.com/lorisj/nixos-config/blob/main/modules/nixos/default.nix), where `/modules/nixos/default.nix` imports all other nix files that are in `/modules/nixos/` (i.e. all other nixos modules).

### `nix-helpers.lib.find-all-files-by-name :: Path -> Str -> [Path]`
Takes in a path, and fileName, returns paths of all files whose name matches filename.

#### Example:
Say you have dirs
```
./default.nix
./folder1/module.nix
./folder1/subfolder/module.nix
```
running `find-all-files-by-name ./. "module.nix"` would yield `[ ./folder1/module.nix ./folder1/subfolder/module.nix ]`

This is useful for importing only specific files in a given directory. For instance see [github.com/lorisj/nixos-config/blob/main/flake.nix](https://github.com/lorisj/nixos-config/blob/main/flake.nix), where `flake.nix` only imports all `/hosts/**/configuration.nix` files, each of which is a flake-parts module that represents a system configuration. 

### `nix-helpers.lib.replace-by-set :: {lib :: typeof LIB} -> AttrSet -> String -> AttrSet`
Takes in attribute-set, and string, replaces all instances of keys of attribute-set with their values.
#### Example
`replace-by-set lib ({a : "A", b: "B"}) "abcde" == "ABcde"`


This is useful when you want to modify config files. For instance see [github.com/lorisj/nixos-config/blob/main/modules/home/terminal/starship.nix](https://github.com/lorisj/nixos-config/blob/main/modules/home/terminal/starship.nix) where it replaces all strings of the form `colors.base00, colors.base01` in a TOML file with their actual colors coming from the configured nix-colors.


TODO: add lib as dep instead of input to func
