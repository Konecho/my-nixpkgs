{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "strsimpy";
  version = "0.2.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-CELrV/evhsiCpZobyHIewlgKJn5WP9BQPO0pcgQDcsk=";
  };

  pythonImportsCheck = ["strsimpy"];

  # ERROR: testSIFT4 (strsimpy.sift4_test.SIFT4Test.testSIFT4)
  # AttributeError: 'SIFT4Test' object has no attribute 'assertEquals'. Did you mean: 'assertEqual'?
  doCheck = false;

  meta = with lib; {
    description = "A library implementing different string similarity and distance measures";
    homepage = "https://pypi.org/project/strsimpy/";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
