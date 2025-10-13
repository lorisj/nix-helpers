final: prev: rec {
  mkShell =
    attrs:
    prev.mkShell (
      attrs
      // {
        env = (attrs.env or { }) // {
          NIX_SHELL_NAME = attrs.name;
        };
      }
    );
  mkShellsWithName =
    shellsAttrs: prev.lib.mapAttrs (name: attrs: mkShell (attrs // { name = name; })) shellsAttrs;
}
