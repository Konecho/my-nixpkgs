# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage
{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  xdcmd = pkgs.callPackage ./pkgs/xdcmd {};
  pokemon-terminal = pkgs.callPackage ./pkgs/pokemon-terminal {};
  ehentai-archive-info = pkgs.callPackage ./pkgs/ehentai-archive-info {};
  fortunes = pkgs.callPackage ./pkgs/fortunes {};
  shox = pkgs.callPackage ./pkgs/shox {};
  labelme = pkgs.callPackage ./pkgs/labelme {};
  baru = pkgs.callPackage ./pkgs/baru {};
  gambaterm = pkgs.callPackage ./pkgs/gambaterm {};
  gameboy = pkgs.callPackage ./pkgs/gameboy {};
  pokewilds = pkgs.callPackage ./pkgs/pokewilds {};
  arttime = pkgs.callPackage ./pkgs/arttime {};
  someblocks = pkgs.callPackage ./pkgs/someblocks {};
  pokebase = pkgs.callPackage ./pkgs/pokebase {};
  bgmi = pkgs.callPackage ./pkgs/bgmi {};
  levee = pkgs.callPackage ./pkgs/levee {};
  ch347api = pkgs.callPackage ./pkgs/ch347api {};
  rime-ls = pkgs.callPackage ./pkgs/rime-ls {};
  teranoptia = pkgs.callPackage ./pkgs/teranoptia {};
  # kernel-cjktty = pkgs.callPackage ./pkgs/kernel-cjktty {};
}
