# Go 
**NOTE:** This docker image is kind of a sample template that can be applied to
Go language based project which runs on Alpine OS. It is not possible to build
docker image with the template itself. Instead, the following files should be
placed into Go language based project:
```bash
go
├── DOCKER
│   └── docker-entrypoint.sh
├── Dockerfile
└── README.md
```
