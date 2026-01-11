{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "syllazh";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "oldherl";
    repo = "syllazh";
    rev = "v${version}";
    hash = "sha256-0xYQeNuJAowAwcbh2pso5YjLTkViVNu85XVGBNtpU6M=";
  };

  installPhase = ''
    mkdir -p $out/share/consolefonts
    mv ./output/*.psfu.gz $out/share/consolefonts
  '';

  meta = {
    description = "Linux TTY font for Chinese, but treat it as a syllabic writing / 中文 Linux TTY 字体，但是表音文字";
    homepage = "https://github.com/oldherl/syllazh/";
    maintainers = with lib.maintainers; [];
    mainProgram = "syllazh";
    platforms = lib.platforms.all;
  };
}
