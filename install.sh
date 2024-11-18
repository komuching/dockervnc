#!/bin/bash

# Run VNC container
echo "Running VNC container..."
docker run -d --user 0 -p 5901:5901 -p 6901:6901 -e VNC_PASSWORD=. --name vnc --shm-size=512m --restart=always dorowu/ubuntu-desktop-lxde-vnc

# Create Docker volume for Portainer
echo "Creating Portainer data volume..."
docker volume create portainer_data

# Run Portainer container
echo "Running Portainer container..."
docker run -d --user 0 -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# Create network named 'tunnel'
echo "Creating Docker network 'tunnel'..."
docker network create tunnel

# Connect containers to the 'tunnel' network
echo "Connecting containers to the 'tunnel' network..."
docker network connect tunnel vnc
docker network connect tunnel portainer

echo "Setup complete."
