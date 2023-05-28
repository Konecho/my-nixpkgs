{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
  cmake,
  libnl,
  libpulseaudio,
  pkg-config,
}:
rustPlatform.buildRustPackage rec {
  pname = "baru";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "doums";
    repo = "baru";
    rev = "v${version}";
    hash = "sha256-vLWswwwN1BAR1SZ5lvkNVfqOrAsjtH143ogdTTM2Ev0=";
  };

  cargoHash = "sha256-1FqJUF7kaJzQz2u+CA7sPkKrK5O9mt4moAXYW34naFM=";

  buildInputs =
    lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreFoundation
    ]
    ++ [libnl libpulseaudio pkg-config];

  configurePhase = ''
    export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE $(pkg-config --cflags libnl-3.0)"
  '';

  nativeBuildInputs = [cmake];

  meta = with lib; {
    description = "A system monitor written in Rust and C";
    homepage = "https://github.com/doums/baru";
    license = with licenses; [];
    maintainers = with maintainers; [];
  };
}
