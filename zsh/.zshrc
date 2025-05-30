alias dots="cd ~/.dotfiles/"
alias v="nvim"
alias y="yazi"
alias ll="ls -a -lh"
alias md="mkdir"
alias pn="pnpm"

alias g="git"

alias ga="git add"
alias gap="git add --patch"
alias gc="git commit"
alias gu="git pull"
alias gp="git push"
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gw="git switch"
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gs="git status --short"
alias gf="git fetch"
alias gcl="git clone"

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
