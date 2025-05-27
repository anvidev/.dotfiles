alias dots="cd ~/.dotfiles/"
alias v="nvim"
alias y="yazi"
alias ll="ls -lh"
alias md="mkdir"
alias pn="pnpm"
alias g="git"
alias ga="git add"
alias gaa="git add ."
alias gs="git status"
alias gcm="git commit -m"
alias gsw="git switch"
alias gsc"git switch -c"
alias gf="git fetch"
alias gpl="git pull"
alias gps="git push"
alias gc="git clone"
alias gl='git log --oneline --graph --decorate --all'

alias tms='~/.config/tmux/tmux-sessionizer.sh'

git_branch() {
  local branch
  branch=$(git branch --show-current 2> /dev/null)
  if [[ -n $branch ]]; then
    echo " ($branch)"
  fi
}

setopt PROMPT_SUBST
PROMPT='%n %~$(git_branch) %# '

export PATH=`go env GOPATH`/bin/:$PATH

eval "$(direnv hook zsh)"
