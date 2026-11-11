{pkgs, ...}: {
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "usbhid"
        "xhci_pci"
      ];
      systemd.services.systemd-vconsole-setup = {
        after = ["systemd-modules-load.service"];
        wants = ["systemd-modules-load.service"];
      };
      supportedFilesystems.btrfs = true;
    };

    supportedFilesystems.btrfs = true;

    kernelModules = [
      "kvm-intel"
      "gigabyte-wmi"
    ];

    kernelParams = [
      "mitigations=off"
      # Disable for the bootup animation to be displayed correctly
      "video=HDMI-A-1:d"
      # Skip early simpledrm/efifb; wait for amdgpu KMS
      "initcall_blacklist=sysfb_init"
    ];
  };

  hardware = {
    # enable firmware with a license allowing redistribution
    enableRedistributableFirmware = true;

    # enable all firmware regardless of license
    enableAllFirmware = true;

    # enable CPU microcode updates
    cpu.intel.updateMicrocode = true;

    amdgpu.opencl.enable = true; # Proprietary AMD OpenCL support
    amdgpu.initrd.enable = true; # Enable Initrd support

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  environment.variables = {
    HIP_PLATFORM = "amd";
    # Spoof Navi 21 (gfx1030) ISA for RX 6600 (gfx1032) so ROCm/HIP workloads run without target errors
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };

  environment.systemPackages = with pkgs; [
    clinfo
    vulkan-tools
    mesa-demos
    libva-utils
    amdgpu_top
    pciutils
    smartmontools
    rocmPackages.rocminfo
    rocmPackages.amdsmi
  ];

  # Allow firmware Updates
  services.fwupd.enable = true;
}
