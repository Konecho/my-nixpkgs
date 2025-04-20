{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "tuigreet";

  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "Konecho";
    repo = "tuigreet";
    rev = "refs/tags/${version}";
    sha256 = "sha256-ImvABT2+n39/Sdx51I+mDBdA1EXFCenqk7XjA/gNM/Q=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-RkJjAmZ++4nc/lLh8g0LxGq2DjZGxQEjFOl8Yzx116A=";

  meta = {
    description = "Graphical console greeter for greetd";
    homepage = "https://github.com/apognu/tuigreet";
    changelog = "https://github.com/apognu/tuigreet/releases/tag/${version}";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "tuigreet";
  };
}
