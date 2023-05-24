{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "imgviz";
  version = "1.5.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "wkentaro";
    repo = "imgviz";
    rev = "v${version}";
    hash = "sha256-J3QNSU59Ctrn3yctBbLWmPerzAkOA/TLbzeXbDc0qlg=";
    fetchSubmodules = true;
  };

  propagatedBuildInputs = with python3.pkgs; [
    matplotlib
    numpy
    pillow
    pyyaml
    setuptools
  ];

  pythonImportsCheck = [ "imgviz" ];

  meta = with lib; {
    description = "Image Visualization Tools (object detection, semantic and instance segmentation";
    homepage = "https://github.com/wkentaro/imgviz";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
