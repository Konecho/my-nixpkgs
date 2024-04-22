create PKGNAME:
    sd "}\n" "{{PKGNAME}} = pkgs.callPackage ./pkgs/{{PKGNAME}} {};}" ./default.nix
    alejandra .
    mkdir -p ./pkgs/{{PKGNAME}}
    cd ./pkgs/{{PKGNAME}} && nix-init
    alejandra .
    git add .
    nix run .#{{PKGNAME}}
