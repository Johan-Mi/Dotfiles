stty -ixon

set -J -B -g

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls='ls -1Av --color=auto' sl='ls' l='ls'
alias ka='killall'
alias gs='git status' gd='git diff' gds='git diff --stat' gdst='git diff --staged' gg='git grep' gc='git checkout' gcs='git clone --depth=1'
alias nvim='nvim -p'
alias v='hx'
alias sudo='sudo '
alias doas='doas '
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias cbr='cargo build --release'
alias c='cargo'
alias pac='pacman'
alias emerge='emerge -av' em='emerge'
alias eq='equery' eu='euse' pq='portageq'
alias info='info --vi-keys'
alias clippy!='cargo clippy -- -W clippy::nursery -W clippy::pedantic'
alias objdump='objdump -dCMintel --disassembler-color=color --visualize-jumps=color'

alias maek='make' mkae='make' mkea='make' meak='make' meka='make' amke='make' \
	amek='make' akme='make' akem='make' aemk='make' aekm='make' kmae='make' \
	kmea='make' kame='make' kaem='make' kema='make' keam='make' emak='make' \
	emka='make' eamk='make' eakm='make' ekma='make' ekam='make'

bindkey -v '^?' backward-delete-char '^[[P' delete-char '^H' backward-delete-char '^W' backward-delete-word '^U' backward-kill-line
bindkey -s '^z' '^[ddi fg^m ^m^l'
bindkey -s '^a' '^[ddicd ~/Repos/'
bindkey '^r' history-incremental-search-backward

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -z $DISPLAY ] \
	&& [ $(tty) = /dev/tty1 ] \
	&& exec startx
