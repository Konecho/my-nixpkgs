{
  fetchurl,
  buildLinux,
  kernelPatches,
  lib,
  fetchFromGitHub,
  ...
}: let
  version = "6.17.7";
  versionX = lib.versions.major version;
  versionX_X =
    lib.versions.majorMinor version;
  cjktty = fetchFromGitHub {
    owner = "bigshans";
    repo = "cjktty-patches";
    rev = "5c00aeabf86a80303a4a24ec6bfb47f1a0fa6c49";
    hash = "sha256-6JfJ29nUDicvRnYm/vo4r0UTvciN5Q+ECol/KIboDYY=";
  };
in
  buildLinux {
    inherit version;
    modDirVersion = version;

    src = fetchurl {
      url = "mirror://kernel/linux/kernel/v${versionX}.x/linux-${version}.tar.xz";
      sha256 = "sha256-3fLqDUQ54dVxNr42IxAq+UWPYB9bHLd+gyRuiK6gnQ4=";
    };

    kernelPatches = [
      # kernelPatches.bridge_stp_helper
      # kernelPatches.request_key_helper
      {
        name = "cjktty";
        patch = "${cjktty}/v6.x/cjktty-${{"6.17" = "6.16";}.${versionX_X} or versionX_X}.patch";
        extraStructuredConfig = {
          FONT_CJK_16x16 = lib.kernel.yes;
          FONT_CJK_32x32 = lib.kernel.yes;
        };
      }
    ];

    extraMeta.branch = versionX_X;

    meta = with lib; {
      # platforms = platforms.linux;
      platforms = ["x86_64-linux"];
    };
  }
