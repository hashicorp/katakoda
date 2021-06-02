The environment consists of a Vault server and three Consul servers.

The agents are running as Docker containers but you can consider them as Virtual
Machines each containing all the binaries necessary for the environment setup.

The startup should end with a list of environment variables that will help you
setup your terminal environment.

First configure the environment:

`source ./assets/secrets/consul_env.conf`{{execute T1}}

`source ./assets/secrets/vault_env.conf`{{execute T1}}

Then you can check the Consul agents using the `consul members` command.

`consul members`{{execute T1}}

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  This lab launches Vault in dev mode. This is not suggested for production.
</p></div>