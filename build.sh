#!/bin/sh
set -x
go get -d -v ./...
go build -ldflags "-X main.revision=1" -o gateway-http cmd/gateway-http/*.go
go build -ldflags "-X main.revision=1" -o sims cmd/sims/*.go
go build -ldflags "-X main.revision=1" -o dataz cmd/dataz/*.go
go build -ldflags "-X main.revision=1" -o terraformer cmd/terraformer/*.go
