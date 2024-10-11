Also on dockerhub:

https://hub.docker.com/r/donuk/basicauth

Proxy hub.docker.com with basic authentication:

```
docker run -p 80:80 -e BACKEND=hub.docker.com -e LOGIN=my_user:my_password -e LOGIN2=my_other_user:my_other_password AUTH_REASON="Private Area" --rm donuk/basicauth
```
