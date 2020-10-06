In order to verify the policy works properly, you will need to create tokens and
check the success and failure cases. You will learn more about tokens
later; for now, you can use the provided commands to generate appropriate tokens
for your policies.

Create an app-dev token. For this guide, pipe your output into the tee command
to save it as `app-dev.token`.

```
nomad acl token create -name="Test app-dev token" \
  -policy=app-dev -type=client | tee ~/app-dev.token
```{{execute}}

**Example Output**

```
$ nomad acl token create -name="Test app-dev token" \
  -policy=app-dev -type=client | tee ~/app-dev.token
Accessor ID  = b8c67cb8-cc3b-2a7c-182a-0bc5dfc3a6ff
Secret ID    = 17cadb8b-e8a8-2f47-db62-fea0c6a19602
Name         = Test app-dev token
Type         = client
Global       = false
Policies     = [app-dev]
Create Time  = 2020-02-10 18:41:43.049735 +0000 UTC
Create Index = 14
Modify Index = 14
```

Next, create a prod-ops token, piping your output into the tee command to save
it as `prod-ops.token`.

```
nomad acl token create -name="Test prod-ops token" \
  -policy=prod-ops -type=client | tee ~/prod-ops.token
```{{execute}}

**Example Output**

```
$ nomad acl token create -name="Test prod-ops token" \
  -policy=prod-ops -type=client | tee ~/prod-ops.token
Accessor ID  = 4e3c1ac7-52d0-6c68-94a2-5e75f17e657e
Secret ID    = 0be3c623-cc90-3645-c29d-5f0629084f68
Name         = Test prod-ops token
Type         = client
Global       = false
Policies     = [prod-ops]
Create Time  = 2020-02-10 18:41:53.851133 +0000 UTC
Create Index = 15
Modify Index = 15
```
