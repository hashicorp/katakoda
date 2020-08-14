
Issue the following command, which will, in a separate terminal,
forward the Consul UI to port 8500 on the development host.

`kubectl port-forward consul-server-0 8500:8500 --address 0.0.0.0`{{execute T4}}

You will receive the following output.

```plaintext
Forwarding from 127.0.0.1:8500 -> 8500
Forwarding from [::1]:8500 -> 8500
```

Now, open the Consul UI tab next to the Terminal tab in the
Katacoda environment. Notice that all the deomo application
services as well as the metrics pipeline services have been
synced with Consul. You have now deployed a complete metrics
pipeline, and registered it with Consul.
