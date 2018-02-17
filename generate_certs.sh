#!/bin/sh
openssl req \
	-new \
	-newkey rsa:2048 \
	-days 3650 \
	-nodes \
	-x509 \
	-subj '/C=US/ST=Oregon/L=Portland/CN=127.0.0.1' \
	-keyout certs/domain.key \
	-out certs/domain.crt
