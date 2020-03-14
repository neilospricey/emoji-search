FROM node:12.2.0-alpine

WORKDIR /app

COPY / /app/

ENV PATH /app/node_modules/.bin:$PATH

CMD ["npm", "start"]