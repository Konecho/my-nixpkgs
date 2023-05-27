{ lib
, stdenv
, fetchFromGitHub
, just
, texlive
}:

let mkFonts = { pname, subDir }: stdenv.mkDerivation rec{
  inherit pname;
  src = fetchFromGitHub {
    owner = "mengchaoheng";
    repo = "SCUT_thesis";
    rev = "a225bf8fe35bf606ed718557eb199e43e47fd97b";
    hash = "sha256-GXZ/jaq8aSUAhn+p0yfs9wiCVq13Bx+GMJZvIVrc070=";
  };
  version = "unstable-2023-03-18";
  installPhase = ''
    find ${subDir} -name '*.ttf'    -exec install -Dt $out/share/fonts/truetype {} \;
    find ${subDir} -name '*.ttc'    -exec install -Dt $out/share/fonts/truetype {} \;
  '';
};
in
{
  windows = mkFonts { pname = "scutfonts-win"; subDir = "./settings_files/Win"; };
  macos = mkFonts { pname = "scutfonts-mac"; subDir = "./settings_files/MacOS"; };
  linux = mkFonts { pname = "scutfonts-linux"; subDir = "./settings_files/Linux"; };
}
