alias ls='ls -G'
if [ -e '/usr/local/bin/gls' ]; then
    alias ls='\gls --color'
fi

alias l.='ls -d .[a-zA-Z]*'
alias la='ls -la'
alias lh='ls -lh'
alias ll='\ls -ltrTG'

alias v='vi'
alias g='git'
alias t='tig status'
alias m='make'
alias jb='jobs'
alias l='lv'
alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='gmv -f --backup=numbered --target-directory ~/.Trash'
alias gdb='gdb -q'

alias vs='vi -S Session.vim'
alias vi='nvim'
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim -u $HOME/.vimrc \"\$@\""
alias nv='nvim'
alias bvi='bed'
#alias ce='carton exec --'

# perlman
alias cpanm='cpanm --notest'
alias prove6='\prove --exec "perl6 -Ilib"'
alias prove='ce prove -lvr'
alias pr='prove'
alias ppr='ce prove -lvr -Pretty t/'
alias pe='ce perl -I. -Ilib'
alias pec='ce perl -I. -Ilib -MCarp::Always'
alias yath='ce yath'
alias provecover="HARNESS_PERL_SWITCHES='-MDevel::Cover=-ignore,t/|local/' ce \\prove -lvr t/; cover; open cover_db/coverage.html"
alias cpmi='cpm install -L local --with-develop'

alias dc='docker-compose'
alias dcr='docker-compose run --rm --no-deps'

alias yw='yarn workspace'
alias ywa='yarn workspace apollo'

alias ack='ack --smart-case'
alias grep='grep -i'
alias tree='tree -N'

alias gist='gist -p'
alias ql='qlmanage -p'
alias jman='env LANG=ja_JP.UTF-8 man'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias uuuu='cd ../../../..'

alias py='python'
alias ipy='ipython'

alias pbc='pbcopy'
alias pbp='pbpaste'

alias ag='rg --smart-case --max-columns=200'
alias p4merge='~/Applications/p4merge.app/Contents/MacOS/p4merge'

alias k='kubectl'

function agl () { ag "$*" lib }
function gg () {
    if [[ "$*" =~ ^[^A-Z]+$ ]]; then
        git grep -i "$*"
    else
        git grep "$*"
    fi
}

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\"" }
function spot ()    { mdfind -onlyin . "$*" | xargs ack "$*" }

HISTFILE=$ZDOTDIR/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
setopt extended_history
setopt hist_find_no_dups
#setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

if [ ${UID} = 0 ]; then
    unset HISTFILE
    export SAVEHIST=0
fi

alias search-history="less $HISTFILE | grep"

autoload -U colors
colors

#setopt transient_rprompt
PROMPT="%% "
RPROMPT="%(?..%F{red}\$?%f) [%B%(5~,%-2~/.../%2~,%~)%b] %*%1(v| %F{green}%1v%f|)"
#RPROMPT="[%B%(5~,%-2~/.../%2~,%~)%b]"
SPROMPT="%{$fg[red]%}Correct %{$reset_color%}> '%r' [%BY%bes %BN%bo %BA%bbort %BE%bdit] ? "

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
#zstyle ':vcs_info:*' enable git svn hg bzr
#zstyle ':vcs_info:*' formats '%s:(%b)'
#zstyle ':vcs_info:*' actionformats '%s:(%b|%a)'
#zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
#zstyle ':vcs_info:bzr:*' use-simple true

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '(%b) %c%u'
zstyle ':vcs_info:git:*' actionformats '(%b|%a) %c%u'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

add-zsh-hook precmd _update_vcs_info_msg

autoload -U chpwd_recent_dirs cdr
chpwd_functions+=chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default true
zstyle ":completion:*" recent-dirs-insert always

if [ -e "$HOME/.zsh/cache" ]; then
    zstyle ':completion:*' use-cache true
    zstyle ':completion:*' cache-path $HOME/.zsh/cache
fi

typeset -U fpath
fpath=(
    $ZDOTDIR/.zsh/zsh-completions/src
    $ZDOTDIR/.zsh/completion
    /usr/local/share/zsh/site-functions
    $fpath
)
#
autoload -U compinit
compinit -uC
source $ZDOTDIR/.zsh/completion/tig-completion.bash
source $ZDOTDIR/.zsh/completion/npm-completion.bash
source $ZDOTDIR/.zsh/completion/aws_zsh_completer.sh
source /usr/local/opt/fzf/shell/completion.zsh

chpwd() {
    ls_abbrev
}

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
zstyle ':completion:*:default' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:(perldoc|pd|perl):*' matcher 'r:|[:][:]=*'

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

export LISTMAX=10000

setopt auto_cd
setopt auto_pushd
setopt list_packed
setopt no_list_types
setopt correct
setopt pushd_ignore_dups
setopt no_beep
setopt no_list_beep
setopt numeric_glob_sort
setopt magic_equal_subst
setopt prompt_subst
#setopt extended_glob

