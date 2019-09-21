FROM mhart/alpine-node:12

ENV LIBSASS_VERSION=3.6.1 SASSC_VERSION=3.6.1

RUN apk --update add git build-base libstdc++ make g++ python curl && \
    git clone https://github.com/sass/sassc && \
    cd sassc && git checkout $SASSC_VERSION && \
    git clone https://github.com/sass/libsass && \
    cd libsass && \
    git checkout $LIBSASS_VERSION && \
    cd .. && SASS_LIBSASS_PATH=/sassc/libsass make && \
    mv bin/sassc /usr/bin/sassc && \
    npm install -g --unsafe-perm node-sass@latest
    

RUN curl -L -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && \
  chmod +x /usr/local/bin/dumb-init && \
  apk del git build-base curl && \
  rm -rf /var/cache/apk/* /sassc

ENTRYPOINT ["dumb-init"]
CMD ["node"]


