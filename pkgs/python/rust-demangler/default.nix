{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
}:
buildPythonPackage rec {
  pname = "rust-demangler";
  version = "1.0";
  pyproject = true;

  src = fetchPypi {
    pname = "rust_demangler";
    inherit version;
    hash = "sha256-o+iAMuaRMi0UzsE399mvvkSsZahCF8WZvSz+SA7IvQ8=";
  };

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = ["rust_demangler"];

  meta = with lib; {
    description = "A package for demangling Rust symbols";
    homepage = "https://pypi.org/project/rust-demangler/";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
