set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx LANGUAGE "en_US.UTF-8"
set -gx EDITOR "nvim"
set -gx PAGER "less"
set -gx CLICOLOR "1"
set -gx TERM "screen-256color"
set -gx COLORTERM "truecolor"
set -gx FZF_DEFAULT_COMMAND "rg --files --follow --hidden"
set -gx FZF_DEFAULT_OPTS "--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"
set -gx MANPAGER "nvim +Man!"

set -p fish_user_paths "$HOME/.bin"
set fish_greeting ""
set fish_prompt_pwd_dir_length 30
set fish_color_autosuggestion white
set fish_color_command bryellow
set fish_color_error normal
set fish_color_param normal
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set fish_key_bindings fish_vi_key_bindings

abbr -a dce docker-compose exec
abbr -a dcu docker-compose up
abbr -a dcs docker-compose stop
abbr -a gco git checkout
abbr -a ga git add
abbr -a gc git commit
abbr -a gp git push

alias ll="ls -l"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias pgrep="pgrep -a"
alias cp="cp -i"
alias mv="mv -i"
alias mc="mc -u"
alias rm="rm -i"
alias df="df -h"
alias free="free -m"
alias tm="tmux a -t main"

function fish_user_key_bindings
  for mode in insert default visual
    bind -M $mode \cf accept-autosuggestion
  end
end

function fish_prompt -d "Draws left prompt (mode, current directory, colored git status sign)"
  echo -ns (set_color green) (prompt_pwd) (__git_status_color) "\$" (set_color normal) " "
end

function fish_mode_prompt
  echo "["
  switch $fish_bind_mode
    case default
      set_color green
      echo "N"
    case insert
      set_color blue
      echo "I"
    case replace_one
      set_color blue
      echo "R"
    case visual
      set_color yellow
      echo "V"
    case "*"
      set_color red
      echo "?"
  end
  set_color normal
  echo "] "
end

function fish_right_prompt -d "Draws right prompt (hostname)"
  test -n "$TMUX"; and return # tmux also draws hostname, no need to duplicate
  echo -ns "[" (set_color yellow) (hostname) (set_color normal) "]"
end

function __git_status_color
  set -l git_status (git status --porcelain=v1 --untracked-files=no 2> /dev/null)
  if test $status -eq 128
    echo -n (set_color normal)
    return
  end
  # set -l git_status (echo $git_status_raw | string split0)
  if echo $git_status | grep -q "^[[:space:][:upper:]][[:upper:]][[:space:]]"
    echo -n (set_color red)
  else if echo $git_status | grep -q "^[[:upper:]][[:space:]]"
    echo -n (set_color yellow)
  else
    echo -n (set_color green)
  end
end

function backup -a filename -d "Makes a backup of the given file"
  cp $filename $filename.bak
end

function e -a path -d "Opens editor in the current directory or with given path"
  test -z "$path"; and set path "."
  $EDITOR $path
end

function dockerize -a command -a container -d "Runs command in Docker container"
  test -z "$container"; and set container "app"
  docker-compose exec $container $command
end

function extract -a filename -d "Extracts files from the archive"
  switch $filename
    case "*.tar"
      tar -xvf $filename
    case "*.tar.bz2" "*.tbz2"
      tar -jxvf $filename
    case "*.tar.gz" "*.tgz"
      tar -zxvf $filename
    case "*.bz" "*.bz2"
      bunzip2 $filename
    case "*.gz"
      gunzip $filename
    case "*.rar" "*.zip" "*.7z"
      7z x $filename
    case '*'
      echo "Unknown archive type"
  end
end

test -f "$HOME/.local.fish"; and source "$HOME/.local.fish"
