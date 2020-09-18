Alphabet defines a set of characters (UTF-8) that is used for FPE to determine the validity of plaintext and ciphertext values.

To list existing alphabets, execute the following command.

```
vault list transform/alphabet
```{{execute T1}}

**Built-in alphabets:**

| Alphabets                  | Description                                  |
|----------------------------|----------------------------------------------|
| builtin/numeric            | Numbers
| builtin/alphalower         | Lower-case letters
| builtin/alphaupper         | Upper-case letters
| builtin/alphanumericlower  | Numbers and lower-case letters
| builtin/alphanumericupper  | Numbers and upper-case letters
| builtin/alphanumeric       | Numbers and letters

If the built-in alphabets do not match the allowed set of characters, create a new alphabet to satisfy your need.

```
vault write transform/alphabet/non-zero-numeric alphabet="123456789"
```{{execute T1}}
