#!/bin/zsh

git_user="anvidev"
get_email="andreasglyche@gmail.com"

echo "Setting up new macOS environment on $(whoami)'s machine..."

echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Homebrew has been installed"

formulaes=(
	'node',
	'go',
	'gh',
	'stow',
	'yazi',
	'neovim',
	'tmux',
	'direnv',
	'docker'
)

echo "Starting installation of ${#formulaes[@]} brew formulaes"

for formulae in "${formulaes[@]}";
do
	echo "Installing $formulae"
	brew install $formulae
done

casks=(
	'1password',
	'ghostty',
	'raycast',
	'spotify',
	'zen-browser'
)

echo "All brew formulaes installed"
echo "Starting installation of ${#casks[@]} brew casks"

for cask in "${casks[@]}";
do
	echo "Installing $cask"
	brew install --cask $cask
done

echo "All brew casks installed"
echo "Starting symlinking configurations"

stow_dirs_cmd=$(ls -d */)
dirs=(${(f)stow_dirs_cmd})
 
for dir in "${dirs[@]}"; do
  echo "stow ${dir%/}"
done

echo "All symlinks created"
echo "Setting git globals"

git config --global user.name "$git_user"
git config --global user.email "$get_email"

echo "Git globals set"
