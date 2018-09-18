Now, test to understand how a token inherits the capabilities from its associating group.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/7-entity-3.png" alt="Groups"/>

Login as `bsmith` with userpass auth method:

```
vault login -method=userpass username="bsmith" \
      password="training"
```{{execute T2}}

Upon a successful authentication, a token will be returned. Notice that the output displays **`token_policies`** and **`identity_policies`**. The generated token has both `base`, `team-qa` and `team-eng` policies attached.

```
Key                    Value
---                    -----
...
token_policies         ["default" "team-qa"]
identity_policies      ["base" "team-eng"]
policies               ["base" "default" "team-eng" "team-qa"]
```

Test to see if the token has an access to the following paths:

- `secret/data/test`:  
  ```
  vault token capabilities secret/data/test
  ```{{execute T2}}

- `secret/data/training_test`:  
  ```
  vault token capabilities secret/data/training_test
  ```{{execute T2}}

- `secret/data/team/qa`:  
  ```
  vault token capabilities secret/data/team/qa
  ```{{execute T2}}

- `secret/data/team/eng`:  
  ```
  vault token capabilities secret/data/team/eng
  ```{{execute T2}}
