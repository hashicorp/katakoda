A Vault [role](https://www.vaultproject.io/docs/secrets/azure/index.html#roles)
lets you configure either an existing service principal or a set of Azure roles.

Create a Vault role named, `edu-app` mapped to the Azure role named,
`Contributor` in the `vault-education` resource group.

```shell
vault write azure/roles/edu-app ttl=1h azure_roles=-<<EOF
    [
      {
        "role_name": "Contributor",
        "scope": "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/vault-education"
      }
    ]
EOF
```{{execute}}

The role named `edu-app` is created.