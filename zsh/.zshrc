stty -ixon

setopt autocd
setopt prompt_subst

source ~/Repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls="lsd -1A"
alias l="lsd -1A"
alias ka="killall"
alias gs="git status"
alias clone="git clone"
alias v="nvim"
alias sudo="sudo "

bindkey -v '^?' backward-delete-char

KEYTIMEOUT=5

zle-keymap-select() {
	if [[ ${KEYMAP} == vicmd ]] \
		|| [[ $1 = 'block' ]]; then
		printf '\e[1 q'
	elif [[ ${KEYMAP} == main ]] \
		|| [[ ${KEYMAP} == viins ]] \
		|| [[ ${KEYMAP} = '' ]] \
		|| [[ $1 = 'beam' ]]; then
		printf '\e[5 q'
	fi
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

[ -z $DISPLAY ] && [ $(tty) = /dev/tty1 ] && startx
