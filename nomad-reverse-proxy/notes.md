## Nota Bene

To make the CORS check pass, you need the Origin value to match the Host value.
Much time was lost in making this scenario by inadvertently setting them by hand
to incompatible values.  For example:

pass in a http_host as the header

```
      proxy_set_header Host $http_host;
```
or override origin

```
      proxy_set_header Origin "${scheme}://${proxy_host}";
```

Doing both introduces the possibility of making them not agree.  If you need to
set both, verify that they agree completely.

```
      proxy_set_header Host $http_host;
      proxy_set_header Origin "${scheme}://${http_host}";
```

