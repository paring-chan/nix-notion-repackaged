{
  description = "A very basic flake";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11"; };

  outputs = { self, nixpkgs }:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in let pkg = pkgs.callPackage ./package.nix { };
    in {
      packages.x86_64-linux.default = pkg;
      packages.x86_64-linux.notion-repackaged = pkg;
    };
}
