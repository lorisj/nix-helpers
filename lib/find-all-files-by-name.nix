let
  recursiveFindFiles =
    startingDir: fileName:
    with builtins;
    (
      let
        files = (readDir startingDir);
        nixFiles = filter (e: files.${e} == "regular" && e == fileName) (attrNames files);
        directories = filter (e: files.${e} == "directory" && e != ./. && e != ./..) (attrNames files);
      in
      nixFiles
      ++ concatMap (
        e: map (f: "${e}/${f}") (recursiveFindNixFiles (startingDir + "/${e}") fileName)
      ) directories
    );
in
dir: fileName: map (e: dir + "/${e}") (recursiveFindNixFiles dir fileName)
