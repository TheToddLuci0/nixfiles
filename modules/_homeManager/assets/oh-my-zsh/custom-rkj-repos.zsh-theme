# user, host, full path, and time/date on two lines for easier vgrepping

# https://gist.github.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e
# nix-shell: currently running nix-shell
prompt_nix_shell() {
  if [[ -n "$IN_NIX_SHELL" ]]; then
    if [[ -n $NIX_SHELL_PACKAGES ]]; then
      local package_names=""
      local packages=($NIX_SHELL_PACKAGES)
      if [[ "${#files[@]}" -eq "1" ]]; then
        echo "%{$fg_bold[cyan]%}{$packages}%{$reset_color%}"
      else
        for package in $packages; do
          package_names+="${package##*.}"
        done
        echo "%{$fg_bold[cyan]%}{$package_names}%{$reset_color%} "
      fi
    elif [[ -n $name ]]; then
      local cleanName=${name#interactive-}
      cleanName=${cleanName#lorri-keep-env-hack-}
      cleanName=${cleanName%-environment}
      echo "%{$fg_bold[cyan]%}{$cleanName }%{$reset_color%} "
    else # This case is only reached if the nix-shell plugin isn't installed or failed in some way
      echo "%{$fg_bold[cyan]%}{ }%{$reset_color%} "
    fi
  fi
}


function hg_prompt_info {
  if (( $+commands[hg] )) && [[ -e ~/.hgrc ]] && grep -q "prompt" ~/.hgrc; then
    hg prompt --angle-brackets "\
<hg:%{$fg[magenta]%}<branch>%{$reset_color%}><:%{$fg[magenta]%}<bookmark>%{$reset_color%}>\
</%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
  fi
}

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✱"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}✈"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_prompt_short_sha)$(git_prompt_status)%{$fg_bold[blue]%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function retcode() {}

# alternate prompt with git & hg
PROMPT=$'%{$fg_bold[blue]%}┌─[%{$fg_bold[green]%}%n%b%{$fg[black]%}@%{$fg[cyan]%}%m%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%{$fg_bold[default]%}%~%{$fg_bold[blue]%}]%{$reset_color%} - %{$fg_bold[blue]%}[%b%{$fg[yellow]%}'%D{"%Y-%m-%d %I:%M:%S"}%b$'%{$fg_bold[blue]%}]
%{$fg_bold[blue]%}└─[%{$fg_bold[magenta]%}%?$(retcode)%{$fg_bold[blue]%}] $(prompt_nix_shell)%{$fg_bold[blue]%}<$(mygit)$(hg_prompt_info)>%{$reset_color%} '
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
