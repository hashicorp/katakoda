```
                    ____
                  .'* *.'
               __/_*_*(_
              / _______ \     _______
             _\_)/___\(_/_   < Hello,
            / _((\- -/))_ \      Vault. >
            \ \   (-)   / /      ------
             ' \___.___/ '
            / ' \__.__/ ' \
           / _ \ - | - /_  \
          (   ( .;''';. .'  )
          _\"__ /    )\ __"/_
            \/  \   ' /  \/
             .'  '...' ' )
              / /  |  \ \
             / .   .   . \
            /   .     .   \
           /   /   |   \   \
         .'   /    b    '.  '.
     _.-'    /     Bb     '-. '-._
 _.-'       |      BBb       '-.  '-.
(________mrf\____.dBBBb.________)____)
```

The administrator is a human client that requires the ability to manage secrets
stored, revoking database credentials, and key rotations. Admins typically
authenticate through an identity provider like *GitHub*. To make exploration
easier *userpass* is enabled and a the user name `admin` was created.

Show the `admin` user.

```shell
clear
vault read auth/userpass/users/admins
```{{execute}}

The `admins` user is assigned the `admins-policy` policy.

Show the `admins-policy` policy.

```shell
vault policy read admins-policy
```{{execute}}

The policy contains comments about future admin requirements.

As the Vault server only maintains the latest version of the policy. A local
copy of the policy is maintained on this workstation.

Open the `admins-policy.hcl`{{open}} policy file in the editor.

This file matches the contents defined on the Vault server.

You are ready to implement the admin's requirements.
