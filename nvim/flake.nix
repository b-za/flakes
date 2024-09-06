{
  description = "bhnvim";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    bhnvim.${system}.default =
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
