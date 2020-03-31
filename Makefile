.PHONY: build image ci run-image

TAG_NAME := gsabadini/go-info 

build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o main

image:
	docker build -t $(TAG_NAME) .

run-image:
	docker run --publish 8090:8090 --rm -it $(TAG_NAME) 

ci:
	docker run --rm -it -v $(PWD):/app -w /app golangci/golangci-lint:v1.24.0 golangci-lint run