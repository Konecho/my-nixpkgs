{
  lib,
  callPackage,
  python3,
  fetchFromGitHub,
  qt5,
}: let
  imgviz = callPackage ./imgviz.nix {};
in
  python3.pkgs.buildPythonApplication rec {
    pname = "labelme";
    version = "5.2.1";
    format = "setuptools";

    src = fetchFromGitHub {
      owner = "wkentaro";
      repo = "labelme";
      rev = "v${version}";
      hash = "sha256-WZ/DgtyBQVGCldN2Yep+YZbgG+wkKiVD6b5Pmk1T/vY=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [qt5.wrapQtAppsHook];
    buildInputs = [qt5.qtbase];
    propagatedBuildInputs = with python3.pkgs; [
      gdown
      matplotlib
      natsort
      numpy
      onnxruntime
      pillow
      pyyaml
      qtpy
      pyqt5
      scikitimage
      termcolor

      imgviz
    ];

    dontWrapQtApps = true;
    preFixup = ''
      makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    '';

    pythonImportsCheck = ["labelme"];

    meta = with lib; {
      description = "Image Polygonal Annotation with Python (polygon, rectangle, circle, line, point and image-level flag annotation";
      homepage = "https://github.com/wkentaro/labelme";
      license = licenses.gpl3Only;
      # broken = true;
      maintainers = with maintainers; [];
    };
  }
