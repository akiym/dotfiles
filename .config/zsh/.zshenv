if [ "$TERM" = "linux" ]; then
    export LANG=C
else
    export LANG=en_US.UTF-8
fi
export LC_CTYPE=en_US.UTF-8
export LC_DATE=C

typeset -U path
path=(
    $HOME/bin        (N-/)
    $HOME/tool/bin   (N-/)
    /opt/bin         (N-/)
    /usr/local/sbin  (N-/)
    /usr/local/bin   (N-/)
    /usr/sbin        (N-/)
    /usr/bin         (N-/)
    /sbin            (N-/)
    /bin             (N-/)
)

export PERL_BADLANG=0
export PERL_CPANM_OPT="--no-man-pages"
source /opt/perl5/etc/bashrc
