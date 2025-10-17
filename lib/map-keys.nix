f: attrs:
    let
      names = builtins.attrNames attrs;
      pairs = map (n: { name = f n; value = attrs.${n}; }) names;
    in
      builtins.listToAttrs pairs;
