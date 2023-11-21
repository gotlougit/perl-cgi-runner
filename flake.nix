{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        name = "cgi-runner-devshell";
        buildInputs = with pkgs; [
          perlnavigator
          perl536
          perl536Packages.CGI
          perl536Packages.HTTPServerSimple
        ];
      };
    };
}

