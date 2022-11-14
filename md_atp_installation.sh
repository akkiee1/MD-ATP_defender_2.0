#!/bin/bash
cd $(dirname "$0")
systemctl --user daemon-reload
sudo apt update
sudo apt install curl -y
curl -o microsoft.list https://packages.microsoft.com/config/ubuntu/$(lsb_release -r | grep -E '^Re.*[0-9]{2}.([0-9]{2})$' | awk '{print $2}')/prod.list
sudo mv ./microsoft.list /etc/apt/sources.list.d/microsoft-prod.list
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt update
sudo apt install -y libplist-utils gpg gnupg apt-transport-https mdatp
sudo python3 MicrosoftDefenderATPOnboardingLinuxServer.py
sudo mv /etc/opt/microsoft/mdatp/managed/mdatp_onboard.json /etc/opt/microsoft/mdatp/managed/mdatp_onboard.json_old
sudo cp ./mdatp_onboard.json /etc/opt/microsoft/mdatp/managed/
echo "DONE!!!"
