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

        # Tailwind v4 standalone CLI. The nixpkgs `tailwindcss` package is v3
        # and cannot compile `assets/css/app.css` (which uses v4-only `@theme`,
        # `@plugin`, and `@source inline(...)`). The standalone binary bundles
        # `@tailwindcss/typography`, the only plugin this theme uses.
        tailwindcssV4 =
          let
            version = "4.1.10";
            sources = {
              "x86_64-linux" = {
                asset = "tailwindcss-linux-x64";
                sha256 = "1gwhsdqqzwfxm8xhprkmqbn3paqf9yj8xh4ivcxrirzj6gjs718a";
              };
              "aarch64-linux" = {
                asset = "tailwindcss-linux-arm64";
                sha256 = "1dn96fxw2fcfa8npspj7cm85j8crgwnvyz8j7inh9hh4nh5n5sv7";
              };
              "x86_64-darwin" = {
                asset = "tailwindcss-macos-x64";
                sha256 = "1bhknyzdvhg76yy4sjiihxhr0x2xp5h0v2mcw1b48f1ryv2k18a7";
              };
              "aarch64-darwin" = {
                asset = "tailwindcss-macos-arm64";
                sha256 = "0k2abxakzhfrhzgl7s4015wa4r3fjzxw9yx9wk3y4b8zbfkqajpk";
              };
            };
            src = sources.${system} or (throw "tailwindcss v4 standalone binary is not available for ${system}");
          in
          pkgs.stdenv.mkDerivation {
            pname = "tailwindcss";
            inherit version;

            src = pkgs.fetchurl {
              url = "https://github.com/tailwindlabs/tailwindcss/releases/download/v${version}/${src.asset}";
              sha256 = src.sha256;
            };

            dontUnpack = true;
            dontStrip = true;

            installPhase = ''
              runHook preInstall
              install -Dm755 "$src" "$out/bin/tailwindcss"
              runHook postInstall
            '';
          };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
            tailwindcssV4
            go # Added Go for Hugo modules

            # Tools
            git-cliff
            yaml-language-server
            vscode-json-languageserver
            tailwindcss-language-server
          ];
        };
      }
    );
}
