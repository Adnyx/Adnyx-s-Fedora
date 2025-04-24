#!/bin/bash

# Ask for sudo once at the beginning
sudo -v

# Keep sudo alive while the script runs
( while true; do sudo -n true; sleep 60; done ) &
SUDO_PID=$!
trap 'kill "$SUDO_PID"' EXIT

# Get the username of the person running the script
USER_NAME=$(whoami)

# ZSH install prompt
while true; do
	read -p "Do you wish to install zsh and make it default ? (y/n) " install_choice

	case "$install_choice" in
		[Yy]* )
			# Set zsh as the default shell before installing OhMyZsh
			sudo chsh -s "$(which zsh)" "$USER_NAME"
			
			# Group sudo commands together
			sudo bash -c '
				# Install zsh shell and run it
				dnf install -y zsh
				# Install OhMyZSH
				sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
			'

			# Cool ohmyzsh plugins
			ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

			git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
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
	read -p "Do you want to copy my .zshrc file ? (y/n) " choice
	case "$choice" in
		[Yy]* )
			cp zshrcfile "$HOME/.zshrc"
			echo "config copied !"
			break
			;;
		[Nn]* )
			echo "Aight bet, I'm skipping this part then"
			break
			;;
		* )
			echo "Please input y or n"
			;;
	esac
done

# Installing BigBlue nerd font
FONT_NAME="BigBlueTerm437 Nerd Font Mono"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/BigBlueTerminal.zip"
FONT_DIR="$HOME/.local/share/fonts"

while true; do
	read -p "Wanna install BigBlue nerd font ? :3 (y/n) " font_choice
	case "$font_choice" in 
		[Yy]* )
			echo "installin' some nerd fonts" 
			mkdir -p "$FONT_DIR"
			curl -Lo "$FONT_DIR/BigBlue.zip" "$FONT_URL"
			unzip -o "$FONT_DIR/BigBlue.zip" -d "$FONT_DIR"
			rm "$FONT_DIR/BigBlue.zip"
			fc-cache -fv "$FONT_DIR"
			echo "Done :3"

			# Search for font, if found, it sets it as default
			if fc-list | grep -iq "$FONT_NAME"; then
				echo "setting BigBlue as default font"
				gsettings set org.gnome.desktop.interface monospace-font-name "$FONT_NAME"
			else
				echo "Couldn't find the font..."
			fi
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

