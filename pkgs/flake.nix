{
  description = "toolchain repository for call from nvim";
  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      scripts = {
        textlint = with pkgs;
          runCommand "textlint" { } ''
            mkdir -p $out/bin/
            echo 'exec -a textlint $HOME/.local/share/npm/bin/textlint "''${@}"' >$out/bin/textlint
            chmod +x $out/bin/textlint
          '';
      };

    in {
      packages."x86_64-linux" = {
        inherit (pkgs) deadnix;
        inherit (pkgs) hadolint;
        inherit (pkgs) statix;
        inherit (scripts) textlint;
      };
    };
}
