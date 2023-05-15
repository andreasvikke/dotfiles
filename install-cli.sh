#!/bin/bash

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm awscliv2.zip
rm -rf aws

# Install gcloud cli
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-400.0.0-linux-x86_64.tar.gz
tar -xf google-cloud-cli-400.0.0-linux-x86_64.tar.gz
cp -r ./google-cloud-sdk ~/bin/
bash ~/bin/google-cloud-sdk/install.sh --usage-reporting false --command-completion false --path-update false
~/bin/google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin --quiet
rm google-cloud-cli-400.0.0-linux-x86_64.tar.gz
rm -rf google-cloud-sdk
