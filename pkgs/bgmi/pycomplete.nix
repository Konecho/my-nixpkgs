{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pycomplete";
  version = "0.3.2";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Zxv7pwtvLuztrWttqrrCqj8Vc815DMVszUi4Bn9YQ5E=";
  };

  postPatch = ''
    sed -i '16,19d' pyproject.toml
  '';

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    pdm-pep517
  ];

  pythonImportsCheck = ["pycomplete"];

  meta = with lib; {
    description = "A Python library to generate static completion scripts for your CLI app";
    homepage = "https://pypi.org/project/pycomplete/";
    license = licenses.bsd3;
    maintainers = with maintainers; [];
  };
}
