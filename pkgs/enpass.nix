{ pkgs }:
pkgs.enpass.overrideAttrs (_: rec {
  version = "6.11.13.1957";
  src = pkgs.fetchurl {
    url = "https://apt.enpass.io/pool/main/e/enpass/enpass_${version}_amd64.deb";
    sha256 = "2d8c90643851591aff41057b380a7e87bb839bf5c5aa0ca1456144e9996c902a";
  };
})
