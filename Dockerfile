# RUN apk update && apk add --no-cache git
FROM golang:1.14.0-alpine3.11 as builder

RUN apk add --no-cache --virtual .build-deps \
    bash \
    gcc \
    git \
    musl-dev

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
RUN adduser -S -D -H -h /app main
USER main

FROM scratch

COPY --from=builder /app /app

WORKDIR /app

EXPOSE 8090

CMD ["./main"]