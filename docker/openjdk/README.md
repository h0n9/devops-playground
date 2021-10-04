# OpenJDK
**NOTE:** This docker image is kind of a sample template that can be applied to
Spring Boot project which runs on OpenJDK JAVA. It is not possible to build
docker image with the template itself. Instead, the following files should be
placed into a Spring Boot project:
```bash
openjdk
├── DOCKER
│   └── docker-entrypoint.sh
├── Dockerfile
├── Makefile
├── README.md
├── build.gradle
└── src
    └── main
        └── resources
            ├── application-dev.yaml
            ├── application-prd.yaml
            └── application.yaml
```
