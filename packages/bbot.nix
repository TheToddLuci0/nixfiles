{
  stdenv,
  fetchPypi,
  lib,
}: let
  pname = "bbot";
  version = "2.4.2";
in
  stdenv.mkDerivation rec {
    inherit pname version;

    src = fetchPypi {
      inherit pname version;
      hash = "sha256-Pe229rT0aHwA98s+nTHQMEFKZPo/yw6sot8MivFDvAw=";
    };

    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [
    ];

    # installPhase = ''
    #   runHook preInstall

    #   mkdir -p $out/bin

    #   cp -R usr/share usr/lib $out/

    #   # fix the path in the desktop file
    #   substituteInPlace \
    #     $out/share/applications/keeperpasswordmanager.desktop \
    #     --replace /lib/ $out/lib/

    #   ln -s $out/lib/keeperpasswordmanager/keeperpasswordmanager  $out/bin/keeperpasswordmanager

    #   runHook postInstall
    # '';

    meta = with lib; {
      description = "OSINT automation for hackers.";
      longDescription = "BEE·bot is a multipurpose scanner inspired by Spiderfoot, built to automate your Recon, Bug Bounties, and ASM!";
      homepage = "https://www.blacklanternsecurity.com/bbot/";
      platforms = platforms.linux;
      license = licenses.gpl3;
      maintainers = with maintainers; [
        TheToddLuci0
      ];
      mainProgram = "bbot";
      sourceProvenance = [
        sourceTypes.fromSource
      ];
    };
  }
