#!/usr/bin/env zsh

autoload -Uz colors && colors
setopt prompt_subst

# This is based on agnoster. I think it is licensed as MIT?
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
#  local PL_BRANCH_CHAR
  PL_BRANCH_CHAR=''
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
#  local ref dirty mode repo_path
  ref=''
  dirty=''
  mode=''
  repo_path=''

    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      export ZSH_GIT_PROMPT_COLOR="yellow"
    elif [[ -n $(git_prompt_info) ]]; then
      export ZSH_GIT_PROMPT_COLOR="green"
    else
   	  export ZSH_GIT_PROMPT_COLOR=""
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info

   if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    echo -n "%{$bg[$ZSH_GIT_PROMPT_COLOR]%}%{$fg[blue]%}"$'\ue0b0'"%{$fg_bold[white]%} ${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode} %{$reset_color%}%{$fg[$ZSH_GIT_PROMPT_COLOR]%}"$'\ue0b0'
  else
    echo -n "%{$fg[blue]%}"$'\ue0b0'
  fi
}

PROMPT="%{$bg[cyan]%}%{$fg[black]%} "$'\uf303'" %{$reset_color%}%{$fg[cyan]%}%(?.%{$bg[black]%}.%{$bg[red]%})"$'\ue0b0'"%("'!'".%(?.%{$bg[black]%}.%{$bg[red]%})%{$fg_bold[yellow]%} "'!'".)%(?.%{$bg[black]%}%{$fg_bold[green]%} "$'\u2714'" %{$reset_color%}%{$bg[blue]%}%{$fg[black]%}.%{$bg[red]%}%{$fg_bold[yellow]%} "$'\u2718'" %? %{$reset_color%}%{$bg[blue]%}%{$fg[red]%})"$'\ue0b0'"%{$bg[blue]%}%{$fg_bold[white]%} %~ %{$reset_color%}"'$(prompt_git)'"%{$reset_color%} "
RPROMPT="%{$reset_color%}%{$fg[black]%}"$'\ue0b2'"%{$reset_color%}%{$bg[black]%}%{$fg[white]%} %m:%n %{$fg[white]%}"$'\ue0b2'"%{$reset_color%}%{$bg[white]%}%{$fg[black]%} %* %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
