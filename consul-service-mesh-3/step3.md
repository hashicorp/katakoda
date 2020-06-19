Now that all service communication is denied by default, the web service can no longer connect to the api service. 

#### Check connectivity between the two services

`consul intention check web api`{{execute}}

You can confirm that the services cannot communicate from the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab. Both services will be displayed in red boxes. 

#### Enable connectivity

Now, you will need to create a Consul intention to allow communication between the services. 

`consul intention create -allow web api`{{execute}}

Refresh the [Dashboard](https://[[HOST_SUBDOMAIN]]-9090-[[KATACODA_HOST]].environments.katacoda.com/ui) tab to verify the connectivity is now permitted.

The [Consul UI](https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/ui/minidc/intentions) should now show two different intentions.
