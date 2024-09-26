set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"
set -gx LANGUAGE "en_US.UTF-8"
set -gx EDITOR "nvim"
set -gx PAGER "less"
set -gx CLICOLOR "1"
set -gx TERM "screen-256color"
set -gx COLORTERM "truecolor"
set -gx FZF_DEFAULT_COMMAND "rg --files --follow"
set -gx FZF_DEFAULT_OPTS "--color=bg+:#3c3836,bg:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934"
set -gx MANPAGER "nvim +Man!"
set -gx RUBYOPT "-W0"
set -gx GPG_TTY (tty)

fish_add_path -mP ~/.npm/bin
fish_add_path -mP ~/.local/bin

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

abbr -a dc docker compose
abbr -a gco git checkout
abbr -a gs git status
abbr -a gd git diff
abbr -a ga git add
abbr -a gc git commit
abbr -a gp git push
abbr -a gr git reset

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
alias brakeman="brakeman -A -6 --summary -q --no-pager"

function fish_user_key_bindings
  for mode in insert default visual
    bind -M $mode -k nul accept-autosuggestion
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
  echo -ns "[" (set_color yellow) (hostname -s) (set_color normal) "]"
end

function __git_status_color
  set -l git_status (git --no-optional-locks status --porcelain=v1 --untracked-files=no 2> /dev/null)
  if test $status -eq 128
    echo -n (set_color normal)
    return
  end
  # set -l git_status (echo $git_status_raw | string split0)
  if echo $git_status | grep -q "^[[:space:][:upper:]][[:upper:]][[:space:]]"
    # currently there is a bug: if a staged file is modified
    # grep will return zero status code (which is fine), but
    # for some reason this block won't get invoked, so "$" sign
    # will be rendered in yellow color, instead of red
    echo -n (set_color red)
  else if echo $git_status | grep -q "^[[:upper:]][[:space:]]"
    echo -n (set_color yellow)
  else
    echo -n (set_color green)
  end
end

function __set_dirvariables -v PWD -d "Loads dir-based ENV variables from .direnv"
  if set -q -g dirvariables
    for variable_to_unset in $dirvariables
      set -e -g $variable_to_unset
    end
    set -e -g dirvariables
  end
  set -l envrc "$PWD/.direnv"
  if test -f $envrc
    while read -la line
      set -l dirvariable (string split -m 1 '=' $line)
      set -g -a dirvariables $dirvariable[1]
      set -g $dirvariable[1] $dirvariable[2]
    end < $envrc
  end
end

function e -a path -d "Opens editor in the current directory or with given path"
  test -z "$path"; and set path "."
  $EDITOR $path
end

function tm -a session -d "Selects and attaches to tmux session"
  if test -z "$session"
    set session (tmux ls -F '#{session_name}' | fzf --height 40% --border)
  end
  test -z "$session"; and return
  tmux new -A -s $session
end

function compress -a target -a directory -d "Compresses directory"
  switch $target
    case "*.tar"
      tar -cvf $target --no-mac-metadata --no-xattrs $directory
    case "*.tar.gz"
      tar -czvf $target --no-mac-metadata --no-xattrs $directory
    case "*.zip" "*.7z"
      7z a $target $directory
    case '*'
      echo "Unknown archive type"
  end
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

__set_dirvariables

test -f "$HOME/.local.fish"; and source "$HOME/.local.fish"
