The `request.operation` in the EGP requires that the path to be `kv/orders`.

The `success.json` test erroneously sets the path to `secret/orders`.

```json
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.4"
      },
      "operation": "read",
      "path": "kv/orders"
    }
  }
}
```

To fix the test so that it passes, correct the path to `secret/orders`.

```json
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.4"
      },
      "operation": "create",
      "path": "kv/orders"
    }
  }
}
```
