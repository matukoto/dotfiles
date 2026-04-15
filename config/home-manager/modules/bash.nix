{ ... }:

{
  home.file = {
    ".bash_aliases".text = builtins.readFile ../../../home/bash_aliases;
    ".bashrc".text = builtins.readFile ../../../home/bashrc;
    ".profile".text = builtins.readFile ../../../home/profile;
  };
}
