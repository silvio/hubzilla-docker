
# introduction

Dockerimage for <https://hubzilla.org>.


# dependencies

* mysql or postgres server


# start

```bash
$ docker run --link mysqlserver -e SERVERNAME=hub.port1024.net -v ${PWD}/hubzilladata:/data -d silviof/hubzilla-docker
```
