#!/bin/bash

set -e
exec 3>&1 1>/dev/null

if [[ $USER == "root" ]]
then sudo=""
else sudo=sudo
fi

echo >&3 "Installing Haskell Stack..."
$sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442
echo "deb http://download.fpcomplete.com/ubuntu $(lsb_release -s -c) main" | \
  sudo tee /etc/apt/sources.list.d/fpco.list
$sudo apt-get update
$sudo apt-get -y --allow-unauthenticated install stack git

echo >&3 "Installing docker..."
$sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
  --recv-keys 58118E89F3A912897C070ADBF76221572C52609D &>/dev/null
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" \
  | $sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
$sudo apt-get update >&/dev/null
$sudo apt-get -y install docker-engine &>/dev/null
echo "Adding $USER to the docker group..."
$sudo usermod -aG docker $USER
$sudo chown :$USER /var/run/docker.sock
