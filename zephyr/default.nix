{ pkgs ? import <nixpkgs> {} }:

let
  revisionDataFromFile = path:
  let
    revData = builtins.fromJSON (builtins.readFile path);
  in
  {
    url = revData.url;
    ref = "master";
    rev = revData.rev;
  };
in

(import /home/srghma/projects/zephyr { nixpkgs = pkgs; }).zephyr
