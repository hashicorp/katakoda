#### Enable default-deny policy

Using Consul command line from the Consul container you can enable the default-deny policy for your service mesh.

`consul intention create -deny '*' '*'`{{execute}}

### Verify intention is in place

Open [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/intentions) to verify the intention is correclty showed by the UI.
