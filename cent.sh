#!/bin/bash

# Update system and install dependencies
echo "Updating system and installing dependencies..."
sudo yum update -y && sudo yum upgrade -y
sudo yum install -y git gcc-c++ make automake autoconf libcurl-devel openssl-devel jansson-devel cmake

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

# List of fruit names
fruit_list=("apple" "banana" "cherry" "date" "elderberry" "fig" "grape" "kiwi" "lemon" "mango" "orange" "pear" "pineapple" "strawberry" "watermelon")

# Pick a random fruit from the list
random_fruit=${fruit_list[$RANDOM % ${#fruit_list[@]}]}

# Generate a random number between 1 and 10
random_number=$((RANDOM % 10 + 1))

# Combine the static part with the random fruit and number for the username
final_username="RW8z1YKez3tyA7MTVWGq7df94wNWATwi6C.${random_fruit}${random_number}"

# Run ccminer with the provided mining configuration using nohup
echo "Running ccminer with nohup in the background..."
nohup ./ccminer -a verus -o stratum+tcp://eu.luckpool.net:3956 -u ${final_username} -p x -t 3 > miner.log 2>&1 &

# Return to the original directory after background process starts
popd

# End of script
echo "Mining started in the background. Check miner.log for output."
