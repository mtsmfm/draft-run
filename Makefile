.PHONY: all
all: build

.PHONY: build
build:
	go build -o bin/draft-run

GOPATH = $(shell go env GOPATH)
VERSION = $(shell cat VERSION)
.PHONY: release
release: build
release:
	go get github.com/mitchellh/gox
	go get github.com/tcnksm/ghr
	$(GOPATH)/bin/gox --os "windows linux darwin" --arch "386 amd64" --output "dist/draft-run_{{.OS}}_{{.Arch}}"
	$(GOPATH)/bin/ghr -t $(GITHUB_TOKEN) -u mtsmfm -r draft-run --replace v$(VERSION) dist/
