{pkgs, ...}: {
  # TODO: Package all of the EZ Tools: https://www.sans.org/blog/running-ez-tools-natively-on-linux-a-step-by-step-guide
  environment.systemPackages = with pkgs; [
    # Artifact extraction
    binwalk
    bulk_extractor
    exiftool
    foremost
    pdf-parser
    pdfid
    scalpel

    # Disk / filesystem forensics
    autopsy
    sleuthkit

    # Memory forensics
    volatility3

    # Steganography
    steghide
    stegseek
    zsteg
  ];
}
