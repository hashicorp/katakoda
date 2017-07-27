# Interacting with Nomad
The nomad command line tool is incredibly powerful... blah blah  
We have configured a Nomad and Consul server for you in this environment, to check everything is up and running execute
the following command in the terminal window.  

`nomad server-members`{{execute}}

## Running a job
Jobs can be started in nomad using the `nomad run` command, why not try this now with the example job.

`nomad run httpecho.hcl`{{execute}}

## Job Status
To check the status of a job use the `nomad status [job name]` command, you can inspect the status of the job we have
just started with the following command:

`nomad status http-echo`{{execute}}
