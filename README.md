# Playground

### Golang request info API with Traefik using proxy reverse and load balancing.

#### Starting API and Traefik

```sh
make up
```

#### Scale API service

```sh
make scale-api INSTANCIES={{number_instance}}
```

#### To see load balancing in operation

- Access http://info.docker.localhost
- Observer the hostname by changing