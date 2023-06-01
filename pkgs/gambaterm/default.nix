{
  lib,
  python3,
  fetchFromGitHub,
}: let
  pypkgs = python3.pkgs;
in
  pypkgs.buildPythonApplication rec {
    pname = "gambaterm";
    version = "0.12.1";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "vxgmichel";
      repo = "gambatte-terminal";
      rev = "v${version}";
      hash = "sha256-rL0B14aGn0tTsguu25hGq8oAR8HupNCm/dg6I7IwxZg=";
    };

    nativeBuildInputs = with pypkgs; [
      cython
      numpy
      setuptools
      wheel
    ];
    propagatedBuildInputs = with pypkgs; [
      prompt-toolkit
      asyncssh
      sounddevice
      samplerate
      xlib
      pyaudio
    ];
    # pythonImportsCheck = ["gambatte_terminal"];

    meta = with lib; {
      description = "A terminal frontend for gambatte game boy color emulator";
      homepage = "https://github.com/vxgmichel/gambatte-terminal";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [];
      mainProgram = "gambaterm";
    };
  }
