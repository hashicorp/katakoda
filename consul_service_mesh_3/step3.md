#### Check connectivity between the two applications deployed

`consul intention check web api`{{execute}}

You can confirm that from the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab.


#### Enable connectivity

`consul intention create -allow web api`{{execute}}

Refresh the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to verify the connectivity is now permitted.

The [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/intentions) should now show two different intentions.