NAME := registry
KEY := certs/domain.key
CRT := certs/domain.crt

.PHONY: all clean run stop

all: run

clean: stop
	rm certs/*
	rm -fr var/lib/registry/*

$(CRT): $(KEY)
	openssl req \
		-new \
		-days 3650 \
		-nodes \
		-x509 \
		-subj '/C=US/ST=Oregon/L=Portland/CN=127.0.0.1' \
		-key $< \
		-out $@

$(KEY):
	openssl genrsa -out $@ 2048

run: stop $(CRT)
	docker run -d \
	  --restart=always \
	  --name $(NAME) \
	  -v `pwd`/certs:/certs \
	  -v `pwd`/var/lib/registry:/var/lib/registry \
	  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
	  -e REGISTRY_HTTP_TLS_CERTIFICATE=$(CRT) \
	  -e REGISTRY_HTTP_TLS_KEY=$(KEY) \
	  -p 443:443 \
	  registry:2

stop: 
	docker stop $(NAME) 2>/dev/null | xargs docker rm $(NAME) 2>/dev/null ; true

