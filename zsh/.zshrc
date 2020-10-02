stty -ixon

set -J -B

source ~/Repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls='lsd -lA --blocks=size,name' sl='ls' l='ls'
alias ka='killall'
alias gs='git status'
alias gd='git diff'
alias gg='git grep'
alias clone='git clone'
alias v='nvim -p'
alias sudo='sudo '
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias cbr='cargo build --release'

alias maek='make' mkae='make' mkea='make' meak='make' meka='make' amke='make' \
	amek='make' akme='make' akem='make' aemk='make' aekm='make' kmae='make' \
	kmea='make' kame='make' kaem='make' kema='make' keam='make' emak='make' \
	emka='make' eamk='make' eakm='make' ekma='make' ekam='make'

bindkey -v '^?' backward-delete-char '^[[P' delete-char

KEYTIMEOUT=5

zle-keymap-select() {
	([ "$KEYMAP" = vicmd ] \
		|| [ "$1" = block ] \
		&& printf '\e[1 q'
	) || ([ "$KEYMAP" = main ] \
		|| [ "$KEYMAP" = viins ] \
		|| [ "$KEYMAP" = '' ] \
		|| [ "$1" = beam ] \
		&& printf '\e[5 q')
}
zle -N zle-keymap-select

precmd() {
	printf '\e[5 q'
}

lazygit() {
	git add .
	git commit -m "$@"
	git push
}

PS1='%F{black}%K{blue} %~ %F{blue}%k%f%k '

[ -z $DISPLAY ] \
	&& [ $(tty) = /dev/tty1 ] \
	&& exec startx 2>/dev/null>/dev/null
