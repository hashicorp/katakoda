To test your function, you can either use the `faas-cli` command-line tool or
call the function directly using the HTTP interface.

First, use the `faas-cli` command to invoke the function.

`echo "Nic" | faas-cli invoke --yaml echo.yml echo`{{execute}}

You should see the response

```bash
Nic
```

The `faas-cli` command-line tool allows you to pipe input into your function.
You can also type the input when prompted by `faas-cli`.

You can also directly invoke the function from curl or another HTTP client using
the gateway URL.

`curl -d 'Nic' https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/function/echo`{{execute}}

That is all that is required to get the most basic function created and
deployed. The [OpenFaaS Tweet Function][OF_tweet_func] example for sending
tweets is more comprehensive, including how you can take a Test Driven approach
to creating functions.

[OF_tweet_func]: https://github.com/nicholasjackson/open-faas-functions/tree/master/tweet