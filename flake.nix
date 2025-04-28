{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          meta = {
            name = "dmod";
            title = "Normal Setup";
          };
          namespace = "dmod";
        };
      };
    in

    lib.mkFlake {
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
      ];
      channels-config.allowUnfree = true;
      channels-config.allowUnsupportedSystem = true;
      channels-config.nvidia.acceptLicense = true;
    };
}


