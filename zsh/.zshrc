stty -ixon

set -J -B

source ~/Repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
autoload -Uz compinit && compinit -i

alias ls='lsd -1A --group-dirs first'
alias sl='lsd -1A --group-dirs first'
alias l='lsd -1A --group-dirs first'
alias ka='killall'
alias gs='git status'
alias gd='git diff'
alias clone='git clone'
alias v='nvim'
alias sudo='sudo '

alias maek='make'; alias mkae='make'; alias mkea='make'; alias meak='make';
alias meka='make'; alias amke='make'; alias amek='make'; alias akme='make';
alias akem='make'; alias aemk='make'; alias aekm='make'; alias kmae='make';
alias kmea='make'; alias kame='make'; alias kaem='make'; alias kema='make';
alias keam='make'; alias emak='make'; alias emka='make'; alias eamk='make';
alias eakm='make'; alias ekma='make'; alias ekam='make';

bindkey -v '^?' backward-delete-char

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

lazygit() {
	git add .
	git commit -m "$@"
	git push
}

PS1='%F{black}%K{blue} %~ %F{blue}%k%f%k '

[ -z $DISPLAY ] \
	&& [ $(tty) = /dev/tty1 ] \
	&& (clear; startx 2>/dev/null>/dev/null)
