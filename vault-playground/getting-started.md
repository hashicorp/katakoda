Enter the following command to start the Vault server in development mode.  

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.


```
vault server -dev -dev-root-token-id="root"
```{{execute T1}}



## Login with root token

Click the **+** next to the opened Terminal, and select **Open New Terminal**.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/ops-another-terminal.png" alt="New Terminal"/>

In the **Terminal 2**, set the `VAULT_ADDR` environment variable:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

Login with the generated root token.

```
vault login root
```{{execute T2}}

Now, you are ready to explore Vault CLI.
