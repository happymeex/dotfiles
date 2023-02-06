###########
# PROMPT  #
###########

PROMPT_DIRTRIM=3
yellow='\[\e[33m\]'
reset='\[\e[0m\]'
PS1="${yellow}\u @\h:\w\$${reset} "

###########
# ALIASES #
###########

# add color
alias grep='grep --color=auto';
alias ls='ls --color=auto';

# git
alias gs='git status';
alias ga='git add';
alias gc='git commit';

# tmux aliases
alias tm='tmux';
alias tma='tmux attach -t';
alias tmks='tmux kill-session -t';
alias tmn='tmux new -s';

# config file shortcuts 
alias nvconf='vim ~/.config/nvim/init.vim';
alias vimconf='vim ~/.vimrc';
alias bconf='vim ~/.bashrc';
alias gitconf='vim ~/.gitconfig';

# misc
alias python='python3';
alias tree='tree -C  -I "node_modules"';

# journal
alias log='vim ~/log/$(date +"%a_%F")'

export TERM=xterm-256color; # Needed for colors to work in tmux
export DISPLAY=:0;

set -o vi; # vi keybinds for command line
export EDITOR=vim;

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
