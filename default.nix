{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import ./easy-dhall {
    inherit pkgs;
  };

  inputs = rec {
    purs = import ./purs {
      inherit pkgs;
    };

    purs-simple = purs;

    purescript = purs;

    purty = import ./purty {
      inherit pkgs;
    };

    # error on build, done want to deal with this
    # psc-package-simple = import ./psc-package-simple {
    #   inherit pkgs;
    # };

    purp = import ./purp {
      inherit pkgs;
    };

    inherit (easy-dhall) dhall-simple dhall-json-simple;

    spago = import ./spago {
      inherit pkgs;
    };

    psc-package2nix = import ./psc-package2nix {
      inherit pkgs;
    };

    # zephyr = import ./zephyr {
    #   inherit pkgs;
    # };

    # pscid = import ./pscid {
    #   inherit pkgs purs;
    # };

    spago2nix = import ./spago2nix {
      inherit pkgs;
    };
  };

  buildInputs = builtins.attrValues inputs;
in inputs // {
  inputs = inputs;

  buildInputs = buildInputs;

  shell = pkgs.runCommand "easy-purescript-nix-shell" {
    buildInputs = buildInputs;
  } "";
}
