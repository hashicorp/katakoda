The first intention you will create changes the _allow-all_ approach where all traffic is allowed unless denied in specific rules, to a _deny-all_ approach where all traffic is denied and only specific connections are enabled.

#### Enable default-deny policy

Using Consul command line from the Consul container you can enable the default-deny policy for your service mesh.

`consul intention create -deny '*' '*'`{{execute}}

### Verify intention is in place

Open the [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/intentions) to verify the intention is correctly configured. Navigate to the "Intentions" menu option in the top navigation, there should only be the one intention you created.  
