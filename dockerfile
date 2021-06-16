FROM node:14.0.0 as builder

WORKDIR /cowallet

COPY . .

ENV APP_ENV="prod"
ENV API_BASE="https://api.mixin.one"
ENV OAUTH_URL="https://oauth.getlinks.jp"
ENV CLIENT_ID="0db25065-35f2-4ab8-8046-788dc844e003"

RUN yarn
RUN yarn generate

FROM nginx:1.12-alpine

COPY --from=builder /cowallet/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
