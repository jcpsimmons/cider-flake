{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = with import nixpkgs { system = "x86_64-linux"; };
      with (import ./build-appimage.nix { inherit pkgs; });
      let
        version = "0.6.6";
      in
      buildAppImage {
        name = "Cider";
        url = "https://github.com/ciderapp/Cider/releases/download/v1.6.1/Cider-1.6.1.AppImage";
        sha256 = "sha256-OzHFH0CTcHyeP6zNReM4hOYNa1W79It2VaZk7wGIDpc=";
        icon = fetchurl {
          url = https://raw.githubusercontent.com/ciderapp/Cider/5071426b4787c583fa3a0bbf68ba6ba867f243a3/Assets/Vinyl%20Logo/cider-vinyl%20no%20raster.svg;
          sha256 = "943efe7ac98ad14519e9c0ce57fbda1f5f5b9720169ae0288ca78c96559ab010";
        };
        categories = "Streaming Music";
      };

  };
}
