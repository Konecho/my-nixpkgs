{ callPackage, ... }: {
  fonts = callPackage ./fonts.nix { };
  thesis = callPackage ./thesis.nix { };
}
