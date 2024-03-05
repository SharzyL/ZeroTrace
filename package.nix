{ lib
, stdenv
, sgx-sdk
, sgx-ssl
, sgx-psw
, openssl
, nasm
}:

let
  app = stdenv.mkDerivation {
    name = "zerotrace";

    buildInputs = [
      sgx-sdk
      sgx-ssl
      openssl
      nasm
    ];
    env = {
      SGX_SDK = sgx-sdk;
      SGX_SSL = sgx-ssl;
    };

    src = lib.fileset.toSource {
      root = ./.;
      fileset = lib.fileset.unions [
        ./exec_zt.sh
        ./exec_zt_ls.sh
        ./Sample_App
        ./ZT_Enclave
        ./ZT_Untrusted
        ./CONFIG.h
        ./CONFIG_FLAGS.h
        ./Globals.hpp
        ./Makefile
      ];
    };

    enableParallelBuilding = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/{bin,lib}
      cp Sample_App/libZT.so $out/lib
      cp Sample_App/{hsoramclient,lsclient,sampleapp,testcorrectness} $out/bin
      patchelf $out/bin/{hsoramclient,lsclient,sampleapp,testcorrectness} \
        --replace-needed libZT.so $out/lib/libZT.so \
        --replace-needed libsgx_urts.so.2 ${sgx-psw}/lib/libsgx_urts.so.2

      readelf -d $out/bin/hsoramclient

      runHook postInstall
    '';
  };

in
{
  inherit app;
}



