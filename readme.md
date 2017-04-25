
# introduction

Dockerimage for <https://hubzilla.org>.


# dependencies

* mysql or postgres server


# start

```bash
$ docker run --link mysqlserver -v ${PWD}/hubzilladata:/data -d silviof/hubzilla-docker
```
