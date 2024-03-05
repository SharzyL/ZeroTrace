{
  inputs = {
    nixpkgs.url = "nixpkgs";
    nixpkgs_sgx.url = "nixpkgs/474831c2a6fc3675de9bc39ae71dbd68dfec1a2b";
    flake-utils.url = "flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs_sgx, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [ "openssl-1.1.1w" ];
          overlays = [ (import ./overlay.nix self) ];
        };
      in
        {
          legacyPackages = pkgs;
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ 
              sgx-sdk
              openssl_1_1
              nasm
            ];
            env = with pkgs; {
              SGX_SDK = sgx-sdk;
              SGX_SSL = sgx-ssl;
            };
          };
        }
      )
    // { inherit inputs; };
}
