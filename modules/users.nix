{username, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "render"
      "sudo"
      "kvm"
      "adbusers"
      "usb"
      "wireshark"
      "docker"
      "libvirt"
      "libvirtd"
      "networkmanager"
      "network"
    ];
    # Enable ‘sudo’ for the user.
    initialPassword = "user";
  };

  users.mutableUsers = false;
  users.users.root.initialPassword = "test";
}
