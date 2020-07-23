# Remove the existing minikube
sudo minikube delete
rm /usr/local/bin/minikube

# Update minikube version
sudo apt install conntrack -y
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.12.0/minikube-linux-amd64 \
  && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

# Install kubectl v1.18.0
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin

# Install Helm 3 and overwrite Helm 2
curl -LO https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz
tar -xvf helm-v3.2.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/bin/
