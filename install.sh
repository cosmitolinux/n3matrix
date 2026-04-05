#!/bin/bash

# --- Nebula Color Palette ---
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${PURPLE}🌌 Starting n3bu1a Suite Installation...${NC}"

# 1. Create the Dependency Directory
# This is where the GitHub repo and Python logic live
echo -e "${CYAN}Checking directory structure...${NC}"
if [ ! -d "$HOME/.config/nebdpences" ]; then
    mkdir -p "$HOME/.config/nebdpences"
    echo -e "Created ~/.config/nebdpences"
fi

# 2. Deploy Scripts to the Config Directory
# We assume you are running this from the cloned GitHub folder
echo -e "${CYAN}Deploying star engines to ~/.config/nebdpences/...${NC}"
cp gxtop.py "$HOME/.config/nebdpences/gxtop.py"
cp n3matrix.py "$HOME/.config/nebdpences/n3matrix.py"

# 3. Make them executable
chmod +x "$HOME/.config/nebdpences/gxtop.py"
chmod +x "$HOME/.config/nebdpences/n3matrix.py"

# 4. Create Global Binaries
# This allows the user to just type 'gxtop' or 'n3matrix'
echo -e "${CYAN}Linking binaries to ~/.local/bin/...${NC}"
mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.config/nebdpences/gxtop.py" "$HOME/.local/bin/gxtop"
ln -sf "$HOME/.config/nebdpences/n3matrix.py" "$HOME/.local/bin/n3matrix"

# 5. Handle the Shell PATH
echo -e "${PURPLE}Finalizing shell integration...${NC}"

# For Fish Users (The Nebula Favorite)
if [ -d "$HOME/.config/fish" ]; then
    echo -e "${CYAN}Fish detected. Updating universal path...${NC}"
    fish -c "set -Ua fish_user_paths $HOME/.local/bin" 2>/dev/null
fi

# For Bash Users
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q ".local/bin" "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo -e "${CYAN}Updated .bashrc PATH.${NC}"
    fi
fi

echo -e "${PURPLE}---------------------------------------${NC}"
echo -e "${CYAN}  INSTALLATION SUCCESSFUL!${NC}"
echo -e "  Scripts stored in: ~/.config/nebdpences/"
echo -e "  Commands ready: ${PURPLE}gxtop${NC} and ${PURPLE}n3matrix${NC}"
echo -e "${PURPLE}---------------------------------------${NC}"
