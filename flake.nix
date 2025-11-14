{
  description = "My personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      # "i686-linux"
      # "armv6l-linux"
      # "armv7l-linux"
      # "x86_64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (self: super: rec {
            })
          ];
        };
      });
    packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
    overlays.defalut = import ./overlay.nix;
    nixConfig = {
      extra-substituters = [
        "https://konecho.cachix.org"
      ];
      extra-trusted-public-keys = [
        "konecho.cachix.org-1:WdZC2zag05oLTaBVQ9X8dI3dw5Lso7DqGRI92hTg+Mc="
      ];
    };
  };
}
