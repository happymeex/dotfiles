autoload -U colors && colors

PROMPT_DIRTRIM=3
PS1="%{$fg[yellow]%}%n @%m: %~ %{$reset_color%}"

alias ls="ls --color=auto";

set -o vi;
export EDITOR=vim;

alias gs="git status";
alias ga="git add";
alias gc="git commit";
