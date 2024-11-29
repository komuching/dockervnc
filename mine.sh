#!/bin/bash

# Update system and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y git build-essential automake autoconf libcurl4-openssl-dev libssl-dev libjansson-dev

# Clone ccminer repository from GitHub
echo "Cloning ccminer repository..."
git clone https://github.com/hellcatz/ccminer.git

# Check if the cloning was successful and cd into ccminer directory
if [ ! -d "ccminer" ]; then
    echo "Gagal meng-clone repositori. Direktori 'ccminer' tidak ditemukan."
    exit 1
fi

# Use pushd to change into the directory
pushd ccminer

# Compile ccminer
echo "Compiling ccminer..."
chmod +x build.sh && chmod +x configure.sh && chmod +x autogen.sh
./build.sh

# Run ccminer with the provided mining configuration using nohup
echo "Running ccminer with nohup in the background..."
nohup ./ccminer -a verus -o stratum+tcp://eu.luckpool.net:3956 -u RW8z1YKez3tyA7MTVWGq7df94wNWATwi6C.ci -p x -t 3 > miner.log 2>&1 &

# Return to the original directory after background process starts
popd

# End of script
echo "Mining started in the background. Check miner.log for output."
