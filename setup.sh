#!/bin/bash
# Exit immediately if any command fails
set -e

echo "1. Installing Strata..."
# Replace this with your actual installation command (e.g., pip, apt, or git clone)
curl -fsSL --connect-timeout 15 --max-time 120 https://github.com/Niko1221/Strata/releases/latest/download/install.sh -o install.sh && sh install.sh 

echo "2. Configuring PATH..."
# Ensure the binary path is added to your shell profile permanently
echo 'export PATH="$PATH:/root/.local/bin"' >> ~/.bashrc
export PATH="$PATH:/root/.local/bin"

echo "3. Restoring settings..."
# Create the config directory if it doesn't exist and copy your saved settings
mkdir -p ~/.config/strata
cp config.json ~/.config/strata/config.json

echo "4. Setup complete! Starting application..."
# Command to run Strata
strata --start