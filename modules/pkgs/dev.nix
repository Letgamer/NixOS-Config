{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # C/C++
    gcc
    gnumake
    autoconf
    automake
    cmake
    clang
    llvm

    # Python
    python3
    python314Packages.bpython
    uv

    # Java
    javaPackages.compiler.openjdk25
    maven
    gradle

    # Bash
    shfmt
    shellcheck

    # Rust
    rustup

    # Go
    go
  ];
}
