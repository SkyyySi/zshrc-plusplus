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

#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#
# Below are the settings you can savely edit.                                       #
#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#

### Plugins ###
plugins=(
	colorvars
	git
	zsh-autosuggestions
	zsh-history-substring-search
	zsh-syntax-highlighting
)

# Plugin settings
COLORVARS_SHOW_COLOR_TEST_BLOCK=true          # Shows a test block on shell start. It does not matter what you put in there, comment/remove to disable.

ZSH_AUTOSUGGEST_STRATEGY=(history completion) # First look for matches in the history file, then zsh completions.
ZSH_AUTOSUGGEST_COMPLETION_IGNORE="pacman *"  # This will prevent it from loading the entire package database every time you type something like 'pacman -S '.
ZSH_AUTOSUGGEST_USE_ASYNC=true                # Like COLORVARS_..., it does not matter what you put in there, comment/remove to disable.

### Shell theme ###
ZSH_THEME="skyyysi-04"

#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#
# Below are internal settings you should only edit if you know what you're doing.   #
#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#---#

### Some default settings ###

export PATH="${HOME}/.local/bin:${HOME}/bin:${PATH}"
export TERM=xterm-256color
export EDITOR=nano
export BROWSER=firefox

prompt off   # Comment this line if causes an error.
setopt prompt_subst
setopt correct
setopt autocd

### History ###
if [[ ! -w "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history" ]]; then
	 mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/"
	 touch "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
fi

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTZISE=10000000
SAVEHIST=10000000

bindkey "^[[A" history-substring-beginning-search-up
bindkey "^[[B" history-substring-beginning-search-down

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

# Load the specified theme.
  if [[ -z $ZSH_THEME ]]; then
	return
elif [[ $ZSH_THEME = "none" ]]; then
	return
elif [[ -r $HOME/.zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme ]]; then
	source $HOME/.zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme
elif [[ -r $HOME/.zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh ]]; then
	source $HOME/.zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh
elif [[ -r $HOME/.zsh/themes/$ZSH_THEME.zsh-theme ]]; then
	source $HOME/.zsh/themes/$ZSH_THEME.zsh-theme
elif [[ -r $HOME/.zsh/themes/$ZSH_THEME.zsh ]]; then
	source $HOME/.zsh/themes/$ZSH_THEME.zsh
elif [[ -r $HOME/.oh-my-zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme ]]; then
	source $HOME/.oh-my-zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme
elif [[ -r $HOME/.oh-my-zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh ]]; then
	source $HOME/.oh-my-zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh
elif [[ -r $HOME/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme ]]; then
	source $HOME/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme
elif [[ -r $HOME/.oh-my-zsh/themes/$ZSH_THEME.zsh ]]; then
	source $HOME/.oh-my-zsh/themes/$ZSH_THEME.zsh
elif [[ -r /usr/share/zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme ]]; then
	source /usr/share/zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh-theme
elif [[ -r /usr/share/zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh ]]; then
	source /usr/share/zsh/themes/$ZSH_THEME/$ZSH_THEME.zsh
elif [[ -r /usr/share/zsh/themes/$ZSH_THEME.zsh-theme ]]; then
	source /usr/share/zsh/themes/$ZSH_THEME.zsh-theme
elif [[ -r /usr/share/zsh/themes/$ZSH_THEME.zsh ]]; then
	source /usr/share/zsh/themes/$ZSH_THEME.zsh
elif [[ -r /usr/share/zsh-theme-powerlevel10k/$ZSH_THEME.zsh-theme ]]; then
	source /usr/share/zsh-theme-powerlevel10k/$ZSH_THEME.zsh-theme
else
	### Default prompt ###
	
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
	
	# Draw the prompt.
	PROMPT="%("'!'".%{$fg_bold[magenta]%}.%{$fg_bold[cyan]%})%n%{$fg_bold[white]%}@%m:"'$(PWD_IS_WRITABLE)'"%~%(?.%{$fg_bold[green]%}.%{$fg_bold[red]%})%#%{$reset_color%} "'$(git_prompt_info)'"%{$reset_color%}"
	
	ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[cyan]%}["
	ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
fi
