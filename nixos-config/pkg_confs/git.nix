{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ishaan Goel";
    userEmail = "ishaangoel.99@gmail.com";

    signing = {
      key = "0E6951900DED125D";
      signByDefault = true;
    };

    extraConfig = {
      core = {
        pager = "delta";
        editor = "nvim";
      };
      ui.color = "always";
      color.ui = true;
      merge = {
        tool = "nvim -d";
        conflictstyle = "diff3";
      };
      delta = {
        features = "line-numbers decorations";
        syntax-theme = "OneHalfDark";
        line-numbers = true;
        plus-style = ''syntax "#146329"'';
        minus-style = ''syntax "#3f0001"'';
      };
      "delta \"decorations\"" = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow";
        file-decoration-style = "box";
        hunk-header-decoration-style = "cyan ul";
        hunk-header-file-style = "cyan";
        hunk-header-line-number-style = "cyan";
        hunk-header-style = "line-number syntax";
      };
      "delta \"line-numbers\"" = {
        line-numbers = true;
        line-number-minus-style = "124";
        line-numbers-plus-style = "28";
        line-numbers-zero-style = ''"#444444"'';
        line-numbers-left-format = ''"{nm:>4}┊"'';
        line-numbers-right-format = ''"{np:>4}│"'';
        line-numbers-left-style = "cyan";
        line-numbers-right-style = "cyan";
      };
      interactive = { diffFilter = "delta --color-only"; };
      init = { defaultBranch = "main"; };
      github = { user = "ishaan26"; };
      pull = { ff = "only"; };
      gpg = { program = "${pkgs.gnupg}/bin/gpg"; };
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };

    aliases = {
      st = "status -sb";
      history = "log --oneline --graph --decorate --all";
      last = "log -1 HEAD --stat";
      cm = "commit -m";
      c = "commit";
      rv = "remote -v";
      chm = "checkout main";
      chu = "checkout updates";
      chun = "checkout -b updates";
      lb = "branch -a";
      bd = "branch --delete";
      forgot = "!git add . && git commit --amend --no-edit";
    };
  };

  home.packages = with pkgs; [ delta git-lfs ];
}
