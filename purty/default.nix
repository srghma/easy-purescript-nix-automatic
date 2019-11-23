{ pkgs ? import <nixpkgs> {} }:

let
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  patchelf = libPath: if pkgs.stdenv.isDarwin
  then ""
  else ''
    chmod u+w $PURTY
    patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURTY
    chmod u-w $PURTY
  '';

  revisions = builtins.fromJSON (builtins.readFile ./revision.json);
in
pkgs.stdenv.mkDerivation rec {
  name = "purty";

  version = revisions.version;

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl { inherit (revisions.mac) url sha256; }
    else pkgs.fetchurl { inherit (revisions.linux) url sha256; };

  buildInputs = [ pkgs.zlib pkgs.gmp pkgs.ncurses5 ];

  libPath = pkgs.lib.makeLibraryPath buildInputs;

  dontStrip = true;

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    PURTY="$out/bin/purty"
    install -D -m555 -T purty $PURTY
    ${patchelf libPath}
    mkdir -p $out/etc/bash_completion.d/
    $PURTY --bash-completion-script $PURTY > $out/etc/bash_completion.d/purty-completion.bash
  '';
}
