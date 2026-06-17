{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Debugging
    gdb
    gef

    # Disassemblers / Reverse Engineering
    binaryninja-free
    cfr
    (pkgs.cutter.withPlugins (plugins: builtins.attrValues plugins))
    edb
    ghidra
    jadx
    radare2

    # Exploit Development
    checksec
    one_gadget
    patchelf
    pwntools
    ropgadget

    # Hex / Binary Utilities
    hexedit
    xxd
  ];
}
