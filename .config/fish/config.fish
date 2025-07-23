if status is-interactive
  # Commands to run in interactive sessions can go here
  set -x LANG "en_US.UTF-8"
  set -x LANGUAGE "en_US.UTF-8"
  set -x LC_ALL "en_US.UTF-8"
end

# Aliases
alias ls='ls -lha --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -CF'
alias em='emacs -nw'
alias dd='dd status=progress'
alias _s='sudo'
alias _i='sudo -i'
alias fucking='sudo'
alias please='sudo'

# Color Variables
set -U fish_color_command blue
set -U fish_color_end brcyan
set -U fish_color_error brwhite
set -U fish_color_escape red
set -U fish_color_operator red
set -U fish_color_param brmagenta
set -U fish_color_quote green
set -U fish_color_quotes green
set -U fish_color_redirection red

starship init fish | source
