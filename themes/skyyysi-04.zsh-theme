#!/bin/zsh

# Required settings:
autoload -Uz colors && colors
setopt prompt_subst

# The prompt theme:
function precmd_prompt {
if [[ -n $(git_prompt_info) ]]; then
	PROMPT_LENGTH_SKEL="$USER$HOST$(echo ${PWD} | sed "s/\/home\/$USER/\~/g")$(git_prompt_info)-----"
else
	PROMPT_LENGTH_SKEL="$USER$HOST$(echo ${PWD} | sed "s/\/home\/$USER/\~/g")--------------------------"
fi
PROMPT_LENGTH_SKEL_CALCULATED=$(($COLUMNS-${#PROMPT_LENGTH_SKEL}))
PROMPT_RIGHT_SIDE() {
	for f in {0..$PROMPT_LENGTH_SKEL_CALCULATED}; do
		echo -n $'\u2501'
	done
	echo -n " %{$fg_bold[white]%}"'['"%{$fg_bold[yellow]%}%*%{$fg_bold[white]%}"']'"%{$reset_color%} %{$fg_bold[white]%}"$'\u2501'$'\u2513'"%{$reset_color%} "
}
PROMPT=" "$'\u250F'$'\u2501'"%{$fg_bold[white]%}"'['"%{$reset_color%}%("'!'".%{$fg_bold[magenta]%}.%{$fg_bold[cyan]%})%n%{$fg_bold[white]%}@%m:"'$(PWD_IS_WRITABLE)'"%~%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%#%{$fg_bold[white]%}"']'"%{$reset_color%} "'$(git_prompt_info)'"$(PROMPT_RIGHT_SIDE)
 %{$fg_bold[white]%}"$'\u2517'$'\u2501'$'\u25B6'"%{$reset_color%} "
RPROMPT="%{$fg_bold[white]%}"$'\u25C0'$'\u2501'$'\u251B'"%{$reset_color%} "
}

precmd_functions+=(precmd_prompt)
