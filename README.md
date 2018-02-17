# Local Dev Registry

A quick-start local docker registry with persistent storage for
development purposes. SSL setup included because:
_reasons_.

## Dependencies

- OpenSSL
- Docker

## Setup

- Clone this repo.
- Run `make` in the directory this repo was cloned to. 

## Examples

### Push an Image

- `docker tag your/thing:v1 127.0.0.1:443/thing:v1`
- `docker push 127.0.0.1:443/thing:v1`
- `docker rmi 127.0.0.1:443/thing:v1`

### Pull an Image

- `docker pull 127.0.0.1:443/thing:v1` 

### Run an Image

- `docker run -it 127.0.0.1:443/thing:v1` 

