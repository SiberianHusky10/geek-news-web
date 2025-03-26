FROM node:lts-alpine AS build-stage

LABEL maintainer="husky"

WORKDIR /project/geek-news-web

COPY . .

RUN yarn install

RUN yarn build

FROM nginx:stable-alpine AS production-stage

COPY --from=build-stage /project/geek-news-web/dist /usr/share/nginx/html
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]