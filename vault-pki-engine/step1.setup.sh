sudo tee /etc/systemd/system/vault.service > /dev/null <<EOF
[Unit]
Description=Vault
Requires=network-online.target
After=network-online.target

[Service]
Restart=on-failure
PermissionsStartOnly=true
ExecStartPre=/sbin/setcap 'cap_ipc_lock=+ep' /usr/local/bin/vault
ExecStart=/usr/local/bin/vault server -dev -dev-root-token-id=root -dev-listen-address=0.0.0.0:8200
ExecReload=/bin/kill -HUP \$MAINPID
KillSignal=SIGTERM
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable vault
sudo systemctl start vault

sleep 5

export VAULT_ADDR=http://0.0.0.0:8200
ufw allow 8200/tcp

vault login root