# {t,lib}j/**/*.{t,pm}
setopt nonomatch
setopt null_glob

bindkey -e
bindkey '^U' kill-whole-line
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

#nw(){
#    local CMDNAME split_opts spawn_command
#    CMDNAME=`basename $0`
#
#    while getopts dhvPp:l:t:b: OPT
#    do
#        case $OPT in
#        "d" | "h" | "v" | "P" )
#            split_opts="$split_opts -$OPT";;
#        "p" | "l" | "t" )
#            split_opts="$split_opts -$OPT $OPTARG";;
#        * ) echo "Usage: $CMDNAME [-dhvP]" \
#                 "[-p percentage|-l size] [-t target-pane] [command]" 1>&2
#            return 1;;
#        esac
#    done
#    shift `expr $OPTIND - 1`
#
#    spawn_command=$@
#    [[ -z $spawn_command ]] && spawn_command=$SHELL
#
#    tmux split-window `echo -n $split_opts` "cd $PWD ; $spawn_command"
#}
#_nw(){
#    local args
#    args=(
#        '-d[do not make the new window become the active one]'
#        '-h[split horizontally]'
#        '-v[split vertically]'
#        '-l[define new pane'\''s size]: :_guard "[0-9]#" "numeric value"'
#        '-p[define new pane'\''s size in percent]: :_guard "[0-9]#" "numeric value"'
#        '-t[choose target pane]: :_guard "[0-9]#" "numeric value"'
#        '*:: :_normal'
#    )
#    _arguments ${args} && return
#}
#compdef _nw nw

ls_abbrev() {
    # -a : Do not ignore entries starting with ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-atrC' '--color=always')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if type gls > /dev/null 2>&1; then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-atrCG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

    if [ $ls_lines -gt 10 ]; then
        echo "$ls_result" | head -n 5
        echo '...'
        echo "$ls_result" | tail -n 5
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
    else
        echo "$ls_result"
    fi
}

#function godoc() {
#    local -a go_packages
#
#    go_packages=("builtin")
#    for dir in $GOROOT $(perl -wle 'print $_ for split q{:}, shift' $GOPATH)
#    do
#        pkgdir="$dir/pkg"
#        if [ -d $pkgdir ]; then
#            packages=$(find $pkgdir -name "*.a" -type f \
#                       | perl -wlp -e "s{$pkgdir/(?:(?:obj|tool)/)?[^/]+/}{} and s{\\.a\$}{}")
#            go_packages=($packages $go_packages)
#        fi
#    done
#
#    command godoc $(echo $go_packages | sort | uniq | peco) | $PAGER
#}

#function p() {
#    lastcmd=$(fc -ln py py)
#    print "\033[1;37;44m$lastcmd\033[0m\n"
#    eval $lastcmd
#}

__fsel() {
  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__fzf_use_tmux__() {
  [ -n "$TMUX_PANE" ] && [ "${FZF_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

__fzfcmd() {
  __fzf_use_tmux__ &&
    echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected=( $(fc -l 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(q)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

function fzf-git-branch-activity-checkout () {
    local selected_branch_name=( $(git branch-recent |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) |
      /usr/local/bin/perl -ne 'print $1 if /(\S+)$/')
    )
    local ret=$?
    if [ -n "$selected_branch_name" ]; then
        BUFFER="git checkout ${selected_branch_name}"
        zle accept-line
    fi
    zle redisplay
    typeset -f zle-line-init >/dev/null && zle zle-line-init
    return $ret
}
zle -N fzf-git-branch-activity-checkout
bindkey '^g' fzf-git-branch-activity-checkout

function fzf-ghq () {
    local selected_dir=$(ghq list -p | sed -e "s!^$HOME/!!" | fzf --bind=ctrl-r:toggle-sort --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd $HOME/${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-ghq
bindkey '^]' fzf-ghq

function fu () {
  local selected_line=$(furo2 history | fzf --query "$LBUFFER" --height ${FZF_TMUX_HEIGHT:-40%})
  if [ -n "${selected_line}" ]; then
    local hash=$(echo "${selected_line}" | cut -d ' ' -f 1)
    command furo2 history show ${hash}
  fi
}

function pd() {
    if [ $# -ge 2 ]; then;
        command ce perldoc $@
    else
        local selected_module=${1:-$(find-perl-modules | fzf --bind=ctrl-r:toggle-sort)}
        command ce perldoc $selected_module
    fi
}

function pdm() {
    local selected_module=${1:-$(find-perl-modules | fzf --bind=ctrl-r:toggle-sort)}
    command ~/bin/pdm $selected_module
}

source <(kubectl completion zsh)
