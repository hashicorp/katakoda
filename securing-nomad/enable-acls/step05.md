<style type="text/css">
  .lang-screenshot { -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; }
  .alert { position: relative; padding: .75rem 1.25rem; margin-bottom: 1rem; border: 1px solid transparent; border-radius: .25rem; }
  .alert-info    { color: #0c5460; background-color: #d1ecf1; border-color: #bee5eb; }
</style>

Once the ACL system is enabled, use the [`nomad acl bootstrap` command]. For
this scenario, we will also direct the output of this command into a file using
`tee`.

```shell
nomad acl bootstrap | tee ~/bootstrap.token
```{{execute}}

<div class="alert-info alert">
If you receive a "connect: connection refused" error, you might need to wait a
second for the client to completely start and try again.
</div>


**Example Output**

```
$ nomad acl bootstrap | tee ~/bootstrap.token
Accessor ID  = 5b7fd453-d3f7-6814-81dc-fcfe6daedea5
Secret ID    = 9184ec35-65d4-9258-61e3-0c066d0a45c5
Name         = Bootstrap Token
Type         = management
Global       = true
Policies     = n/a
Create Time  = 2017-09-11 17:38:10.999089612 +0000 UTC
Create Index = 7
Modify Index = 7
```

Once the initial bootstrap is performed, it cannot be performed again unless the
bootstrap reset procedure is complete. Make sure to save this Accessor ID and
Secret ID.

The bootstrap token is a `management` type token, meaning it can perform any
operation. It should be used to setup the ACL policies and create additional ACL
tokens. The bootstrap token can be deleted like any other token. Care should be
taken to not delete all management tokens, otherwise you might have to reset and
re-bootstrap the ACL system.

[`nomad acl bootstrap` command]: https://www.nomadproject.io/docs/commands/acl/bootstrap.html
