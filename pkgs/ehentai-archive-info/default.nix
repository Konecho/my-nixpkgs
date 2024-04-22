{
  pkgs,
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  nodejs,
}:
buildNpmPackage rec {
  pname = "ehentai-archive-info";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "dnsev-h";
    repo = "ehentai-archive-info";
    rev = "v${version}";
    sha256 = "sha256-wjuMi3kAj4RSL98O+iCf69y5v+WAqltPKnHYUqymZes=";
  };

  binName = "ehtag";

  npmDepsHash = "sha256-ZCUlLH5zcsbV96YaXL+MeTojAOQncFA5xs0tQvZiwro=";
  dontNpmBuild = true;

  postPatch = ''
    substituteInPlace \
      src/main.js \
      --replace "__dirname, \"../config.json" "process.env.HOME, \".config/ehentai-archive-info/config.json"
  '';

  postFixup = ''
    makeWrapper ${nodejs}/bin/node $out/bin/.${binName} \
      --add-flags $out/lib/node_modules/e-hentai-archive-metadata/src/main.js \
      --chdir $out/lib/node_modules/e-hentai-archive-metadata
    # substituteInPlace \
    #   $out_bin \
    #   --replace '$@' '$(readlink -f "$@")'
    echo "#!/bin/sh" >> $out/bin/${binName}
    echo '@out@/bin/.${binName} $(readlink -f "$@")' >> $out/bin/${binName}
    chmod +x $out/bin/${binName}
    substituteAllInPlace $out/bin/${binName}
  '';

  meta = with lib; {
    description = "Add metadata files to E*Hentai gallery archives";
    homepage = https://github.com/dnsev-h/ehentai-archive-info;
    changelog = "https://github.com/dnsev-h/ehentai-archive-info/releases";
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "${binName}";
  };
}
