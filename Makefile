build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o info