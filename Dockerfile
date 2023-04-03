FROM amd64/node:16-alpine AS builder

WORKDIR /app
COPY . .

RUN npm install
RUN npm run build --production


FROM nginx:1.23.3-alpine

COPY --from=builder /app/dist /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]