{ pkgs, ... }:

let
  pinentryProgram =
    if pkgs.stdenv.isDarwin then "/opt/homebrew/bin/pinentry-mac" else "/usr/bin/pinentry-gtk-2";

  gpgAgentConfig = ''
    default-cache-ttl 43200
    max-cache-ttl 43200
    pinentry-program ${pinentryProgram}
  '';

  gpgConfig = ''
    use-agent
  '';
in
{
  home.file = {
    ".gnupg/gpg-agent.conf".text = gpgAgentConfig;
    ".gnupg/gpg.conf".text = gpgConfig;
  };
}
