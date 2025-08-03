{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["kvm-intel" "intel_rapl"];

    kernelParams = [
      "video=DP-3:2560x1440@165"
      "video=HDMI-A-1:1920x1080@144"
      "mitigations=off"
    ];
  };

  hardware = {
    # enable CPU microcode updates
    cpu.intel.updateMicrocode = true;

    enableAllFirmware = true;

    amdgpu.opencl.enable = true; # Proprietary AMD OpenCL support

    graphics = {
      enable = true;
      enable32Bit = true;

      # Optional: extra Vulkan ICD and Mesa Vulkan layers, useful for some apps and games
      extraPackages = with pkgs; [
        vulkan-tools # For vulkaninfo and debugging Vulkan apps
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };

  # Recommended to explicitly declare video driver for Xorg and fallback support
  services.xserver.videoDrivers = ["amdgpu"];

  environment.systemPackages = with pkgs; [
    clinfo
    vulkan-tools
    glxinfo
    radeontop # AMD GPU utilization monitor
    lm_sensors # For temperature sensors
    pciutils
    #openrgb # for led control
  ];

  # Allow firmware Updates
  services.fwupd.enable = true;

  # Add a swapfile
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];
}
