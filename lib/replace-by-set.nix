# takes in attribute-set, and string, replaces all instances of keys of attribute-set with their values.
# example:
# this ({a : "A", b: "B"}) "abcde" == "ABcde"
{ lib }:
attribute-set: str:
let
  reducer = (acc: cur-key: builtins.replaceStrings [ cur-key ] [ "${attribute-set.${cur-key}}" ] acc);
in
lib.foldl' reducer str (builtins.attrNames attribute-set)
