To test our function we can either use the faas-cli or we can call the function directly using the http interface.  First let's see how we can use the faas-cli.

`echo "Nic" | faas-cli invoke --yaml echo.yml echo`{{execute}}

We should see the response

```bash
Nic
```

The faas CLI tool allows us to pipe the input into our function, alternately we could have typed our input when prompted by faas-cli.

We can also directly invoke it from curl or another HTTP client using the gateway URL:

`curl -d 'Nic' https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/function/echo`{{execute}}

That is all that is required to get the most basic function created and deployed,  to see a more comprehensive example including how you can take a Test Driven approach to creating functions why not take a look at my example function for sending Tweets: [OpenFaaS Tweet Function](https://github.com/nicholasjackson/open-faas-functions/tree/master/tweet)
