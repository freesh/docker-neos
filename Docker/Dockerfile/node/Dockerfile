ARG nodeversion=6
FROM node:$nodeversion-alpine

# need this for node-sass
RUN apk add --no-cache make gcc g++ python

# for production build
#RUN apk add --no-cache --virtual .build-deps make gcc g++ python \
# && npm install --production --silent \
# && apk del .build-deps