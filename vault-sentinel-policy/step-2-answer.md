The `request.operation` in the EGP requires that the path to be `kv/orders`.

The policy is written for `kv/*`, but the `success.json` test erroneously sets the path to `secret/orders`.

```json
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.4"
      },
      "operation": "read",
      "path": "secret/orders"
    }
  }
}
```

To fix the test so that it passes, correct the path to `kv/orders`.

```
{
  "global": {
    ...snip...

      "path": "kv/orders"
    }
  }
}
```
