{ ... }:

{
  home.file = {
    ".bash_aliases".text = builtins.readFile ../../../dot_bash_aliases.tmpl;
    ".bashrc".text = builtins.readFile ../../../dot_bashrc.tmpl;
    ".profile".text = builtins.readFile ../../../dot_profile.tmpl;
  };
}
