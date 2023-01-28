source "$ZRCDIR/base.zsh"
source "$ZRCDIR/options.zsh"
source "$ZRCDIR/functions.zsh"
source "$ZRCDIR/alias.zsh"
source "$ZRCDIR/bindkey.zsh"
source "$ZRCDIR/plugins.zsh"

[ -f $ZDOTDIR/zshrc/`uname`/init.zsh ] && . $ZDOTDIR/zshrc/`uname`/init.zsh
[ -f $HOME/local.zshrc ] && . $HOME/local.zshrc