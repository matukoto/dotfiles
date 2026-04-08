{ ... }:

let
  bashAliases = builtins.replaceStrings
    [
      "alias dot='chezmoi cd'"
    ]
    [
      "alias dot='cd $HOME/.local/share/chezmoi'"
    ]
    (builtins.readFile ../../../dot_bash_aliases.tmpl);
in
{
  home.file = {
    ".bash_aliases".text = bashAliases;
    ".bashrc".text = builtins.readFile ../../../dot_bashrc.tmpl;
    ".profile".text = builtins.readFile ../../../dot_profile.tmpl;
  };
}
