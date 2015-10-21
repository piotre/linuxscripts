# /etc/zsh/zshenv: system-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

if [[ -z "$PATH" || "$PATH" == "/bin:/usr/bin" ]]
then
	export PATH="/usr/local/bin:/usr/bin:/bin:/usr/games"
fi
export LC_ALL=fr_FR.UTF-8
export LANG=fr_FR.UTF-8

export PATH=$PATH
PS1='%m:%~%# '
MAILCHECK=300
HISTFILE=$HOME/.bash_history
HISTSIZE=20000
SAVEHIST=2500
DIRSTACKSIZE=30
export EDITOR=/usr/bin/vim
eval $(dircolors --sh)
setopt autolist list_ambiguous hist_ignore_all_dups autocd pushd_ignore_dups
setopt correct auto_pushd append_history
setopt list_types auto_remove_slash auto_param_slash extended_glob nobeep
setopt completeinword alwaystoend always_last_prompt multios hist_reduce_blanks
setopt RM_STAR_WAIT NOCLOBBER
bindkey -e
# bindkey ' ' magic-space
bindkey -s "^[[11~" "dirs -v^M"
bindkey -s "^[[[B" "^Uloadkeys us^M^Y"
bindkey -s "^[[[C" "^Uloadkeys cf^M^Y"
bindkey -s "^[[21~" "^Uwba^M^Y"
bindkey -s "^[[23~" "^U/usr/bin/pon^M^Y"
bindkey -s "^[[24~" "^U/usr/bin/poff^M^Y"
# bindkey -s "é" "^Uxmodmap /usr/lib/kbd/keytables/us.xmap &^M"
#
# bindkey '^[[D' backward-word
# bindkey '^[[C' forward-word
bindkey '^[[32$' backward-word
bindkey '^[[33$' forward-word
bindkey '^[[8~' end-of-line
bindkey '^[[7~' beginning-of-line
bindkey '^[[3~' delete-char
# bindkey '^[p' history-beginning-search-backward
bindkey '^[n' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward

################################################# common serveur ows

alias vz='vim /etc/zsh/zshenv;source /etc/zsh/zshenv'
alias cp='cp -iv'
alias rm='rm -i'
alias lf='less +F '
alias apa2='cd /etc/apache2'
alias ls='ls --color=auto -F'
alias la='ls -alF'
alias ag='apt-get'
alias agi='apt-get install'
alias agu='apt-get update'
alias agr='apt-get upgrade'
alias ftp='ftp -i'
alias l='ls -la -F -h'
alias gz='gzip -9v'
alias v='vim'
alias wh=whois
alias tx='tar -xvvzf'
alias tz='tar -cvvzf'
alias mv='mv -vi'
alias dp='dpkg'
alias fn='find . -name '
###### git
alias gpush='git push'
alias gpull='git pull'
alias gst='git status'
alias gc='git commit -a -m'
alias gmm='git merge master'
alias gcp='git checkout prod'
alias gcm='git checkout master'
alias gb='git branch'
alias gpulla='pushd . && cd $(git rev-parse --show-toplevel) && git pull --recurse-submodules && git fetch --tags && git submodule update --init --recursive && popd'

############################################### specific

_compdir=/usr/share/zsh/functions
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
autoload -U compinit
compinit

