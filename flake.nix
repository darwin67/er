{
  description = "Er Hugo Theme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
          };
        };
        corepack = pkgs.stdenv.mkDerivation {
          name = "corepack";
          buildInputs = [ pkgs.nodejs_24 ];
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            corepack enable --install-directory=$out/bin
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ corepack ];

          buildInputs = with pkgs; [
            hugo
            nodejs_24
            tailwindcss
            go # Added Go for Hugo modules

            # LSP
            yaml-language-server
            vscode-json-languageserver
            tailwindcss-language-server
          ];
        };
      }
    );
}
