FROM golang:1.17 as builder

WORKDIR /workspace
ARG GIT_COMMIT

# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

# Copy the go source
COPY src ./src

# Build
RUN go build -ldflags "-linkmode external -extldflags '-static' -s -w" -o smartping -gcflags "all=-N -l" src/smartping.go

FROM scratch
WORKDIR /
ADD conf /conf
ADD db/database-base.db db/
ADD html html
COPY --from=builder /workspace/smartping .
ENTRYPOINT ["/smartping"]
EXPOSE 8899
