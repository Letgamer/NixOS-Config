{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication {
  pname = "gmsadumper";
  version = "0-unstable-2024-02-12";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "micahvandeusen";
    repo = "gMSADumper";
    rev = "e03187ca5c2b38b8742a20b919ebe38633c0b084";
    hash = "sha256-IR/nZr8tWmIqN5ghN6rBc3YmLMinyN5T6IvtStzivDE=";
  };

  dependencies = with python3Packages; [
    impacket
    ldap3
    pycryptodomex
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 gMSADumper.py "$out/bin/gMSADumper.py"
    ln -s gMSADumper.py "$out/bin/gMSADumper"

    runHook postInstall
  '';

  meta = {
    description = "Reads any gMSA password blobs the user can access and parses the values.";
    homepage = "https://github.com/micahvandeusen/gMSADumper";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [Letgamer];
    mainProgram = "gMSADumper";
  };
}
