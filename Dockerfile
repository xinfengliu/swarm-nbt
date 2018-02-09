FROM golang:1.9.4-alpine3.7 AS builder

ARG GOOS
ARG GOARCH


COPY . /go/src/github.com/xinfengliu/swarm-nbt
WORKDIR /go/src/github.com/xinfengliu/swarm-nbt

RUN set -ex && apk add --no-cache --virtual .build-deps git && go get github.com/tools/godep && \
GOARCH=$GOARCH GOOS=$GOOS CGO_ENABLED=0 godep go install -v -a -tags netgo -installsuffix netgo -ldflags "-w -X github.com/xinfengliu/swarm-nbt/version.GITCOMMIT=$(git rev-parse --short HEAD) -X github.com/xinfengliu/swarm-nbt/version.BUILDTIME=$(date -u +%FT%T%z)"  && \
apk del .build-deps

FROM alpine:3.7
COPY --from=builder /go/bin/swarm-nbt /go/bin/swarm-nbt

EXPOSE 3443
ENTRYPOINT ["/go/bin/swarm-nbt"]
