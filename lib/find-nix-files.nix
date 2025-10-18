let
  recursiveFindNixFiles =
    startingDir:
    with builtins;
    (
      let
        files = (readDir startingDir);
        nixFiles = filter (e: files.${e} == "regular" && match ".*\\.nix$" e != null) (attrNames files);
        directories = filter (e: files.${e} == "directory" && e != ./. && e != ./..) (attrNames files);
      in
      nixFiles
      ++ concatMap (e: map (f: "${e}/${f}") (recursiveFindNixFiles (startingDir + "/${e}"))) directories
    );
in
dir: map (e: dir + "/${e}") (recursiveFindNixFiles dir)
