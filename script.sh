#!/bin/bash

# Install zsh shell and run it (configure it for yourself)
sudo dnf install zsh
# Change default terminal to zsh
chsh -s $(which zsh)
# Install OhMyZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Two cool ohmyzsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Copy my .zshrc config file

while true; do
	read -p "Do you want to copy my .zshrc file ? (y/n)" choice
	case "$choice" in
		[Yy]* )
			cp zshrcfile "$HOME/.zshrc"
			echo "config copied !"
			break
			;;
		[Nn]* )
			echo "Aight bet, i'm skipping this part then"
			break
			;;
		* )
			echo "Please input y or n"
			;;
	esac
done

