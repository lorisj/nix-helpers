let
  findFoldersWithFilename =
    startingPath: filename:
    let
      absPath = builtins.getEnv "PWD" + "/" + startingPath;
      splitString = sep: s: builtins.split sep s;

      entries = builtins.filter (e: e != "." && e != "..") (
        builtins.attrNames (builtins.readDir absPath)
      );

      results = builtins.concatLists (
        map (
          entry:
          let
            fullPath = "${absPath}/${entry}";
            relPath = "${startingPath}/${entry}";
            packageFile = "${fullPath}/${filename}";

            pathParts = splitString "/" relPath;
            parentFolderName = builtins.elemAt pathParts (builtins.length pathParts - 1);
          in
          if builtins.pathExists packageFile then
            [
              {
                relativePath = relPath;
                truePackageBasePath = fullPath;
                packageContent = if builtins.readFile packageFile == "" then builtins.null else import packageFile;
                parentFolderName = parentFolderName;
              }
            ]
          else if builtins.pathExists fullPath && builtins.readDir fullPath != { } then
            findFoldersWithFilename relPath
          else
            [ ]
        ) entries
      );
    in
    results;
in
findFoldersWithFilename
