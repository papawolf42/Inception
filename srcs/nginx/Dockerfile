FROM alpine:3.16.1

ARG SSL_PATH=/etc/ssl

RUN apk --no-cache upgrade && apk add nginx openssl

WORKDIR $SSL_PATH
RUN openssl genrsa -out private/ssl.key 2048; \
	openssl req -x509 -new -key private/ssl.key -out certs/ssl.crt \
	-subj "/C=KR/ST=Seoul/L=Gangnam-gu/O=Innovation Academy/OU=42Seoul/CN=localhost/emailAddress=papawolf@kakao.com"; \
	chown -R www-data:www-data .; \
	find . -type d | xargs chmod 700; \
	find . -type f | xargs chmod 600;

COPY ./default.conf /etc/nginx/http.d/default.conf

COPY ./run.sh /scripts/
RUN chmod -R 755 /scripts

ENTRYPOINT ["/scripts/run.sh"]
