#!/bin/zsh

# Black + dark gray
COLOR_FG_BLACK="\e[30m"
COLOR_FG_DARK_GRAY="\e[90m"

COLOR_BG_BLACK="\e[40m"
COLOR_BG_DARK_GRAY="\e[100m"

# Red
COLOR_FG_DARK_RED="\e[31m"
COLOR_FG_LIGHT_RED="\e[91m"

COLOR_BG_DARK_RED="\e[41m"
COLOR_BG_LIGHT_RED="\e[101m"

# Green
COLOR_FG_DARK_GREEN="\e[32m"
COLOR_FG_LIGHT_GREEN="\e[92m"

COLOR_BG_DARK_GREEN="\e[42m"
COLOR_BG_LIGHT_GREEN="\e[102m"

# Yellow/dark orange + (light) yellow
COLOR_FG_DARK_YELLOW="\e[33m"
COLOR_FG_LIGHT_YELLOW="\e[93m"

COLOR_BG_DARK_YELLOW="\e[43m"
COLOR_BG_LIGHT_YELLOW="\e[103m"

# Blue
COLOR_FG_DARK_BLUE="\e[34m"
COLOR_FG_LIGHT_BLUE="\e[94m"

COLOR_BG_DARK_BLUE="\e[44m"
COLOR_BG_LIGHT_BLUE="\e[104m"

# Magenta
COLOR_FG_DARK_MAGENTA="\e[35m"
COLOR_FG_LIGHT_MAGENTA="\e[95m"

COLOR_BG_DARK_MAGENTA="\e[45m"
COLOR_BG_LIGHT_MAGENTA="\e[105m"

# Cyan
COLOR_FG_DARK_CYAN="\e[36m"
COLOR_FG_LIGHT_CYAN="\e[96m"

COLOR_BG_DARK_CYAN="\e[46m"
COLOR_BG_LIGHT_CYAN="\e[106m"

# Light gray + white
COLOR_FG_LIGTH_GRAY="\e[37m"
COLOR_FG_WHITE="\e[97m"

COLOR_BG_LIGTH_GRAY="\e[47m"
COLOR_BG_WHITE="\e[107m"

# No color
COLOR_RESET="\e[0m"

colortest() {
	echo " "$'\u250F'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2513'
	echo " "$'\u2503'" $COLOR_BG_BLACK          $COLOR_FG_DARK_RED"'C'"$COLOR_FG_DARK_GREEN"'o'"$COLOR_FG_DARK_YELLOW"'l'"$COLOR_FG_DARK_BLUE"'o'"$COLOR_FG_LIGHT_MAGENTA"'r'" $COLOR_RESET$COLOR_BG_WHITE$COLOR_FG_BLACK"' Vars'"           $COLOR_RESET "$'\u2503'
	echo " "$'\u2523'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u252B'
	echo " "$'\u2503'" $COLOR_BG_BLACK    $COLOR_BG_DARK_RED    $COLOR_BG_DARK_GREEN    $COLOR_BG_DARK_YELLOW    $COLOR_BG_DARK_BLUE    $COLOR_BG_DARK_MAGENTA    $COLOR_BG_DARK_CYAN    $COLOR_BG_LIGTH_GRAY    $COLOR_RESET "$'\u2503'
	echo " "$'\u2503'" $COLOR_BG_DARK_GRAY    $COLOR_BG_LIGHT_RED    $COLOR_BG_LIGHT_GREEN    $COLOR_BG_LIGHT_YELLOW    $COLOR_BG_LIGHT_BLUE    $COLOR_BG_LIGHT_MAGENTA    $COLOR_BG_LIGHT_CYAN    $COLOR_BG_WHITE    $COLOR_RESET "$'\u2503'
	echo " "$'\u2523'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u252B'
	echo " "$'\u2503'" $COLOR_BG_BLACK        $COLOR_BG_DARK_GRAY        $COLOR_BG_LIGTH_GRAY        $COLOR_BG_WHITE        $COLOR_RESET "$'\u2503'
	echo " "$'\u2517'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u2501'$'\u251B'
}

# Show a test pattern when launching
if [[ -n "$COLORVARS_SHOW_COLOR_TEST_BLOCK" ]]; then
	colortest
fi
