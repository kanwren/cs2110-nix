{
  description = "Nix derivations for the Georgia Tech CS 2110 toolchain";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, nixpkgs }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ./mednafen-overlay.nix) ];
      };
    in {
      packages = import ./default.nix { inherit pkgs; };
      overlay = pkgs-self: pkgs-super: {
        cs2110 = import ./default.nix { pkgs = pkgs-self; };
      };
    }
  );
}
