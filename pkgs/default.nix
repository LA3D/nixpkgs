{
  perSystem = {pkgs, ...}: {
    overlayAttrs = {
      pythonPackagesExtensions =
        pkgs.pythonPackagesExtensions
        ++ [
          (pself: _: {
            libsimba = pself.callPackage ./libsimba/package.nix {};
          })
        ];
    };
  };
}
