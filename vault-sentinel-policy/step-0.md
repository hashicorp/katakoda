Confirm that the Sentinel simulator is available.

```shell
which sentinel && sentinel version
```{{execute}}

The example CIDR check EGP from the presentation along with a set of tests is available in the `workshop-one` directory.

```shell
tree workshop-one
```{{execute}}

The output should list 2 directories and 3 files. 

```
workshop-one
├── cidr-check.sentinel
└── test
    └── cidr-check
        ├── fail.json
        └── success.json

2 directories, 3 files
```

If everything is present, proceed to step 1 otherwise try the command again and proceed only when there are 2 directories and 3 files present.
