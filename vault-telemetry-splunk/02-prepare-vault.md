> Click the command (`⮐`) to automatically copy it into the terminal and execute it.

Now it is time to prepare Vault. You will do the following tasks in this section.

- [Initialize Vault](https://www.vaultproject.io/docs/commands/operator/init)
- [Unseal Vault](https://www.vaultproject.io/docs/commands/operator/unseal)
- [Login](https://www.vaultproject.io/docs/commands/login) with the initial root token
- [Enable a file audit device](https://www.vaultproject.io/docs/audit/file)

The default initialization without arguments results in Vault using the [Shamir's Secret Sharing algorithm](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) to split the unseal key in to 5 key shares with a required quorum of 3 unseal keys needed to successfully unseal Vault.

For this example, you can use just 1 key share to speed up the manual unseal process.

> **NOTE**: You might have noticed that when this step began, a `VAULT_ADDR` environment variable was exported to a URL that represents the Vault docker container. This is done to ensure your commands address the correct server.

First, initialize Vault with 1 key share and a key threshold of 1 while saving the output to the file `.vault-init`.

```shell
vault operator init \
    -key-shares=1 \
    -key-threshold=1 \
    | head -n3 \
    | cat > .vault-init
```{{execute T1}}

This command should produce no output when successful.

Now, unseal Vault with the **Unseal Key 1** value from the `.vault-init` file.

```shell
vault operator unseal $(grep 'Unseal Key 1'  .vault-init | awk '{print $NF}')
```{{execute T1}}

Successful output from unsealing Vault should resemble this example:

```plaintext
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.4.2
Cluster Name    vault-cluster-f6a41c2e
Cluster ID      3a4aca58-eaaf-ae81-6856-8dc8524c9404
HA Enabled      false
```

> **NOTE:** You will use a root token in this scenario for simplicity. However, in actual production environments, root tokens should be closely guarded and used only for tightly controlled purposes. Review the documentation on [root tokens](https://www.vaultproject.io/docs/concepts/tokens#root-tokens) for more details.

Now you can login to Vault with `vault login` by passing the **Initial Root Token** value from `.vault-init` file.

```shell
vault login -no-print \
$(grep 'Initial Root Token' .vault-init | awk '{print $NF}')
```{{execute T1}}

This command should produce no output when successful. If you want to confirm that the login was successful, try a token lookup and confirm that your tokenm policies contain **[root]**.

```shell
vault token lookup | grep policies
```{{execute T1}}

Successful output should contain the following.

```plaintext
policies            [root]
```

Finally, you need to enable a file audit device that Fluentd will read and send to Splunk.

```shell
vault audit enable file file_path=/vault/logs/vault-audit.log
```{{execute T1}}

Successful output should contain the following.

```plaintext
Success! Enabled the file audit device at: file/
```

You are now ready to access the Splunk Web interface and examine some of the existing Vault telemetry metric data.

Click **Continue** to proceed to step 3.
