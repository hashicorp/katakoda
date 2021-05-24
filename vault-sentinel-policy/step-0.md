Confirm that the Sentinel simulator is available.

```shell
which sentinel && sentinel version
```{{execute}}

The example CIDR check EGP from the presentation along with a set of tests is available in the `sentinel` directory.

```shell
tree
```{{execute}}

The output should include the `sentinel` directory:

```
.
├── sentinel
│   ├── cidr-check.sentinel
│   └── test
│       └── cidr-check
│           ├── fail.json
│           └── success.json
└── setup.sh

4 directories, 5 files
```

If the directory exists, proceed to the next step; otherwise, try the command again and proceed only when files are loaded.
