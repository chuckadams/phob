FROM alpine:3.13 as phob-build

RUN apk add --no-cache \
    autoconf \
    bison \
    ccache \
    clang \
    g++ \
    gcc \
    lld \
    make \
    re2c \
	argon2-dev \
	bzip2-dev \
	curl-dev \
	gd-dev \
	gettext-dev \
	gmp-dev \
	icu-dev \
	krb5-dev \
	libffi-dev \
	libsodium-dev \
	libxml2-dev \
	libzip-dev \
	oniguruma-dev \
	openldap-dev \
	openssl-dev \
	pcre2-dev \
	postgresql-dev \
	readline-dev \
	sqlite-dev

RUN adduser --disabled-password build
COPY --chown=build . /build/phob

USER build
WORKDIR /build/phob

RUN ./build.sh

