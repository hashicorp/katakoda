An application similar to this could be scheduled via cron, run periodically as
a [Nomad batch
job](https://www.nomadproject.io/docs/job-specification/periodic.html), or
executed in a variety of other ways. You could also modify it to re-wrap a
limited number of records at a time so as to not put undue strain on the
database. The final implementation should be based upon the needs and design
goals specific to each organization or application.
