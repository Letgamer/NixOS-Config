{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonApplication {
  pname = "petitpotam";
  version = "0-unstable-2024-08-15";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "topotam";
    repo = "PetitPotam";
    rev = "c5d5221dc5e6aac3bc7de97a34fa8d89c2f1900b";
    hash = "sha256-eaNnz/61gnBYJiyf4tpdRRTT0mYtRcafgFeUaVoucjY=";
  };

  dependencies = with python3Packages; [
    impacket
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 PetitPotam.py "$out/bin/PetitPotam.py"
    ln -s PetitPotam.py "$out/bin/PetitPotam"

    runHook postInstall
  '';

  meta = {
    description = "PoC tool to coerce Windows hosts to authenticate to other machines.";
    homepage = "https://github.com/topotam/PetitPotam";
    maintainers = with lib.maintainers; [Letgamer];
    mainProgram = "PetitPotam";
  };
}
