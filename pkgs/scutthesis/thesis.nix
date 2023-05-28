{
  lib,
  stdenv,
  fetchFromGitHub,
  just,
  texlive,
  xdg-open,
}: let
  # tex = (texlive.combine {
  #   inherit (texlive) scheme-small
  #     biber;
  #   # dvisvgm dvipng# for preview and export as html
  #   # wrapfig amsmath ulem hyperref capt-of;
  #   #(setq org-latex-compiler "lualatex")
  #   #(setq org-preview-latex-default-process 'dvisvgm)
  # });
  tex = texlive.combined.scheme-full;
in
  stdenv.mkDerivation rec {
    pname = "scutthesis";
    src = fetchFromGitHub {
      owner = "mengchaoheng";
      repo = "SCUT_thesis";
      rev = "a225bf8fe35bf606ed718557eb199e43e47fd97b";
      hash = "sha256-GXZ/jaq8aSUAhn+p0yfs9wiCVq13Bx+GMJZvIVrc070=";
    };
    version = "unstable-2023-03-18";
    propagatedBuildInputs = [just tex xdg-open];
    binName = "scut";

    installPhase = ''
      mkdir -p $out/bin
      cat ${./justfile}  >> $out/bin/justfile

      chmod +x $out/bin/justfile
      substituteAllInPlace $out/bin/justfile
      substituteInPlace $out/bin/justfile --replace textlive  ${tex}/bin

      ln -s $out/bin/justfile $out/bin/${binName}

      mkdir -p $out/share
      cp *.tex $out/share
      cp *.bib $out/share
      cp *.sty $out/share
      cp *.cls $out/share
      cp -r Fig $out/share
    '';

    meta = with lib; {
      description = "华南理工大学硕博士学位论文LaTeX模板。Latex templates for the thesis of South China University of Technology";
      homepage = "https://github.com/mengchaoheng/SCUT_thesis";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [];
    };
  }
