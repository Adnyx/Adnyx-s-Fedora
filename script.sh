#!/bin/bash
while true; do
	read -p "Do you wish to isntall zsh and make it default ? (y/n)" install_choice

	case "$install_choice" in
		[Yy]* )

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
			break
			;;
		[Nn]* )
			echo "Bet, skippin' this part then"
			break
			;;
		* )
			echo "Please input y or n"
			;;
	esac
done

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

# Installing BigBlue nerd font

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/BigBlueTerminal.zip"
FONT_DIR="$HOME/.local/share/fonts"

read -p "Wanna install BigBlue nerd font ? :3 (y/n)" font_choice
while true ; do
	case "$font_choice" in 
		[Yy]* )
			echo "installin' some nerd fonts" 
			mkdir -p "$FONT_DIR"
			curl -Lo "$FONT_DIR/BigBlue.zip" "$FONT_URL"
			unzip -o "$FONT_DIR/BigBlue.zip" -d "$FONT_DIR"
			rm "$FONT_DIR/BigBlue.zip"
			fc-cache -fv "$FONT_DIR"
			echo "Done :3"
			break
			;;
		[Nn]* )
			echo "Aight, skippin this part (too bad, it's a banger of a font)"
			break
			;;
		* )
			echo "Please input y or n"
			;;
	esac
done
