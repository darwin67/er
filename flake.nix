{
  description = "Er Hugo Theme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        corepack = pkgs.stdenv.mkDerivation {
          name = "corepack";
          buildInputs = [ pkgs.nodejs_22 ];
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            corepack enable --install-directory=$out/bin
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = [ corepack ];

          buildInputs = with pkgs; [
            hugo
            nodejs_22
            tailwindcss
            go # Added Go for Hugo modules

            # LSP
            yaml-language-server
            nodePackages.vscode-json-languageserver
            tailwindcss-language-server
          ];
        };
      });
}
