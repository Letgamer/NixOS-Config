{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
  versionCheckHook,
}:
stdenvNoCC.mkDerivation {
  pname = "cupp";
  version = "3.3.1";

  src = fetchFromGitHub {
    owner = "Mebus";
    repo = "cupp";
    rev = "616a7b0c01b9cec51954df86a2a538dffcba3834";
    hash = "sha256-s2yxQwth5CsPU0D10OpoKSCj0Q71ybWj13Rwu+75Xws=";
  };

  postPatch = ''
    substituteInPlace cupp.py \
      --replace-fail "#!/usr/bin/python3" "#!${python3.interpreter}"
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 cupp.py "$out/bin/cupp"

    install -Dm644 "$src/cupp.cfg" "$out/bin/cupp.cfg"

    runHook postInstall
  '';

  nativeInstallCheckInputs = [versionCheckHook];
  doInstallCheck = true;

  meta = {
    description = "Common User Passwords Profiler (CUPP)";
    homepage = "https://github.com/Mebus/cupp";
    license = lib.licenses.gpl3Only;
    maintainers = lib.maintainers.Letgamer;
    mainProgram = "cupp";
  };
}
