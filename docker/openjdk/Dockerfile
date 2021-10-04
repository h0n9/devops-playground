# builder
# - openjdk 8, alipne
# - multiple stages build
# - unpack jar file to use application, libray layers independently
FROM openjdk:8-jdk-alpine3.9 AS builder
WORKDIR /usr/src/app
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src
RUN ./gradlew build

# runner
# - time sync
# - add group and user named with javauser
# - place jar file to /usr/bin/hello-devops/app.jar
# - run as app 
# - expose 8080 port
FROM openjdk:8-jre-alpine3.9 AS runner
WORKDIR /usr/bin/app
ENV TZ=Asia/Seoul
ENV APP="DevOps-Playground"
ENV TARGET=dev
ENV JAVA_OPTS=""
RUN apk add tzdata dumb-init
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN addgroup -S app && adduser -S -s /bin/false -G app app
RUN chown -R app:app /usr/bin/app
COPY --from=builder /usr/src/app/build/unpacked/lib BOOT-INF/lib
COPY --from=builder /usr/src/app/build/unpacked/app .
COPY DOCKER/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
USER app 
EXPOSE 8080
ENTRYPOINT ["docker-entrypoint.sh"]