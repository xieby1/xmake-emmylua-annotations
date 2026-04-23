let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  name = "xmake-emmylua-annotations";
  XMAKE_SOURCE = pkgs.xmake.src;
  EMMYLUA_LS_SOURCE = pkgs.emmylua-ls.src;
}
