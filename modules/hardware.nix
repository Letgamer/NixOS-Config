{
  lib,
  pkgs,
  ...
}: {
  # Increase the number of parallel build jobs for Nix to 12
  nix.settings.max-jobs = lib.mkForce 12;

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "sr_mod"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "thunderbolt"
    ];

    kernelModules = [
      "kvm-intel"
      "intel_rapl"
    ];

    kernelParams = [
      "mitigations=off"
      # Disable for the bootup animation to be displayed correctly
      "video=HDMI-A-1:d"
      # Skip early simpledrm/efifb; wait for amdgpu KMS
      "initcall_blacklist=sysfb_init"
    ];

    initrd.systemd.services.systemd-vconsole-setup = {
      after = ["systemd-modules-load.service"];
      wants = ["systemd-modules-load.service"];
    };
  };

  hardware = {
    # enable firmware with a license allowing redistribution
    enableRedistributableFirmware = lib.mkForce true;

    # enable all firmware regardless of license
    enableAllFirmware = lib.mkForce true;

    # enable CPU microcode updates
    cpu.intel.updateMicrocode = true;

    amdgpu.opencl.enable = true; # Proprietary AMD OpenCL support
    amdgpu.initrd.enable = true; # Enable Initrd support

    graphics = {
      enable = true;
      enable32Bit = true;

      # Optional: extra Vulkan ICD and Mesa Vulkan layers, useful for some apps and games
      extraPackages = with pkgs; [
        vulkan-tools # For vulkaninfo and debugging Vulkan apps
      ];
    };
  };

  environment.variables = {
    HIP_PLATFORM = "amd";
    AMD_VULKAN_ICD = "RADV";
  };

  environment.systemPackages = with pkgs; [
    clinfo
    vulkan-tools
    mesa-demos
    radeontop # AMD GPU utilization monitor
    lm_sensors # For temperature sensors
    pciutils
    rocmPackages.rocm-runtime
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
  ];

  # Allow firmware Updates
  services.fwupd.enable = true;
}
