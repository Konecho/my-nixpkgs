# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{pkgs ? import <nixpkgs> {}}: let
  source = (import ./_sources/generated.nix) {
    inherit
      (pkgs)
      fetchgit
      fetchurl
      fetchFromGitHub
      dockerTools
      ;
  };
in {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  # kernel-cjktty = pkgs.callPackage ./pkgs/kernel-cjktty {};
  arttime = pkgs.callPackage ./pkgs/arttime {};
  # baru = pkgs.callPackage ./pkgs/baru {};
  bgmi = pkgs.callPackage ./pkgs/bgmi {};
  ch347api = pkgs.callPackage ./pkgs/python/ch347api {};
  ehi = pkgs.callPackage ./pkgs/ehi {};
  form = pkgs.callPackage ./pkgs/form {};
  fortunes = pkgs.callPackage ./pkgs/fortunes {};
  # gambaterm = pkgs.callPackage ./pkgs/gambaterm {};
  gameboy = pkgs.callPackage ./pkgs/gameboy {};
  kflash = pkgs.callPackage ./pkgs/kflash {};
  labelme = pkgs.callPackage ./pkgs/labelme {};
  levee = pkgs.callPackage ./pkgs/levee {};
  pokebase = pkgs.callPackage ./pkgs/python/pokebase {};
  pokemon-terminal = pkgs.callPackage ./pkgs/pokemon-terminal {};
  pokewilds = pkgs.callPackage ./pkgs/pokewilds {};
  rime-ls = pkgs.callPackage ./pkgs/rime-ls {source = source.rime-ls;};
  rust-demangler = pkgs.callPackage ./pkgs/python/rust-demangler {};
  shox = pkgs.callPackage ./pkgs/shox {};
  neuro-sama-cursor = pkgs.callPackage ./pkgs/neuro-sama-cursor {};
  someblocks = pkgs.callPackage ./pkgs/someblocks {};
  teranoptia = pkgs.callPackage ./pkgs/teranoptia {};
  tuigreet = pkgs.callPackage ./pkgs/tuigreet {};
  xdcmd = pkgs.callPackage ./pkgs/xdcmd {source = source.xdcmd;};
  openocd-riscv = pkgs.callPackage ./pkgs/openocd-riscv {};
}
