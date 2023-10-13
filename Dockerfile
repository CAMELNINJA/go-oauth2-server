# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:1.21


RUN useradd -u 10001 gopher

ENV NAME "go-oauth2-server"

WORKDIR /opt/${NAME}

COPY ../go.mod .
COPY ../go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o ${NAME} .

# User docker-entrypoint.sh script as entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]

# Document that the service listens on port 8080.
EXPOSE 8080
