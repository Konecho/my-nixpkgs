{
  lib,
  stdenvNoCC,
  win2xcur,
  p7zip,
  fetchurl,
}: let
  win2xcur_sh = builtins.fetchurl {
    url = "";
    sha256 = "sha256-NoAXonpGXjLybFUb0Sxey0PsMTvgmo0jeJq5CWC6fhA=";
  };
in
  stdenvNoCC.mkDerivation {
    pname = "zmdcursor";
    version = "1.0";

    src = ./zmdcursor.zip;

    nativeBuildInputs = [p7zip win2xcur];

    unpackPhase = ''
      runHook preUnpack
      7z x $src
      runHook postUnpack
    '';

    installPhase = ''
      cat ${win2xcur_sh} >> ./win2xcur.sh
      mkdir -p out

      bash ./win2xcur.sh ./ ./out

      mkdir -p $out/share/icons/zmdcursor
      mv out/* $out/share/icons/zmdcursor
    '';

    meta = with lib; {
      license = licenses.unlicense;
      platforms = platforms.all;
      maintainers = with maintainers; [offline];
      broken = true;
    };
  }
