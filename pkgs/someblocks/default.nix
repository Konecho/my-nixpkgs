{
  lib,
  stdenv,
  fetchFromSourcehut,
  conf ? null,
  writeText,
}: let
  configFile =
    if lib.isDerivation conf || builtins.isPath conf
    then conf
    else writeText "blocks.def.h" conf;
in
  stdenv.mkDerivation rec {
    pname = "someblocks";
    version = "1.0.1";

    src = fetchFromSourcehut {
      owner = "~raphi";
      repo = "someblocks";
      rev = version;
      hash = "sha256-pUdiEyhqLx3aMjN0D0y0ykeXF3qjJO0mM8j1gLIf+ww=";
    };
    postPatch = lib.optionalString (conf != null) "cp ${configFile} blocks.def.h";
    NIX_CFLAGS_COMPILE = [
      "-Wno-error=unused-result"
    ];
    installPhase = ''
      runHook preInstall
      install -d $out/bin
      install -m755 someblocks $out/bin
      runHook postInstall
    '';

    meta = with lib; {
      description = "";
      homepage = "https://git.sr.ht/~raphi/someblocks";
      license = licenses.isc;
      maintainers = with maintainers; [];
    };
  }
