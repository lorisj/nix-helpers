# Wraps module's options with a given namespace.
{ outerNamespace }:
module:
{ config, ... }@moduleAttrs:
let
  mapKeys = import ./map-keys.nix;
  # move anything of the form config.${outerNamespace}.x to config.x:
  configForInner =
    if (config ? ${outerNamespace}) then
      (builtins.removeAttrs config [ outerNamespace ]) // (config.${outerNamespace})
    else
      config;

  # module is expecting local (non-namespace) options when being evaluated, so overwrite all namespace ones and feed into module:
  moduleEvalWithNewConfig = module (moduleAttrs // { config = configForInner; });
  newOptions =
    if (moduleEvalWithNewConfig ? "options") then
      (mapKeys (name: "${outerNamespace}.${name}") moduleEvalWithNewConfig.options)
    else
      { };
in
moduleEvalWithNewConfig // { options = newOptions; }
