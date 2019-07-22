FROM yourls:fpm-alpine
MAINTAINER https://github.com/maverage/docker-yourls-sleeky

# the following content is inspired by https://github.com/YOURLS/docker-yourls/blob/master/fpm-alpine/Dockerfile

ENV SLEEKY_VERSION 2.1.1
ENV SLEEKY_SHA256 9ADB685D90F3EEDEAD91C7F948D39112BE59D7DE7CC136BE19CB5F189EBE757E

RUN set -eux; \
    curl -o sleeky.tar.gz -fsSL "https://github.com/Flynntes/Sleeky/archive/$v{SLEEKY_VERSION}.tar.gz"; \
    echo "$SLEEKY_SHA256 *sleeky.tar.gz" | sha256sum -c -; \
# upstream tarballs include ./Sleeky-${SLEEKY_VERSION}/ so this gives us /usr/src/Sleeky-${SLEEKY_VERSION}
    tar -xf sleeky.tar.gz -C /usr/src/; \
# install plugin to /usr/src/yourls, see https://github.com/Flynntes/Sleeky#quick-start
    mv "/usr/src/Sleeky-${SLEEKY_VERSION}/sleeky_frontent" /usr/src/yourls; \
    mv "/usr/src/Sleeky-${SLEEKY_VERSION}/sleeky_backend" /usr/src/yourls/user/plugins; \
# future: automatically activate plugin? Currently needs to be activated manually in admin panel
# clean up
    rm sleeky.tar.gz; \
    rm -r "/usr/src/Sleeky-${SLEEKY_VERSION}"; \
    chown -R www-data:www-data /usr/src/yourls/sleeky_frontent; \
    chown -R www-data:www-data /usr/src/yourls/user/plugins/sleeky_backend
