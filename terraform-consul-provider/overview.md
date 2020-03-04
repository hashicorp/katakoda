## Overview of Workspace

This is the workspace for **Getting Started with Terraform Consul Provider**.

This workspace contains the following:

- simple Consul datacenter running with ACL pre-configured (UI on port [:8500](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui)):
    - 3 Consul servers
    - 2 Consul clients
- Counting service running on port [:9001](https://[[HOST_SUBDOMAIN]]-9001-[[KATACODA_HOST]].environments.katacoda.com)
- Dashboard for counting service running on port [:8080](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com)

These services can be open by clicking on their respective tabs in the terminal.

On initialization, this workspace should have ran `docker-compose up -d` which spins
up the above services in the background. To view these instances, run `docker ps`{{execute}}

It takes about a minute after you see the `Ready` message for the Consul datacenter
to nominate a cluster leader and for you to continue to the next step.

## Retrieve Master ACL Token
To retrieve the master ACL token, run `docker exec -it consul-playground_consul-server-1_1 consul acl bootstrap`{{execute}}

This runs the `consul acl bootstrap` command on one of Consul agents. The output
 should be similar to this:

```
AccessorID:       aaf45cbf-2293-59f8-dacb-d473e35d111c
SecretID:         91f5e30c-c51b-8399-39bb-a902346205c4
Description:      Bootstrap Token (Global Management)
Local:            false
Create Time:      2020-02-19 21:36:04.9283912 +0000 UTC
Policies:
   00000000-0000-0000-0000-000000000001 - global-management
```

If you see `Failed ACL bootstrapping: Unexpected response code: 500 (The ACL system is currently in legacy mode.)`,
the Consul datacenter has not nominated a cluster leader yet. Please wait before
rerunning the command.

## View Consul Agents using ACL Token
The SecretID is your Consul Master ACL Token. To verify that this token works, run:
`docker exec -it consul-playground_consul-server-1_1 consul members -token=<TOKEN>`{{execute}}
replacing `<TOKEN>` with your Master ACL Token. 

If successful, the output should be 
similar to this:

```
Node          Address          Status  Type    Build  Protocol  DC   Segment
53559b91bb91  172.29.0.3:8301  alive   server  1.7.0  2         dc1  <all>
87f38aef301d  172.29.0.2:8301  alive   server  1.7.0  2         dc1  <all>
aea8b638b48c  172.29.0.6:8301  alive   server  1.7.0  2         dc1  <all>
0d69f754b8fd  172.29.0.7:8301  alive   client  1.7.0  2         dc1  <default>
477484ae7f62  172.29.0.5:8301  alive   client  1.7.0  2         dc1  <default>
e553a7b10918  172.29.0.4:8301  alive   client  1.7.0  2         dc1  <default>
```

## Configure Consul UI with ACL Token
Finally, to configure your Consul UI to use the ACL token, open the [Consul UI](https://[[HOST_SUBDOMAIN]]-8500-[[KATACODA_HOST]].environments.katacoda.com/ui/dc1/acls/tokens). 
Then, navigate to the ACL page using the menu at the top. You should see a page 
like this:

![Consul ACL Page](/im2nguyen/scenarios/terraform-consul-provider/assets/consul-acl.png)

Enter your Master ACL Token into the text box and hit Save. After refreshing 
your page, you should be able to view your Consul resources via the UI.