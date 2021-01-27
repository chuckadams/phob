FROM alpine:3.13 as phob-build

RUN apk add --no-cache \
    autoconf \
    bison \
    g++ \
    gcc \
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

RUN adduser --disabled-password --no-create-home build
COPY --chown=build . /build/phob

USER build
WORKDIR /build/phob

RUN ./buildconf && CC=clang CXX=clang++ LD=ld.lld ./configure \
    --prefix=/opt/phob \
    --enable-fpm \
    --enable-phpdbg \
    --enable-debug \
    --enable-debug-assertions \
    --with-openssl \
    --with-kerberos \
    --with-system-ciphers \
    --with-external-pcre \
    --with-pcre-jit \
    --with-zlib \
    --enable-bcmath \
    --with-bz2 \
    --enable-calendar \
    --with-curl \
    --with-ffi \
    --enable-ftp \
    --enable-gd \
    --with-external-gd \
    --with-gettext \
    --with-gmp \
    --enable-intl \
    --with-ldap \
    --with-ldap-sasl \
    --enable-mbstring \
    --with-mysqli \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-pdo-sqlite \
    --with-pgsql \
    --with-readline \
    --enable-shmop \
    --enable-sockets \
    --with-sodium \
    --with-password-argon2 \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --with-zip \
    --enable-mysqlnd

RUN make clean
RUN make -j$(nproc)

# RUN ./sapi/cli/php -m
# RUN sed -i "s/run-tests.php -n -c/run-tests.php -j$(nproc) -n -c/" Makefile && make test


