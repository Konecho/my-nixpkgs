{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  alsa-lib,
  stdenv,
  darwin,
  libxkbcommon,
  wayland,
  xorg,
}:
rustPlatform.buildRustPackage rec {
  pname = "gameboy";
  version = "unstable-2023-02-23";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "gameboy";
    rev = "bc90e61fa2de41fccd687a0ed98a8346066875f9";
    hash = "sha256-i9tbQx6Y627BNkKaIkBYZtYwRBqA9FNPnBTFPnGKogQ=";
  };

  cargoHash = "sha256-M+/Lktp8VYaFjkh1a+IU/YdJK8X7+4CzSJB9jBM2YHk=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    libxkbcommon
  ];

  buildInputs =
    [
      alsa-lib
      wayland
    ]
    ++ (with xorg; [
      libX11.dev
      libXcursor.dev
    ])
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreAudio
      darwin.apple_sdk.frameworks.CoreFoundation
    ];

  meta = with lib; {
    description = "Full featured Cross-platform GameBoy emulator by Rust. Forever boys";
    homepage = "https://github.com/mohanson/gameboy";
    license = licenses.wtfpl;
    maintainers = with maintainers; [];
  };
}
