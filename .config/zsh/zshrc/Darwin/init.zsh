# m1
if [ -d "/opt/homebrew/bin" ] ; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# intel
if [ -d "/usr/local/bin" ] ; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# if [ `/usr/libexec/java_home` ] ; then
# export JAVA_HOME=`/usr/libexec/java_home`
# PATH=${JAVA_HOME}/bin:${PATH}
# fi

if [ `/usr/libexec/java_home -v "11"` ] ; then
  export JAVA_HOME=`/usr/libexec/java_home -v "11"`
  PATH=${JAVA_HOME}/bin:${PATH}
fi

if [ -d "$HOME/.jenv/bin" ] ; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias mvim=/Applications/MacVim.app/Contents/bin/mvim "$@"
alias paraubuntu=10.211.55.12
alias bau='brew update && brew upgrade && brew upgrade --cask --greedy'
alias bwupgrade='brew update && brew upgrade'
alias intelzsh='arch -x86_64 zsh'
alias yabai-restart='brew services restart yabai'

export PATH="$PATH:${HOME}/develop/flutter/bin"
export FLUTTER_ROOT="${HOME}/develop/flutter"
export PATH="$PATH":"$HOME/.pub-cache/bin"
#export CLOUDSDK_PYTHON=python@3.8

if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ] ; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

if [ -d "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk" ] ; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi

if [ -d "/opt/homebrew/opt/mysql-client/bin" ] ; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
fi

function gcloud-activate() {
  name="$1"
  project="$2"
  echo "gcloud config configurations activate \"${name}\""
  gcloud config configurations activate "${name}"
}
function gx-complete() {
  _values $(gcloud config configurations list | awk '{print $1}')
}
function gx() {
  name="$1"
  if [ -z "$name" ]; then
    line=$(gcloud config configurations list | fzf)
    name=$(echo "${line}" | awk '{print $1}')
  else
    line=$(gcloud config configurations list | grep "$name")
  fi
  project=$(echo "${line}" | awk '{print $4}')
  gcloud-activate "${name}" "${project}"
}
compdef gx-complete gx

function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

if [ -d "$HOME/.cargo" ] ; then
  source $HOME/.cargo/env
fi

eval "$(direnv hook zsh)"

# skhd startup
# isskhd=(`ps aux | grep skhd | awk '{print $11}'`)
# if [[ "$isskhd" != *skhd* ]]; then
#   nohup skhd &
# fi
