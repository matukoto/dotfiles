{ ... }:

{
  home.file = {
    ".bash_aliases".text = builtins.readFile ../../../bash_aliases;
    ".bashrc".text = builtins.readFile ../../../bashrc;
    ".profile".text = builtins.readFile ../../../profile;
  };
}
