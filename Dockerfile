FROM alpine:3.8

RUN apk update
RUN apk add docker
RUN apk add git
RUN apk add bash

WORKDIR /workspace
COPY . .

VOLUME [ "/var/run/docker.sock" ]
ENTRYPOINT [ "./build.sh" ]

