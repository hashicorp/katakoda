Enter the following command to see the Vault server status.  

> Click on the command (`⮐`) will automatically copy it into the terminal and execute it.

```
vault status
```{{execute T1}}

Login with the generated root token.

```
vault login root
```{{execute T1}}

**Now, you are ready to explore Vault CLI!**

> **Important Note:** Without a valid license, Vault Enterprise server will be sealed after ***30 minutes***. In other words, you have 30 free minutes to explorer the Enterprise features. To explore Vault Enterprise further, you can [sign up for a free 30-day trial](https://www.hashicorp.com/products/vault/trial).


## Vault UI

Click on the **Vault UI** tab to launch the Vault UI.

![](https://education-yh.s3-us-west-2.amazonaws.com/screenshots/katacoda-vault-ui.png)

Enter **`root`** in the **Token** text field and then click **Sign In**.
