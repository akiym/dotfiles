if [ "$TERM" = "linux" ]; then
    export LANG=C
else
    export LANG=en_US.UTF-8
fi
export LC_CTYPE=en_US.UTF-8
export LC_DATE=C

setopt no_global_rcs

typeset -U path
path=(
    $HOME/bin        (N-/)
    $HOME/bin2       (N-/)
    $HOME/akitools   (N-/)
    $HOME/.anyenv/bin  (N-/)
    $HOME/.cargo/bin (N-/)
    $GOROOT/bin  (N-/)
    $GOPATH/bin  (N-/)
    /usr/local/bin   (N-/)
    /usr/local/sbin  (N-/)
    /usr/bin         (N-/)
    /usr/sbin        (N-/)
    /bin             (N-/)
    /sbin            (N-/)
    /usr/X11/bin     (N-/)
)

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR='vi'
export PAGER='lv'

export LV='-Ou8 -c'

export PERL_BADLANG=0
export PERL_CPANM_OPT="--no-man-pages"

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go

export HOMEBREW_CASK_OPTS="--appdir=~/Applications"
export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_AUTO_UPDATE=0

export FZF_DEFAULT_OPTS="--no-sort --no-mouse --reverse --ansi"

eval "$(anyenv init - --no-rehash)"
source $HOME/.mysqlenv/etc/bashrc

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
