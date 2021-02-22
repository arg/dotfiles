set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx LANGUAGE "en_US.UTF-8"
set -gx EDITOR "nvim"
set -gx PAGER "less"
set -gx CLICOLOR "1"
set -gx TERM "xterm-256color"
set -gx COLORTERM "truecolor"
set -gx FZF_DEFAULT_COMMAND "rg --files --follow --hidden"

set -p fish_user_paths "$HOME/.bin"
set fish_greeting ''
set fish_prompt_pwd_dir_length 0
set fish_color_autosuggestion white
set fish_color_command bryellow
set fish_color_error normal
set fish_color_param normal

alias ll='ls -l'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias pgrep='pgrep -a'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'
alias free='free -m'

function e -a path -d 'Opens editor in the current directory or with given path'
  if test -z "$path"
    $EDITOR .
  else
    $EDITOR $path
  end
end

function fish_prompt -d 'Draws left prompt (current directory)'
  echo -ns (set_color green) (prompt_pwd) (__git_status) (set_color normal) '$ '
end

function __git_status
  set -l git_branch (git branch --show-current 2> /dev/null)
  test $status -eq 128; and return
  set -l git_status (git status --porcelain=v1 --untracked-files=no | string split0)

  echo -ns (set_color normal) '('
  if echo $git_status | grep -q '^[ MAD][MAD]'
    echo -n (set_color red)
  else if echo $git_status | grep -q '^[MAD]'
    echo -n (set_color yellow)
  else
    echo -n (set_color green)
  end

  echo -ns $git_branch (set_color normal) ')'
end

test -f "$HOME/.local.fish"; and source "$HOME/.local.fish"
