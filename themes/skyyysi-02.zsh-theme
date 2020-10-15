#!/bin/zsh

autoload -Uz colors && colors
setopt PROMPT_SUBST

function PATH_COLOR() {
	if [ -w "${PWD}" ]; then
		echo "%{$fg_bold[green]%}";
	elif [ "$EUID" = "0" ]; then
		echo "%{$fg_bold[magenta]%}";
	else
		echo "%{$fg_bold[red]%}";
	fi
}

PROMPT='$(PATH_COLOR)%~%{$reset_color%} $(git_prompt_info)%(?.%{$fg_bold[blue]%}.%{$fg_bold[red]%})%(!.#.$)%{$reset_color%} '
PROMPT2='%(!.%{$fg_bold[red]%}.%{$fg_bold[cyan]%})>%{$reset_color%}'
RPROMPT='%(?.. %{$fg_bold[red]%}-[%?]-%{$reset_color%} )'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
