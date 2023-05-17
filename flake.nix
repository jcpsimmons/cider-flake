{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ]
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          packages = flake-utils.lib.flattenTree rec {
            cider = pkgs.appimageTools.wrapType2 rec {
              name = "Cider";
              version = "1.6.1";
              src = pkgs.fetchurl {
                url = "https://github.com/ciderapp/Cider/releases/download/v${version}/Cider-${version}.AppImage";
                sha256 = "sha256-gAx2gzfKrERZJwyMx7zg0YhaJb91qRoRUMiojEMn6xE=";
              };
            };
          };
          defaultPackage = packages.cider;
        }
      );
}
