{ lib, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  programs.git = {
    enable = true;
    package = pkgs.gitMinimal;
    signing = {
      key = "C8BD39A98C2BCF31";
      signByDefault = isDarwin;
    };
    settings = {
      user = {
        email = "matukotoo@gmail.com";
        name = "MATSUMOTO Keisuke";
      };
      alias = {
        pushf = "push --force-with-lease --force-if-includes";
        mru = "!git log -g -n 1000 --format=\"%gd %gs\" --date=relative HEAD@{now} | grep checkout | grep \" to\" | sed 's/HEAD@{\\(.*\\)}.* to\\(.*\\)/(\\1)\\t\\2/' | awk -v OFS=' ' '!x[$NF]++' | head -n 15 | column -ts $'\\t' -R 1";
        gpn = "!f() { git push origin HEAD:refs/heads/$1; }; f";
      };
      fetch.prune = true;
      tag.gpgsign = isDarwin;
      commit = {
        template = "~/.config/vim/gitmessage";
        verbose = true;
      };
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        pager = "delta";
        commentChar = ";";
        quotepath = false;
        eol = "lf";
        autocrlf = "input";
      };
      pull.merge = "ff-only";
      push = {
        autoSetupRemote = true;
        useForceIfIncludes = true;
      };
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
      log.date = "format:%Y/%m/%d (%a) %H:%M:%S";
      rebase.autostash = true;
      interactive.diffFilter = "delta --color-only --features=interactive";
      delta = {
        "max-line-length" = 0;
        "line-numbers" = true;
        "side-by-side" = true;
      };
      "delta \"decorations\"" = {
        "commit-decoration-style" = "bold yellow box ul";
        "file-style" = "bold yellow ul";
        "file-decoration-style" = "none";
      };
      diff = {
        algorithm = "histogram";
        indentHeuristic = true;
      };
      column.ui = "auto";
      branch.sort = "-committerdate";
      rerere.enabled = true;
      ghq.root = "~/work";
      "credential \"https://github.com\"".helper = "!gh auth git-credential";
      "credential \"https://gist.github.com\"".helper = "!gh auth git-credential";
    }
    // lib.optionalAttrs isDarwin {
      gpg.program = "${pkgs.gnupg}/bin/gpg";
    };
  };

  xdg.configFile."git/ignore".source = ../../git/ignore;
}
