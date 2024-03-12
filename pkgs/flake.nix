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
        # linter
        inherit (pkgs) deadnix;
        inherit (pkgs) hadolint;
        inherit (pkgs) shellcheck;
        inherit (pkgs) statix;
        inherit (scripts) textlint;

        # formatter
        inherit (pkgs) go;
        inherit (pkgs) gotools;
        inherit (pkgs) nixfmt;
        inherit (pkgs) stylua;
        inherit (pkgs.nodePackages) prettier;
        inherit (pkgs.perlPackages) PerlTidy;

        # language server
        inherit (pkgs) gopls;
        inherit (pkgs) nixd;
        inherit (pkgs) perlnavigator;
        inherit (pkgs) sqls;
        inherit (pkgs.luajitPackages) lua-lsp;
        inherit (pkgs.nodePackages) bash-language-server;
        inherit (pkgs.nodePackages) vscode-json-languageserver;

        # toolchain
        inherit (pkgs) biome;
        inherit (pkgs) sqlfluff;
      };
    };
}
