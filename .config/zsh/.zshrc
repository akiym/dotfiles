export EDITOR='vim'
export PAGER='less'

alias ls='ls --color'
alias l.='ls -d .[a-zA-Z]*'
alias la='ls -la'
alias lh='ls -lh'
alias ll='ls -ltr'

alias jb='jobs'
alias l='less'
alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='mv -f --backup=numbered --target-directory ~/.Trash'

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

alias vi='vim'
alias gdb='gdb -q'
alias ack='ack-grep --smart-case'
alias tree='tree -N'
alias pd='perldoc'
alias cpanm='cpanm --notest'

alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias uuuu='cd ../../../..'

alias a='./a.out'
alias d='strace -f micro-inetd 4000'

function p() {
    lastcmd=$(fc -ln python python)
    eval $lastcmd
}

HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history

if [ ${UID} = 0 ]; then
    unset HISTFILE
    export SAVEHIST=0
fi

autoload -U colors
colors

PROMPT="%n@%F{white}%m%f%% "
RPROMPT="%(?..%F{red}:/%f) [%B%(5~,%-2~/.../%2~,%~)%b]%1(v| %F{green}%1v%f|)"
SPROMPT="%{$fg[red]%}Correct %{$reset_color%}> '%r' [%BY%bes %BN%bo %BA%bbort %BE%bdit] ? "

chpwd() {
    ls_abbrev
}

if [ -e "$HOME/.zsh/cache" ]; then
    zstyle ':completion:*' use-cache true
    zstyle ':completion:*' cache-path $HOME/.zsh/cache
fi

fpath=(/home/akiym/tool/pwntools/zsh-completions $fpath)

autoload -U compinit
compinit

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

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

bindkey -e

bindkey '^U' kill-whole-line
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '^S' history-incremental-search-forward

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^R' peco-select-history

extract(){
  if [ -f $1 ]; then
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

ls_abbrev(){
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
