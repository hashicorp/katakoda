Now, test to understand how a token inherits the capabilities from its associating group.

<img src="https://s3-us-west-1.amazonaws.com/education-yh/7-entity-3.png" alt="Groups"/>

Login as bob with userpass auth method:

```
vault login -method=userpass username="bob" \
      password="training"
```{{execute}}


Test to see if the token has an access to the following paths:

- `secret/data/test`:  
  ```
  vault token capabilities secret/data/test
  ```{{execute}}

- `secret/data/training_test`:  
  ```
  vault token capabilities secret/data/training_test
  ```{{execute}}

- `secret/data/team/qa`:  
  ```
  vault token capabilities secret/team/qa
  ```{{execute}}

- `secret/data/team/eng`:  
  ```
  vault token capabilities secret/team/qa
  ```{{execute}}
