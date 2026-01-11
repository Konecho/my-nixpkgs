{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  unzip,
  psftools,
  bdflib,
  python3,
}: let
  buildPythonEnv = python3.withPackages (ps: [
    bdflib
  ]);
  pixelFont = fetchurl {
    url = "https://github.com/TakWolf/fusion-pixel-font/releases/download/2025.10.20/fusion-pixel-font-12px-monospaced-bdf-v2025.10.20.zip";
    sha256 = "sha256-JbSBdEluvSdRJ0zTVEUJRbAlp9E88WE5dPeTmlcFFwk=";
  };
in
  stdenv.mkDerivation rec {
    pname = "cengluan";
    version = "2.3.0";

    src = fetchFromGitHub {
      owner = "PJ-568";
      repo = "font-cengluan";
      rev = "v${version}";
      hash = "sha256-/WQLxMihobGwFYe7nZKwqvsNjSMWknFvrARE+MfCsM8=";
    };
    nativeBuildInputs = [buildPythonEnv psftools unzip];

    buildPhase = ''
      mkdir temp
      unzip ${pixelFont} -d temp

      python build_font_from_bdf.py "temp/fusion-pixel-12px-monospaced-zh_hans.bdf" > cengluan.txt

      txt2psf cengluan.txt cengluan.psf
    '';

    installPhase = ''
      mkdir -p $out/share/consolefonts
      gzip -c cengluan.psf > $out/share/consolefonts/cengluan.psfu.gz
    '';

    meta = {
      description = "层峦（cengluan）是一个为 Linux 设计的中文 TTY 字体，旨在在不安装诸如 cjktty 等内核补丁且不安装 kmscon、fbterm 或 zhcon 等第三方软件的环境下提供 TTY 中文显示";
      homepage = "https://github.com/PJ-568/font-cengluan";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [];
      platforms = lib.platforms.all;
    };
  }
