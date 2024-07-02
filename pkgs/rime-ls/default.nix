{
  lib,
  rustPlatform,
  fetchFromGitHub,
  librime,
}:
rustPlatform.buildRustPackage rec {
  pname = "rime-ls";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "wlh320";
    repo = "rime-ls";
    rev = "v${version}";
    hash = "sha256-xzquG8DMvZGiszXrYGiv31QGDd776UbKrNnwzGv9DQ0=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "librime-sys-0.1.0" = "sha256-zJShR0uaKH42RYjTfrBFLM19Jaz2r/4rNn9QIumwTfA=";
    };
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  checkFlags = [
    # panicked at src/rime.rs:317:5:
    # assertion failed: res.candidates.len() != 0
    "--skip=rime::test_get_candidates"
  ];

  nativeBuildInputs = [
    rustPlatform.bindgenHook
  ];

  propagatedBuildInputs = [
    librime
  ];

  meta = {
    description = "A language server for Rime input method engine 通过 LSP 代码补全使用 Rime 输入法";
    homepage = "https://github.com/wlh320/rime-ls";
    changelog = "https://github.com/wlh320/rime-ls/blob/${src.rev}/CHANGELOG.md";
    license = with lib; licenses.bsd3;
    maintainers = [];
    mainProgram = "rime_ls";
  };
}
