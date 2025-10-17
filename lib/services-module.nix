# Example usage:
#servicesModule {
#  serviceMap = {
#    service1 = [ ./service1.nix ];
#    service2 = [ ./service2base.nix ./service2extra.nix ];
#  };
#  optionName = "myService";              # will create option: myService.services
#  description = "Which myService backends to enable";
#}
# then use with:
# # in nixos config:
# myService.services = [ "service1" ] # omits service2, because by default, all services are enabled

{
  optionName,
  description,
  defaultServices = builtins.attrNames serviceMap; # default => all services enabled
  serviceMap,
}:
{
  pkgs,
  lib,
  config,
  ...
}@moduleAttrs:
{

  options.${optionName}.services = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = defaultServices; 
    inherit description;
  };

  config =
    let
      selected = config.${optionName}.services;

      unknown = lib.filter (service: !lib.hasAttr service serviceMap) selected;

      # trace unknown services if given:
      _trace =
        if unknown != [ ] then
          builtins.trace ("Unknown services ignored: " + builtins.concatStringsSep ", " unknown) null
        else
          null;

      selectedModules = lib.concatMap (
        name: if lib.hasAttr name serviceMap then serviceMap.${name} else [ ]
      ) selected;

      finalModules = lib.unique selectedModules;
    in
    {
      imports = finalModules;
    };
}
