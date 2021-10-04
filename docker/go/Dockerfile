# builder
# - golang:1.16.7-alpine3.14
# - multiple stages build
FROM golang:1.16.7-alpine3.14 AS builder
WORKDIR /usr/src/app
# copy go module files first
COPY go.mod .
COPY go.sum .
RUN go mod download
# specify files to copy
COPY main.go .
RUN go build -o app .

# runner
# - alpine3.14
# - time sync
# - add group and user named with app 
# - place binary file to /usr/bin/app/
# - run as app 
# - expose 8080 port
FROM alpine:3.14 AS runner
WORKDIR /usr/bin/app
ENV TZ=Asia/Seoul
ENV TARGET="dev"
RUN apk add tzdata dumb-init
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN addgroup -S app && adduser -S -s /bin/false -G app app
RUN chown -R app:app /usr/bin/app
COPY --from=builder /usr/src/app/app .
COPY DOCKER/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
USER app
EXPOSE 8080
ENTRYPOINT ["docker-entrypoint.sh"]
