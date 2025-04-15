{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "kflash";
  version = "1.1.6";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-7F+7NeqBqRyJ9FjTdeJKbas9OGXGmn5iUFEbLpP0tpU=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    # enum34
    pyelftools
    pyserial
  ];

  pythonImportsCheck = ["kflash"];

  meta = with lib; {
    description = "Kendryte UART ISP Utility - programming code to k210";
    homepage = "https://pypi.org/project/kflash/";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "kflash";
  };
}
