{
  fetchurl,
  buildLinux,
  kernelPatches,
  lib,
  fetchFromGitHub,
  ...
}: let
  version = "6.6.31";
  versionX = lib.versions.major version;
  versionX_X =
    lib.versions.majorMinor version;
  cjktty = fetchFromGitHub {
    owner = "zhmars";
    repo = "cjktty-patches";
    rev = "0d0015730edd2190dee7233f87dd72c423bb75e9";
    hash = "sha256-2PifENv3HD9a1q+uPsMnFp5RHdGcV4qOyX4e5dmDHK4=";
  };
in
  buildLinux {
    inherit version;
    modDirVersion = version;

    src = fetchurl {
      url = "mirror://kernel/linux/kernel/v${versionX}.x/linux-${version}.tar.xz";
      sha256 = "sha256:080wwrc231fbf43hvvygddmdxdspyw23jc5vnd6fr5ccdybgzv6n";
    };

    kernelPatches = [
      kernelPatches.bridge_stp_helper
      kernelPatches.request_key_helper
      {
        name = "cjktty";
        patch = "${cjktty}/v6.x/cjktty-${{"6.8" = "6.7";}.${versionX_X} or versionX_X}.patch";
        structuredExtraConfig = {
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
