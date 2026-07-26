{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication {
  pname = "pkinittools";
  version = "0-unstable-2025-01-03";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "dirkjanm";
    repo = "PKINITtools";
    rev = "0f0cfa542b0348609ad494713e84744234b2d3b0";
    hash = "sha256-9aKcSe12jsCrjdqcH3w3/T3+DIce2KW08ukSRf5F+hE=";
  };

  dependencies = with python3Packages; [
    impacket
    minikerberos
    oscrypto
    pyasn1
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 getnthash.py "$out/bin/getnthash"
    install -Dm755 gets4uticket.py "$out/bin/gets4uticket"
    install -Dm755 gettgtpkinit.py "$out/bin/gettgtpkinit"

    runHook postInstall
  '';

  meta = {
    description = "PKINITtools for working with Kerberos PKINIT operations";
    homepage = "https://github.com/dirkjanm/PKINITtools";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [Letgamer];
    platforms = lib.platforms.linux;
    mainProgram = "gettgtpkinit";
  };
}
