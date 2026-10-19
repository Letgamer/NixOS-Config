{username, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    # Needed for Podman
    autoSubUidGidRange = true;
    extraGroups = [
      "wheel"
      "video"
      "render"
      "sudo"
      "kvm"
      "adbusers"
      "usb"
      "wireshark"
      "libvirt"
      "libvirtd"
      "docker"
      "podman"
      "networkmanager"
      "network"
    ];
    # Enable ‘sudo’ for the user.
    initialPassword = "user";
  };

  users.mutableUsers = false;
  users.manageLingering = false;
  users.users.root.initialPassword = "test";
}
