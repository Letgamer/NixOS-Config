{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Bash
    shellcheck
    shfmt

    # C/C++
    autoconf
    automake
    clang
    cmake
    gcc
    gnumake
    llvm

    # Go
    go

    # Java
    gradle
    javaPackages.compiler.openjdk25
    maven

    # Python
    python3
    python314Packages.bpython
    uv

    # Rust
    rustup
  ];
}
