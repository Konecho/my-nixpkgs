{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "tuigreet";
  version = "93aca79";

  src = fetchFromGitHub {
    owner = "Konecho";
    repo = pname;
    rev = "93aca797f6bbb8a4802f4527c72cac5fe7f7537d";
    sha256 = "sha256-aZLZYWceeAeO63M5BZJfQMv8efrbIKZ6bdp05nTZvPw=";
  };

  cargoSha256 = "sha256-53vrUQ3eiX0ZirkRfXQbuLEM2XnshwSS3siYG5t4m2g=";

  meta = with lib; {
    description = "Graphical console greeter for greetd";
    homepage = "https://github.com/apognu/tuigreet";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [luc65r ivar];
    platforms = platforms.linux;
    broken = true;
  };
}
