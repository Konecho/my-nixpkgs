create PKGNAME:
    sd "}\n" "{{PKGNAME}} = pkgs.callPackage ./pkgs/{{PKGNAME}} {};}" ./default.nix
    mkdir -p ./pkgs/{{PKGNAME}}
    cd ./pkgs/{{PKGNAME}} && nix-init
    just fmt
    git add .
    nix run .#{{PKGNAME}}

fetch:
    nix run nixpkgs#nvfetcher
    git add .
    just fmt

fmt:
    alejandra -e ./_sources .