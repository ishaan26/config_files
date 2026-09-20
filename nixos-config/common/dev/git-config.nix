{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ishaan Goel";
        email = "ishaangoel.99@gmail.com";
      };

      alias = {
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

      core = {
        pager = "delta";
        editor = "nvim";
      };

      ui = {color = "auto";};
      color = {ui = true;};

      merge = {
        # nvimdiff is git's built-in name for "nvim -d"
        tool = "nvimdiff";
        conflictstyle = "zdiff3";
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

      interactive = {diffFilter = "delta --color-only";};
      pager = {
        diff = "delta";
        log = "delta";
        reflog = "delta";
        show = "delta";
      };
      init = {defaultBranch = "main";};
      pull = {ff = "only";};
      push = {autoSetupRemote = true;};
      fetch = {prune = true;};
      rebase = {autoStash = true;};
      diff = {colorMoved = "default";};
      gpg = {program = "${pkgs.gnupg}/bin/gpg";};
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };

    signing = {
      key = "0E6951900DED125D";
      signByDefault = true;
    };
  };

  home.packages = with pkgs; [delta git-lfs];
}
