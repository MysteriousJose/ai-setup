#!/bin/bash
set -e

# Check if a model name was passed as an argument; if not, prompt interactively
if [ -z "$1" ]; then
    echo "----------------------------------------"
    read -p "Enter model preset name (options: iq3_xxs-128k, iq3_s-128k, default: iq3_xxs-128k): " MODEL_NAME
    # Fallback to default if the user just presses Enter
    MODEL_NAME="${MODEL_NAME:-iq3_xxs-128k}"
    echo "----------------------------------------"
else
    MODEL_NAME="$1"
fi

echo "-> Selected model/preset: $MODEL_NAME"

echo "1. Cleaning old state & locks..."
rm -rf ~/.local/share/strata/Strata-data
rm -f ~/.config/strata/profiles/*.lock 2>/dev/null || true

echo "2. Installing Strata..."
curl -fsSL --connect-timeout 15 --max-time 120 https://github.com/Niko1221/Strata/releases/latest/download/install.sh -o install.sh && sh install.sh 

echo "3. Configuring PATH..."
echo 'export PATH="$PATH:/root/.local/bin"' >> ~/.bashrc
export PATH="$PATH:/root/.local/bin"

echo "4. Restoring settings & presets for $MODEL_NAME..."
mkdir -p ~/.config/strata/launch-presets
mkdir -p ~/.config/strata/profiles

# Verify the folder exists in the repo before copying
if [ ! -d "configs/$MODEL_NAME" ]; then
    echo "Error: Configuration folder 'configs/$MODEL_NAME' not found in repository!"
    exit 1
fi

cp configs/$MODEL_NAME/settings.json ~/.config/strata/settings.json
cp configs/$MODEL_NAME/launch-presets/*.json ~/.config/strata/launch-presets/
cp configs/$MODEL_NAME/profiles/*.json ~/.config/strata/profiles/

echo "5. Fixing file permissions..."
chmod -R 755 ~/.config/strata ~/.local/share/strata ~/.local/state/strata 2>/dev/null || true

echo "6. Setup complete! Launching Strata..."
strata launch --preset "$MODEL_NAME"