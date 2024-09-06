{
  description = "my epic vims collection";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # devShells means if the flake is a shells you can run it with
    # nix develop
    # instead of
    # nix develop .#bob
    devShells.${system}.default =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.neovim
            pkgs.vim
          ];

          shellHook = ''
            echo "hello mom"
          '';
        };
    bob =
      pkgs.mkShell
        {
          buildInputs = [
            pkgs.neovim
            pkgs.vim
          ];

          shellHook = ''
            echo "hello mom"
          '';
        };
  };
}
