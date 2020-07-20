# Remove the existing minikube
sudo minikube delete
rm /usr/local/bin/minikube

# Update minikube version
sudo apt install conntrack -y
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.12.0/minikube-linux-amd64 \
  && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
