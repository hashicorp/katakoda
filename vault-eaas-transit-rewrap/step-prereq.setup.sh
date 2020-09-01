# Install the Microsoft package repositories
# to install the `dotnet` binary.

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

apt-get update

apt-get install -y dotnet-sdk-2.1