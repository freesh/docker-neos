ARG nodeversion=6
FROM node:$nodeversion-alpine

ENV SASS_BINARY_PATH=/usr/lib/node_modules/node-sass/build/Release/binding.node
ENV SKIP_SASS_BINARY_DOWNLOAD_FOR_CI true
ENV SKIP_NODE_SASS_TESTS true
# install node-sass
RUN apk add --no-cache --virtual .nodeize-deps-configure make gcc g++ python git \
    && mkdir /home/node/yarn \
    && chown node:node /home/node/yarn \
# install libsass
    && git clone https://github.com/sass/sassc && cd sassc && \
    git clone https://github.com/sass/libsass && \
    SASS_LIBSASS_PATH=/sassc/libsass make && \
    mv bin/sassc /usr/bin/sassc && \
    cd ../ && rm -rf /sassc \
# created node-sass binary
    && git clone --recursive https://github.com/sass/node-sass.git && \
    cd node-sass && \
    git submodule update --init --recursive && \
    npm install && \
    node scripts/build -f && \
    cd ../ && rm -rf node-sass \
# add binary path of node-sass to .npmrc
    && touch $HOME/.npmrc && echo "sass_binary_cache=${SASS_BINARY_PATH}" >> $HOME/.npmrc \
    && apk del .nodeize-deps-configure \
