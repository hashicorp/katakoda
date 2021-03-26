Boundary can run in a **dev mode** which is an all-in-one installation method for getting started with Boundary quickly. The dev mode is not a production installation but useful for experiment with Boundary locally.

Boundary dev mode starts:

- A controller server
- A worker server
- A Postgres database

First, install boundary.

```
sudo apt-get update && sudo apt-get install boundary
```{{execute}}

Check the help message for `boundary dev` command.

```
boundary dev -h
```{{execute}}

There are a number of optional parameters available, but for now, start a dev server with default configurations.

```
boundary dev -api-listen-address=0.0.0.0:9200
```{{execute}}


**Example output:**

```
==> Boundary server configuration:

       [Controller] AEAD Key Bytes: MLOunPBTyqFIrfvuftSFKYns+7d1OJIvYh3x3+vajXc=
         [Recovery] AEAD Key Bytes: rUoYQrfgqBPpcsBm1C175oH3kGtq7q1ICVpFWGfrvGo=
      [Worker-Auth] AEAD Key Bytes: qBoyf0BqflM9rA/v+wGosGloM6xI+6UlsDaiBjKVCEY=
              [Recovery] AEAD Type: aes-gcm
                  [Root] AEAD Type: aes-gcm
           [Worker-Auth] AEAD Type: aes-gcm
                               Cgo: disabled
            Dev Database Container: epic_satoshi
                  Dev Database Url: postgres://postgres:password@localhost:32768?sslmode=disable
          Generated Auth Method Id: ampw_1234567890
  Generated Auth Method Login Name: admin
    Generated Auth Method Password: password
         Generated Host Catalog Id: hcst_1234567890
                 Generated Host Id: hst_1234567890
             Generated Host Set Id: hsst_1234567890
            Generated Org Scope Id: o_1234567890
        Generated Project Scope Id: p_1234567890
               Generated Target Id: ttcp_1234567890
                              ...snip...
```

Notice the following default configurations:

- Generated Auth Method Id: `ampw_1234567890`
- Generated Auth Method Login Name: admin
- Generated Auth Method Password: password
