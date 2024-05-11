{
  lib,
  python3,
  libretro,
  fetchFromGitHub,
}: let
  pypkgs = python3.pkgs;
in
  pypkgs.buildPythonApplication rec {
    pname = "gambaterm";
    version = "0.12.4";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "vxgmichel";
      repo = "gambatte-terminal";
      rev = "v${version}";
      hash = "sha256-VZITiBgcHBjIk4d82Swt/hmlY2+FXjAk0WOx2iNrL8U=";
    };

    nativeBuildInputs = with pypkgs; [
      cython
      oldest-supported-numpy
      setuptools
      wheel
    ];
    propagatedBuildInputs =
      (with pypkgs; [
        prompt-toolkit
        asyncssh
        sounddevice
        samplerate
        xlib
        # pynput
        pyaudio
      ])
      ++ [libretro.gambatte];
    pythonImportsCheck = ["gambaterm"];

    meta = with lib; {
      description = "A terminal frontend for gambatte game boy color emulator";
      homepage = "https://github.com/vxgmichel/gambatte-terminal";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [];
      mainProgram = "gambaterm";
    };
  }
