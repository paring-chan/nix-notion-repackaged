{ lib, stdenv, pkgs, makeDesktopItem }:
stdenv.mkDerivation (finalAttrs:
  let version = "3.1.1-2";
  in {
    pname = "notion-repackaged";

    inherit version;

    src = fetchTarball {
      url =
        "https://github.com/dusansimic/notion-repackaged/releases/download/v${version}/notion-app.tar.xz";
      sha256 = "sha256:1j90g43pc3pv95rbfdizjw4340qylwks0aps2hnvxjf1w9zxj3wb";
    };

    installPhase = ''
      mkdir -p $out
      mv pkg/* $out/
    '';

    fixupPhase = ''
      sed -i 's%/usr/bin/bash%${pkgs.bash}/bin/bash\nexport LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"%' $out/bin/notion-app
      sed -i 's/@prefix@//' $out/bin/notion-app
      sed -i 's%@electron@%${pkgs.electron_28-bin}/bin/electron%' $out/bin/notion-app
      sed -i "s%/usr/lib/notion-app%$out/lib/notion-app%" $out/bin/notion-app
    '';

    dontBuild = true;

    meta = with lib; { mainProgram = "notion-app"; };

    desktopItems = [
      (makeDesktopItem {
        name = "notion";
        desktopName = "Notion";
        exec = "notion-app %U";
        icon = "notion-app";
        startupWMClass = "Notion";
      })
    ];
  })
