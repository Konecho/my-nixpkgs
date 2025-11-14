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

check:
    nix-env -f . -qa \* --meta \
        --allowed-uris https://static.rust-lang.org \
        --option restrict-eval true \
        --option allow-import-from-derivation true \
        --drv-path --show-trace \
        -I nixpkgs=$(nix-instantiate --find-file nixpkgs) \
        -I ./ \
        --json | jq -r 'values | .[].name'