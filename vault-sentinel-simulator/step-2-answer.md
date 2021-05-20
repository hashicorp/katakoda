The `request.operation` in the EGP requires that the path operation be one of "create", "update", or "delete".

The `success.json` test erroneously sets the request to "read".

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

To fix the test so that it passes, replace the "read" operation with either "create", "update", or "delete".

```json
{
  "global": {
    "request": {
      "connection": {
        "remote_addr": "122.22.3.4"
      },
      "operation": "create",
      "path": "secret/orders"
    }
  }
}
```
