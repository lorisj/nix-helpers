{
  name,
  subModuleMap,
  defaultEnabledModules ? builtins.attrNames subModuleMap, # which modules are enabled by default when importing this module list
  description ? "enable ${name}",
}:
{
  pkgs,
  lib,
  config,
  ...
}@moduleAttrs:
{
  options.${name} = {
    enable = lib.mkEnableOption description;
  };

  config =
    let
      addNamespaceToModule = (import ./add-namespace-to-module.nix) { outerNamespace = name; };

      unknown = lib.filter (module: !lib.hasAttr module subModuleMap) defaultEnabledModules;

      # log unknown modules if given something not in subModuleMap
      _trace =
        if unknown != [ ] then
          builtins.trace ("Unknown modules ignored: " + builtins.concatStringsSep ", " unknown) null
        else
          null;

      allModules = lib.unique (lib.concatMap (name: subModuleMap.${name}) defaultEnabledModules);
    in
    lib.mkIf config.${name}.enable {
      imports = builtins.map (module: addNamespaceToModule module) allModules;
    };
}
