stty -ixon

setopt autocd
setopt prompt_subst
set -B

source ~/Repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls="lsd -1A --group-dirs first"
alias sl="lsd -1A --group-dirs first"
alias l="lsd -1A --group-dirs first"
alias ka="killall"
alias gs="git status"
alias gd="git diff"
alias clone="git clone"
alias v="nvim"
alias sudo="sudo "

bindkey -v "^?" backward-delete-char

KEYTIMEOUT=5

zle-keymap-select() {
	([[ ${KEYMAP} == vicmd ]] \
		|| [[ $1 = 'block' ]] \
		&& printf '\e[1 q'
	) || ([[ ${KEYMAP} == main ]] \
		|| [[ ${KEYMAP} == viins ]] \
		|| [[ ${KEYMAP} = '' ]] \
		|| [[ $1 = 'beam' ]] \
		&& printf '\e[5 q')
}
zle -N zle-keymap-select

lazygit() {
	git add .
	git commit -m "$@"
	git push
}

[ "$TERM" = "linux" ] \
	&& PS1=$'$(zle-keymap-select)\e[1m%~ \e[92m>\e[0m ' \
	|| PS1=$'$(zle-keymap-select)\e[1m%~ \e[92m❯\e[0m '

cat ~/.config/TODO

[ -z $DISPLAY ] \
	&& [ $(tty) = /dev/tty1 ] \
	&& startx 2>/dev/null>/dev/null
