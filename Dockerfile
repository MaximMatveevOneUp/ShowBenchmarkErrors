FROM node:18-alpine3.15

WORKDIR /app
COPY . /app

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]

