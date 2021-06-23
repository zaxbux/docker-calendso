FROM node:lts-alpine

COPY docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
RUN chmod +x /usr/local/sbin/docker-entrypoint.sh

WORKDIR /app

RUN chown node:node /app

USER node

COPY package.json .

RUN npm install -D

WORKDIR /app/prisma

EXPOSE 5555

ENTRYPOINT ["/bin/sh", "/usr/local/sbin/docker-entrypoint.sh"]
CMD ["npx", "prisma", "studio"]