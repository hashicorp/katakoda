# RabbitMQ: install and start the server
sudo apt-get update
sudo apt-get -y install rabbitmq-server --fix-missing
sudo service rabbitmq-server start

# RabbitMQ: enable HTTP management port
sudo rabbitmq-plugins enable rabbitmq_management

# RabbitMQ: create user and add the administrator tag
sudo rabbitmqctl add_user learn_vault hashicorp
sudo rabbitmqctl set_user_tags learn_vault administrator

# Vault: install custom-built Vault 1.5 binary
wget https://lynn-vault-binaries.s3.us-east-2.amazonaws.com/vault
sudo mv ./vault /usr/local/bin/vault
sudo chmod a+x /usr/local/bin/vault