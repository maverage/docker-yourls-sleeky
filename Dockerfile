FROM yourls:fpm-alpine
MAINTAINER https://github.com/maverage/docker-yourls-sleeky

# the following content is inspired by https://github.com/YOURLS/docker-yourls/blob/master/fpm-alpine/Dockerfile

ENV SLEEKY_VERSION 2.1.1
ENV SLEEKY_SHA256 9adb685d90f3eedead91c7f948d39112be59d7de7cc136be19cb5f189ebe757e

RUN set -eux; \
    curl -o sleeky.tar.gz -fsSL "https://github.com/Flynntes/Sleeky/archive/v${SLEEKY_VERSION}.tar.gz"; \
    echo "$SLEEKY_SHA256 *sleeky.tar.gz" | sha256sum -c -; \
# upstream tarballs include ./Sleeky-${SLEEKY_VERSION}/ so this gives us /usr/src/Sleeky-${SLEEKY_VERSION}
    tar -xf sleeky.tar.gz -C /usr/src/; \
# install plugin to /usr/src/yourls, see https://github.com/Flynntes/Sleeky#quick-start
    mv "/usr/src/Sleeky-${SLEEKY_VERSION}/sleeky-frontend" /usr/src/yourls; \
    mv "/usr/src/Sleeky-${SLEEKY_VERSION}/sleeky-backend" /usr/src/yourls/user/plugins; \
# future: automatically activate plugin? Currently needs to be activated manually in admin panel
# clean up
    rm sleeky.tar.gz; \
    rm -r "/usr/src/Sleeky-${SLEEKY_VERSION}"; \
    chown -R www-data:www-data /usr/src/yourls/sleeky-frontend; \
    chown -R www-data:www-data /usr/src/yourls/user/plugins/sleeky-backend
