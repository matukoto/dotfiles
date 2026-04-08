{ pkgs, ... }:

let
  gpgAgentTemplate = builtins.readFile ../../../dot_gnupg/gpg-agent.conf.tmpl;
  pinentryProgram =
    if pkgs.stdenv.isDarwin then "/opt/homebrew/bin/pinentry-mac" else "/usr/bin/pinentry-gtk-2";
  gpgAgentConfig = builtins.replaceStrings
    [
      "{{ if eq .chezmoi.os \"darwin\" -}}"
      "pinentry-program /opt/homebrew/bin/pinentry-mac"
      "{{- else -}}"
      "pinentry-program /usr/bin/pinentry-gtk-2"
      "{{- end }}"
    ]
    [
      ""
      "pinentry-program ${pinentryProgram}"
      ""
      ""
      ""
    ]
    gpgAgentTemplate;
in
{
  home.file = {
    ".gnupg/gpg-agent.conf".text = gpgAgentConfig;
    ".gnupg/gpg.conf".source = ../../../dot_gnupg/gpg.conf;
  };
}
