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
mkdir -p ~/.config/strata/launch-presets
mkdir -p ~/.config/strata/profiles

cp config/settings.json ~/.config/strata/settings.json
cp config/launch-presets/iq3_xxs-128k.json ~/.config/strata/launch-presets/iq3_xxs-128k.json
cp config/profiles/launch-iq3_xxs-128k.json ~/.config/strata/profiles/launch-iq3_xxs-128k.json

echo "4. Repairing file permissions..."
strata repair-access

echo "5. Setup complete! Starting application..."
# Command to run Strata
strata launch --preset iq3_xxs-128k