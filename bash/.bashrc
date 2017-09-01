# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

function _update_ps1() {
    PS1="$(~/.powerline/powerline-go -cwd-max-depth 5 -cwd-max-dir-size 4 -error $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

#if [[ ! $TERM =~ screen ]]; then
#    exec tmux
#fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
# [[ $TERM != "screen" ]] && exec tmux

# User specific aliases and functions
alias vim="nvim"

# test "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' || (script --timing=time.txt -f
# $HOME/log/$(date +"%d-%b-%y_%H-%M-%S")_shell.log)
