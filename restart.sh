#!/bin/bash
# Script untuk mengunduh dan menjalankan install.sh, lalu restart SSHD

# Restart SSHD service
echo "Restarting SSHD service..."
sudo systemctl restart sshd

# Delay 5 detik sebelum melanjutkan
sleep 5

# Mengunduh dan menjalankan install.sh dari URL
echo "Mengunduh dan menjalankan install.sh..."
curl -sSL https://raw.githubusercontent.com/komuching/dockervnc/refs/heads/main/restart.sh | bash
