
First, you will configure your environment to be able to interact with the Consul agent.

In this hands-on lab the Docker container is forwarding port `8500` to the local machine. You should be able to interact with it without having to be inside the container.

`export CONSUL_HTTP_ADDR=localhost:8500`{{execute T1}}

### Bootstrap ACLs

You need to bootstrap the ACL system to start using ACLs.

Run `consul acl bootstrap | tee consul.bootstrap`{{execute T1}} to bootstrap the ACL system, generate your first token, and capture the output into the `consul.bootstrap` file.

If you receive an error saying "The ACL system is currently in legacy mode.", this indicates that the Consul service is still starting. Wait a few seconds and try the command again.

Example Output

```
$ consul acl bootstrap | tee consul.bootstrap
AccessorID:       e57b446b-2da0-bce2-f01c-6c0134d8e19b
SecretID:         bba19e7c-9f47-2b08-f0ea-e1bca43ba9c5
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      2020-02-20 17:01:13.105174927 +0000 UTC
Policies:
   00000000-0000-0000-0000-000000000001 - global-management
```

<div style="background-color:#fcf6ea; color:#866d42; border:1px solid #f8ebcf; padding:1em; border-radius:3px;">
  <p><strong>Warning: </strong>
  In this hands-on lab, you are redirecting the output of the `consul acl bootstrap` command to a file to simplify operations in the next steps. In a real-life scenario, you want to make sure the bootstrap token is stored in a safe place. If it is compromised, the ACL system can be abused.
</p></div>


