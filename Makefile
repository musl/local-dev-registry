NAME           := local-dev-registry

HTTP_PORT_MAP  := 443:443
HTTP_BIND_ADDR := 0.0.0.0:443

SSL_SUBJ       := /C=US/ST=Oregon/L=Portland/CN=127.0.0.1
SSL_DAYS       := 365
SSL_RSA_BITS   := 2048
SSL_KEY        := certs/domain.key
SSL_CRT        := certs/domain.crt

.PHONY: all clean run stop

all: run

clean: stop
	rm -f certs/*
	rm -fr var/lib/registry/*

run: stop $(SSL_CRT)
	docker run -d \
		--restart=always \
		--name $(NAME) \
		-v `pwd`/certs:/certs \
		-v `pwd`/var/lib/registry:/var/lib/registry \
		-e REGISTRY_HTTP_ADDR=$(HTTP_BIND_ADDR) \
		-e REGISTRY_HTTP_TLS_CERTIFICATE=$(SSL_CRT) \
		-e REGISTRY_HTTP_TLS_KEY=$(SSL_KEY) \
		-p $(HTTP_PORT_MAP) \
		registry:2

stop: 
	docker stop $(NAME) 2>/dev/null | xargs docker rm $(NAME) 2>/dev/null ; true

$(SSL_CRT): $(SSL_KEY)
	openssl req \
		-new \
		-days $(SSL_DAYS) \
		-nodes \
		-x509 \
		-subj '$(SSL_SUBJ)' \
		-key $(SSL_KEY) \
		-out $(SSL_CRT)

$(SSL_KEY):
	openssl genrsa -out $(SSL_KEY) $(SSL_RSA_BITS)

