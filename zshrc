#!/bin/zsh
# Please note: This zshrc was made to be used alongside grml's zsh config.
# On arch, you can install it with 'sudo pacman -S grml-zsh-config'.
# It will still work without it, but then you may want to configure
# stuff like the tab completion. If you do choose to use grml's config,
# put this zshrc into ~/.zshrc.local or (even better actually) /etc/zsh/zshrc.local
# since the default will be overwritten by grml's zshrc (of course it won't touch your
# existing zshrc). If you install it in user mode, concider creating a symbolic link
# (via 'ln -s /path/to/zshrc/zshrc ~/.zshrc' (or '~/.zshrc.local') ) so that you can simply
# update it by cd-ing into the downloaded folder and typing 'git pull'.

### Plugins ###
plugins=(
	colorvars
	git
	zsh-autosuggestions
	zsh-history-substring-search
	zsh-syntax-highlighting
)

### Some default settings ###

COLORVARS_SHOW_COLOR_TEST_BLOCK=true

export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
export TERM=xterm-256color
export EDITOR=nano
export BROWSER=firefox

#autoload -Uz promptinit && promptinit   # Uncomment this line if 'prompt off' causes an error.

prompt off
setopt prompt_subst
setopt correct
setopt autocd

### Key bindings ###
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

### External plugins & settings ###

source "$HOME/.zsh/lib/git.zsh"

emulate bash -c 'source /etc/profile'

### Aliases ###

# Replace ls with exa.
alias ls='exa'
alias la='exa -a'
alias ll='exa -al --group-directories-first'
alias l='exa   -l --group-directories-first'

# Color is nice. I like color.
alias grep='grep   --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias vdir='vdir   --color=auto'
alias watch='watch --color'
alias ip='ip -c'

# These can save you a lot of headace.
alias cp='cp       -iv'
alias rm='rm       -iv'
alias mkdir='mkdir -pv'

# These are just quiet useful.
alias pico='nano   -p' # Seems to be quiet common so I just added it.
alias cd..='cd ..'     # This one will save you litterally on space.
alias sudo="sudo "     # Makes sudo load /etc/profile.d .

function noout {
	nohup "$@" &> /dev/null &
}

# Only alis if not root.
if [[ ! "$EUID" = '0' ]]; then
	alias pacman='sudo pacman'
	alias systemctl='sudo systemctl'
	alias userctl='/usr/bin/systemctl --user'
fi

### Simple plugin loader ###

# Load the git library.
for l in  $HOME/.zsh/lib/*.zsh; do
	if [[ -r $l ]]; then
		source $l
	fi
done

# Load all plugins.
for p in $plugins; do
	  if [[ -r $HOME/.zsh/plugins/$p/$p.plugin.zsh ]]; then
		source $HOME/.zsh/plugins/$p/$p.plugin.zsh
	elif [[ -r $HOME/.zsh/plugins/$p/$p.zsh ]]; then
		source $HOME/.zsh/plugins/$p/$p.zsh
	elif [[ -r $HOME/.zsh/plugins/$p.plugin.zsh ]]; then
		source $HOME/.zsh/plugins/$p.plugin.zsh
	elif [[ -r $HOME/.zsh/plugins/$p.zsh ]]; then
		source $HOME/.zsh/plugins/$p.zsh
	elif [[ -r $HOME/.oh-my-zsh/plugins/$p/$p.plugin.zsh ]]; then
		source $HOME/.oh-my-zsh/plugins/$p/$p.plugin.zsh
	elif [[ -r $HOME/.oh-my-zsh/plugins/$p/$p.zsh ]]; then
		source $HOME/.oh-my-zsh/plugins/$p/$p.zsh
	elif [[ -r $HOME/.oh-my-zsh/plugins/$p.plugin.zsh ]]; then
		source $HOME/.oh-my-zsh/plugins/$p.plugin.zsh
	elif [[ -r $HOME/.oh-my-zsh/plugins/$p.zsh ]]; then
		source $HOME/.oh-my-zsh/plugins/$p.zsh
	elif [[ -r /usr/share/zsh/plugins/$p/$p.plugin.zsh ]]; then
		source /usr/share/zsh/plugins/$p/$p.plugin.zsh
	elif [[ -r /usr/share/zsh/plugins/$p/$p.zsh ]]; then
		source /usr/share/zsh/plugins/$p/$p.zsh
	elif [[ -r /usr/share/zsh/plugins/$p.plugin.zsh ]]; then
		source /usr/share/zsh/plugins/$p.plugin.zsh
	elif [[ -r /usr/share/zsh/plugins/$p.zsh ]]; then
		source /usr/share/zsh/plugins/$p.zsh
	fi
done

### Prompt ###

# Enable colored output
autoload -Uz colors && colors

# Color the prompt path diffrently based on if you 
# have write acces the the current directory or not.
function PWD_IS_WRITABLE {
	if [[ -w "${PWD}" ]]; then
		echo -n "%{$fg_bold[blue]%}"
	else
		echo -n "%{$fg_bold[yellow]%}"
	fi
}

# Dram the prompt. It's bad and slow.
# I recommend using powerlevel10k which is
# both easyer to customize and it is also faster.
function precmd_prompt {
PROMPT_LENGTH_SKEL="$USER$HOST$(echo ${PWD} | sed "s/\/home\/$USER/\~/g")$(git_prompt_info)-------------------------"
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

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
