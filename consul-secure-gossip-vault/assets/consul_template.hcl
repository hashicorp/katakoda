# This denotes the start of the configuration section for Vault. All values
# contained in this section pertain to Vault.
vault {
  # This is the address of the Vault leader. The protocol (http(s)) portion
  # of the address is required.
  address      = "http://localhost:8200"

  # This value can also be specified via the environment variable VAULT_TOKEN.
  token        = "root"

  # This should also be less than or around 1/3 of your TTL for a predictable
  # behaviour. Consult https://github.com/hashicorp/vault/issues/3414
  # grace        = "1s"

  # This tells consul-template that the provided token is actually a wrapped
  # token that should be unwrapped using Vault's cubbyhole response wrapping
  # before being used. Consult Vault's cubbyhole response wrapping documentation
  # for more information.
  unwrap_token = false

  # This option tells consul-template to automatically renew the Vault token
  # given. If you are unfamiliar with Vault's architecture, Vault requires
  # tokens be renewed at some regular interval or they will be revoked. Consul
  # Template will automatically renew the token at half the lease duration of
  # the token. The default value is true, but this option can be disabled if
  # you want to renew the Vault token using an out-of-band process.
  # If you are using the Vault root token for the configuration you should set 
  # this value to false.
  renew_token  = false
}

# This block defines the configuration for a template. Unlike other blocks,
# this block may be specified multiple times to configure multiple templates.
template {
  # This is the source file on disk to use as the input template. This is often
  # called the "consul-template template".
  source      = "/opt/consul/templates/gossip.key.tpl"

  # This is the destination path on disk where the source template will render.
  # If the parent directories do not exist, consul-template will attempt to
  # create them, unless create_dest_dirs is false.
  destination = "/opt/consul/gossip/gossip.key"

  # This is the permission to render the file. If this option is left
  # unspecified, consul-template will attempt to match the permissions of the
  # file that already exists at the destination path. If no file exists at that
  # path, the permissions are 0644.
  perms       = 0700

  # This is the optional command to run when the template is rendered. The
  # command will only run if the resulting template changes.
  command     = "echo New gossip key available"
}