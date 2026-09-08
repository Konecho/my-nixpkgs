{
  lib,
  python3,
  python311,
  python312,
  fetchFromGitHub,
  callPackage,
  makeWrapper,
  source,
}: let
  # Use default python3
  # Note: tcl-tk 9.0 compatibility issue on macOS, but should work on Linux
  # See: https://github.com/PySimpleGUI/PySimpleGUI/issues/6822
  python = python3;
  pythonEnv = python.withPackages (ps:
    with ps; [
      onnxruntime
      torch
      torchvision
      opencv-python
      pillow
      (callPackage ./freesimplegui.nix {})
      python-osc
      pydantic
      pyserial
      colorama
      psutil
      requests
      sounddevice
      soundfile
    ]);
  freesimplegui = callPackage ./freesimplegui.nix {};
in
  python.pkgs.buildPythonApplication rec {
    pname = "project-babble";
    version = source.version;
    format = "other";

    src = source.src;

    nativeBuildInputs = [makeWrapper];

    # Patch for Linux compatibility and config file location
    postPatch = ''
      # Fix windll import for Linux
      substituteInPlace BabbleApp/babbleapp.py \
        --replace-fail 'from ctypes import windll, c_int' 'import sys; from ctypes import c_int; windll = None if sys.platform != "win32" else __import__("ctypes").windll'
      substituteInPlace BabbleApp/babbleapp.py \
        --replace-fail 'winmm = windll.winmm' 'winmm = windll.winmm if windll else None'
      substituteInPlace BabbleApp/babbleapp.py \
        --replace-fail 'winmm.timeBeginPeriod(1)' 'winmm.timeBeginPeriod(1) if winmm else None'
      substituteInPlace BabbleApp/babbleapp.py \
        --replace-fail 'winmm.timeEndPeriod(1)' 'winmm.timeEndPeriod(1) if winmm else None'

      # Use XDG config directory for settings
      substituteInPlace BabbleApp/config.py \
        --replace-fail 'CONFIG_FILE_NAME: str = "babble_settings.json"' 'CONFIG_FILE_NAME: str = os.path.join(os.path.expanduser("~/.config/project-babble"), "babble_settings.json")'
      substituteInPlace BabbleApp/config.py \
        --replace-fail 'BACKUP_CONFIG_FILE_NAME: str = "babble_settings.backup"' 'BACKUP_CONFIG_FILE_NAME: str = os.path.join(os.path.expanduser("~/.config/project-babble"), "babble_settings.backup")'
      substituteInPlace BabbleApp/config.py \
        --replace-fail 'from utils.misc_utils import EnsurePath' 'from utils.misc_utils import EnsurePath; os.makedirs(os.path.expanduser("~/.config/project-babble"), exist_ok=True)'
    '';

    propagatedBuildInputs = with python3.pkgs; [
      onnxruntime
      torch
      torchvision
      opencv-python
      pillow
      freesimplegui
      python-osc
      pydantic
      pyserial
      colorama
      psutil
      requests
      sounddevice
      soundfile
    ];

    installPhase = ''
              runHook preInstall

              mkdir -p $out/bin $out/lib/${pname}
              cp -r BabbleApp/* $out/lib/${pname}/

              # Create PySimpleGUI compatibility wrapper
              mkdir -p $out/lib/${pname}/PySimpleGUI
              cat > $out/lib/${pname}/PySimpleGUI/__init__.py <<EOF
      from FreeSimpleGUI import *
      from FreeSimpleGUI import __version__
      EOF

              # Create wrapper script with PYTHONPATH
              makeWrapper ${python.interpreter} $out/bin/babble-app \
                --add-flags "$out/lib/${pname}/babbleapp.py" \
                --set PYTHONPATH "${pythonEnv}/${python.sitePackages}" \
                --run "cd $out/lib/${pname}"

              runHook postInstall
    '';

    pythonImportsCheck = [];

    meta = with lib; {
      description = "Open source mouth tracking for VR headsets";
      homepage = "https://github.com/Project-Babble/ProjectBabble";
      license = licenses.mit;
      maintainers = with maintainers; [];
      mainProgram = "babble-app";
      platforms = platforms.linux;
    };
  }
