{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.zsh.enable {
    programs.zsh = {
      enableCompletion = true;
      autocd = true;
      enableVteIntegration = true;
      syntaxHighlighting = {
        enable = true;

      };
      autosuggestion.enable = true;
      shellAliases = {
        ll = "ls -laFh";
        la = "ls -A";
        grep = "grep --color=auto";
        diff = "diff --color=auto";
      };
      initExtra = ''
      # pipx
      export PATH="$PATH:/home/notroot/.local/bin"
      eval "$(register-python-argcomplete pipx)"

      # configure key keybindings
      # bindkey -e                                        # emacs key bindings
      bindkey ' ' magic-space                           # do history expansion on space
      bindkey '^U' backward-kill-line                   # ctrl + U
      bindkey '^[[3;5~' kill-word                       # ctrl + Supr
      bindkey '^[[3~' delete-char                       # delete
      bindkey '^[[1;5C' forward-word                    # ctrl + ->
      bindkey '^[[1;5D' backward-word                   # ctrl + <-
      bindkey '^[[5~' beginning-of-buffer-or-history    # page up
      bindkey '^[[6~' end-of-buffer-or-history          # page down
      bindkey '^[[H' beginning-of-line                  # home
      bindkey '^[[F' end-of-line                        # end
      bindkey '^[[Z' undo                               # shift + tab undo last action

      '';
    };
  };
}
