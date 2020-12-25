stty -ixon

set -J -B

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls='ls -1Av --color=auto' sl='ls' l='ls'
alias ka='killall'
alias gs='git status'
alias gd='git diff'
alias gg='git grep'
alias nvim='nvim -p' v='nvim'
alias sudo='sudo '
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias cbr='cargo build --release'
alias c='cargo'

alias maek='make' mkae='make' mkea='make' meak='make' meka='make' amke='make' \
	amek='make' akme='make' akem='make' aemk='make' aekm='make' kmae='make' \
	kmea='make' kame='make' kaem='make' kema='make' keam='make' emak='make' \
	emka='make' eamk='make' eakm='make' ekma='make' ekam='make'

bindkey -v '^?' backward-delete-char '^[[P' delete-char

KEYTIMEOUT=5

zle-keymap-select() {
	{[ "$KEYMAP" = vicmd ] \
		|| [ "$1" = block ] \
		&& printf '\e[1 q'
	} || {[ "$KEYMAP" = main ] \
		|| [ "$KEYMAP" = viins ] \
		|| [ "$KEYMAP" = '' ] \
		|| [ "$1" = beam ] \
		&& printf '\e[5 q'}
}
zle -N zle-keymap-select

precmd() {
	printf '\e[5 q'
}

PS1='%F{black}%K{blue} %~ %F{blue}%k%f%k '

[ -z $DISPLAY ] \
	&& [ $(tty) = /dev/tty1 ] \
	&& exec startx
