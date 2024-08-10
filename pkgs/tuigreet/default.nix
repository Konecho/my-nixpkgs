{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "tuigreet";

  version = "3a5cdbf986df538a1be4a1ca79853b601601420c";

  src = fetchFromGitHub {
    owner = "Konecho";
    repo = "tuigreet";
    rev = version;
    sha256 = "sha256-F93v/KnqMEYxZn1UDYCNPx48e4vd5JINh29jZUPmV0k=";
  };
  cargoHash = "sha256-uJGFsQ4CZWD7bC4qQxMHaJpjIh2UoBwJAf4FBFnzq0U=";

  meta = {
    description = "Graphical console greeter for greetd";
    homepage = "https://github.com/apognu/tuigreet";
    changelog = "https://github.com/apognu/tuigreet/releases/tag/${version}";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.linux;
    mainProgram = "tuigreet";
  };
}
