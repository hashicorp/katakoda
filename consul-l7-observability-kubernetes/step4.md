
Install the application with the following command.

`kubectl apply -f app`{{execute interrupt T1}}

You should receive output similar to the following:

```plaintext
service/frontend-service created
...TRUNCATED
deployment.apps/public-api created
```

### Verify the installation

Verify the installation using the following command:

`watch kubectl get pods`{{execute T1}}

Once all pods have a status of `Running` the installation is complete.

```plaintext
NAME                                                         READY   STATUS    RESTARTS   AGE
...
frontend                                                     3/3     Running   0          120m
...
postgres                                                     3/3     Running   0          120m
products-api                                                 3/3     Running   0          120m
...
public-api                                                   3/3     Running   0          120m
```

Next, issue the following command, which, in a separate terminal, will forward port `80` from the `frontend` pod hosting the UI to the development
host's port `8080`.

`kubectl port-forward deploy/frontend 8080:80 --address 0.0.0.0`{{execute T2}}

You will receive the following output.

```plaintext
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
```

Now, open the HashiCups UI tab next to the Terminal tab in the Katacoda environment. This will launch a new browser tab. If the UI doesn't load immediately,
wait a minute and try again. The app take some time to initialize even
after the pods are marked as running.
