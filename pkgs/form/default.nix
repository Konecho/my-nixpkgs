{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "form";
  version = "0.12.1";

  src = fetchFromGitHub {
    owner = "djmcgill";
    repo = "form";
    rev = "v${version}";
    hash = "sha256-aVSE6RkP/FlFQl8yeC59fY2yiFW3a7hGpijiIzHQIkE=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-5CZZjQvamBwNVTD7wb0Pp71rF9nDmPprse3SB17ywT0=";

  meta = with lib; {
    description = "A utility to split autogenerated rust files into human-workable projects with the correct _form";
    homepage = "https://github.com/djmcgill/form";
    changelog = "https://github.com/djmcgill/form/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "form";
  };
}
