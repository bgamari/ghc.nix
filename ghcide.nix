{ bootghc, fetchurl, fetchFromGitHub, haskell }:

let
  hspkgs = haskell.packages."${bootghc}".override {
    all-cabal-hashes =
      fetchurl {
        url = "https://github.com/commercialhaskell/all-cabal-hashes/archive/ed8c39bc9792484fa0ca0bf3e59dd5f5e001b06c.tar.gz";
        sha256 = "10vy23y5x8551jpbq9318mgiq72m6cy7f4mzpy3j0rnfiqijn9rx";
      };

    overrides = self: super: {
      lsp-test =
        let
          src = fetchFromGitHub {
            owner = "bubba";
            repo = "lsp-test";
            rev = "edd69eeb0b5b055ccbb0e4e1a6035f6cd9aaa551";
            sha256 = "0fp8acmx694cqhn9q749w7dbnsic8swzrlcwli2dl2c6axswyp8q";
          };
        in self.callCabal2nix "lst-test" src {};

      opentelemetry =
        let
          src = fetchFromGitHub {
            owner = "ethercrow";
            repo = "opentelemetry-haskell";
            rev = "49ac6796d908d74d484bec072e84584c6442171f";
            sha256 = "0nz507v4k7ksqniqz3hqf3b6bc4kp7ak0wck8r60sa55g1hmb3vq";
          };
        in self.callCabal2nix "opentelemetry" "${src}/opentelemetry" {};

      ghc-check = 
        let
          src = fetchFromGitHub {
            owner = "pepeiborra";
            repo = "ghc-check";
            rev = "ed1ab54eaab3530a30431d50ea1c7af07d8832cd";
            sha256 = "06r22xa50rc0whagg8x0s7g1q66bap1djfl9aavwrkmmi7kpf0xk";
          };
        in self.callCabal2nix "ghc-check" src {};

      hslogger =
        let
          src = fetchFromGitHub {
            owner = "haskell-hvr";
            repo = "hslogger";
            rev = "4c3ca34ea91fc00774a505d8d2a2aca8ece7a76c";
            sha256 = "116sh32zkl139ihams6ab0bigiqpppaajx4mzhxvllqcrypk64rq";
          };
        in self.callCabal2nix "hslogger" src {};

      ghcide =
        let
          src = fetchFromGitHub {
            owner = "mpickering";
            repo = "ghcide";
            rev = "886a9cd7ca31fdc8d012daed0b7e79df4f233bd4";
            #branchName = "hls";
            sha256 = "10r1xb5nhl08895xvydmdyhpcvlk2b03xnbv51pd6pq8f52c9zdf";
          };
        in self.callCabal2nix "ghcide" src {};

      ghc-typelits-natnormalise = self.callHackage "ghc-typelits-natnormalise" "0.7.2" {};
      ghc-tcplugins-extra = self.callHackage "ghc-tcplugins-extra" "0.4" {};
    };
  };
in hspkgs.ghcide

