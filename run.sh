#!/bin/sh

docker run -d \
	-p 5000:5000 \
	--restart=always \
	--name registry-dev \
	-v ~/scratch/docker-registry/var/lib/registry:/var/lib/registry \
	registry:2

