self:

final: prev:
let
  pkgs_sgx = import self.inputs.nixpkgs_sgx { inherit (final) system; };
in
{
  inherit (pkgs_sgx) sgx-sdk sgx-ssl sgx-psw;

  zerotrace = final.callPackage ./package.nix {
    openssl = final.openssl_1_1;
  };
}
