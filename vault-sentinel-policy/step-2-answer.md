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
      "path": "secret/orders"
    }
  }
}
```

To fix the test so that it passes, correct the path to `kv/orders`.

<pre class="file" data-filename="workshop-one/test/cidr-check/success.json" data-target="append">
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
</pre>
