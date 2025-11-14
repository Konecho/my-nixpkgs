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
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "mohanson";
    repo = "gameboy";
    rev = "0df1f63ae6ed7331e60fa597e7e7c93d9745e191";
    hash = "sha256-/R3DuzlfGdhtaSIF9f8sGY1143rOFVXR1ufIuyCNEAs=";
  };

  cargoHash = "sha256-V227BGe2+5JYznJp4gZqtojsKHGSFxH7sFZG4RhgQd0=";

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
