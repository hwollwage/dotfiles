#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# EVAL SSH AGENT
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent -s)" >/dev/null
	ssh-add ~/.ssh/hwollwage >/dev/null 2>&1
fi

# ALIASES
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ALIASES MOD
alias h='history'
alias adog='git log --all --decorate --oneline --graph'
alias src='source ~/.bashrc'
alias ex='exit'
alias exi='exit'
alias sht='shutdown -h now'
alias rbt='reboot'

PS1='[\u@\h \W]\$ '

# EXPORT PATH
export HISTTIMEFORMAT="%A %d %B %Y %T  " 
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# EVAL
eval "$(starship init bash)"

# ENABLE BASH COMPLETION
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
fi

# DISABLE TERMINAL BELL
bind 'set bell-style none'
