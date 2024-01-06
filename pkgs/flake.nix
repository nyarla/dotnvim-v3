{
  description = "toolchain repository for call from nvim";
  outputs = { nixpkgs, ... }:
    let
      tools = system: {
        "${system}" = {
          inherit (nixpkgs.legacyPackages.${system})
            deadnix statix stylua perlnavigator;
        };
      };
    in { packages = tools "x86_64-linux"; };
}
