FROM --platform=linux/amd64 node:lts-alpine AS build

RUN apk add git yarn --update-cache && \
	rm -rf /var/cache/apk/*

WORKDIR /app

RUN chown node:node /app

USER node

RUN git clone https://github.com/calendso/calendso.git . && \
	yarn install && \
	yarn build

FROM --platform=amd64 node:lts-alpine

ENV BASE_URL="http://localhost:3000"

COPY docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh

RUN chmod +x /usr/local/sbin/docker-entrypoint.sh

USER node

COPY --from=build /app /app

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["/bin/sh", "/usr/local/sbin/docker-entrypoint.sh"]
CMD ["npm", "run", "start"]