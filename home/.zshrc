autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz regexp-replace

setopt no_beep # no annoying beep on error
setopt prompt_subst # parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt auto_menu # automatically use menu completion after the second consecutive request for completion
setopt auto_cd # auto change directory if it's name was entered
setopt append_history # zsh sessions will append their history list to the history file, rather than replace it
setopt hist_ignore_all_dups # if a new command duplicates an older one, remove the older command from history
setopt hist_ignore_space # remove command lines from the history list when the first character on the line is a space
setopt hist_reduce_blanks # remove superfluous blanks from each command line being added to the history list
setopt share_history # share history data

export PATH=/usr/local/sbin:/usr/local/bin:$HOME/.bin:$HOME/.yarn/bin:$PATH
export PROMPT='$(lprompt)'
export RPROMPT='$(rprompt)'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export GPG_TTY=$(tty)
export CLICOLOR=1
export HISTFILE=~/.zsh_history
export HISTSIZE=100
export SAVEHIST=$HISTSIZE
export COLORTERM=truecolor
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

if [[ -s $HOME/.rvm/scripts/rvm ]]; then # macOS/Linux RVM
  source $HOME/.rvm/scripts/rvm
elif [[ -s /usr/local/bin/rbenv ]]; then # macOS Rbenv
  eval "$(/usr/local/bin/rbenv init - zsh)"
elif [[ -s $HOME/.rbenv/bin/rbenv ]]; then # Linux Rbenv
  eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*:*' formats '%F{green}@%K{green}%F{black}%c%u \ue725 %b%f'
zstyle ':vcs_info:*:*' actionformats '%c%u%b \ue0b3 %a%f'
zstyle ':vcs_info:*' stagedstr '%F{yellow}@%K{yellow}%F{black}'
zstyle ':vcs_info:*' unstagedstr '%F{red}@%K{red}%F{black}'

add-zsh-hook precmd vcs_info

lprompt() {
  echo "%K{green}%F{black} \uf07c ${${(%):-%~}//\// \ue0b1 } %F{green}%k\ue0b0%f "
}

rprompt() {
  local prompt_line=()
  if [[ -n $vcs_info_msg_0_ ]]; then
    # very inefficient way to render angled prompt segments
    regexp-replace vcs_info_msg_0_ '%F\{green\}@%K\{green\}%F\{black\}%F\{red\}' '%F{red}'
    regexp-replace vcs_info_msg_0_ '%F\{green\}@%K\{green\}%F\{black\}%F\{yellow\}' '%F{yellow}'
    regexp-replace vcs_info_msg_0_ '%F\{yellow\}@%K\{yellow\}%F\{black\}%F\{red\}' '%F{red}'
    prompt_line+="${vcs_info_msg_0_//@/\ue0b2}"
  fi
  if [[ -n $rvm_version ]]; then
    local gemset=`rvm-prompt g`
    if [[ -n $gemset ]]; then
      prompt_line+="%F{blue}\ue0b2%K{blue}%F{black} \ue23e ${gemset:1}"
    fi
  fi
  prompt_line+="%f%k"
  echo $prompt_line
}

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
  set_terminal_tab_title() {
    local PWD_URL="file://$HOSTNAME${PWD// /%20}"
    printf '\e]7;%s\a' $PWD_URL
  }
elif [[ -n $ITERM_SESSION_ID ]]; then
  colored_apps=(ssh mosh)

  set_terminal_tab_title() {
    echo -ne "\e]1;${PWD##*/}\a"
  }

  set_tab_color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
  }

  tab_color() {
    local command=${1%% *}
    for app in $colored_apps; do
      if ( [[ "$command" = "$app" ]] ); then
        set_tab_color 255 207 0
        return 0
      fi
    done
  }
  add-zsh-hook preexec tab_color

  reset_tab_color() {
    echo -ne "\033]6;1;bg;*;default\a"
  }
  add-zsh-hook precmd reset_tab_color
fi

if typeset -f set_terminal_tab_title > /dev/null; then
  set_terminal_tab_title
  add-zsh-hook chpwd set_terminal_tab_title
fi

function e() {
    if [ "$1" != "" ]
    then
        $EDITOR $1
    else
        $EDITOR .
    fi
}

# global aliases
alias ll="ls -l"
alias grep="grep --color=auto"
alias mc="mc -x"
alias pgrep="pgrep -a"

stty -ixon # disable ctrl-s - ctrl-q shit

if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

[ -s $HOME/.zshrc.local ] && source $HOME/.zshrc.local
