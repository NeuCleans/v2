#!/bin/bash
PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

if [ ! -d /usr/local/go ]; then
    sudo curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
    sudo tar -xvf go1.8.linux-amd64.tar.gz
    sudo mv go /usr/local
    sudo rm go1.8.linux-amd64.tar.gz
    echo "export GOPATH=$GOPATH" >> "$VHOME/.profile"
    echo "export PATH=\$PATH:\$GOPATH/bin:/usr/local/go/bin" >> "$VHOME/.profile"
fi

sudo -u vagrant -H bash -c "
id
source ~/.profile

if ! command -V golint ; then
    go get -u github.com/golang/lint/golint
    go get -u golang.org/x/tools/cmd/cover
    go get -u golang.org/x/tools/cmd/goimports
fi

if ! command -V protoc-gen-go ; then
    go get -u github.com/golang/protobuf/...
    go get -u github.com/grpc-ecosystem/grpc-gateway/...
fi

if ! command -V glide ; then
    curl https://glide.sh/get | sh
    # sudo add-apt-repository ppa:masterminds/glide && sudo apt-get update
    # sudo apt-get install glide
fi

if ! command -V migrate ; then
    # go get github.com/mattes/migrate
    # go get -u gopkg.in/mattes/migrate.v1
    # go get github.com/golang-migrate/migrate
    curl -L https://github.com/mattes/migrate/releases/download/v3.0.1/migrate.linux-amd64.tar.gz | tar xvz
    mv migrate.linux-amd64 migrate
    sudo mv migrate /usr/local/bin/
fi

if ! command -V buildifier ; then
    go get -d -u github.com/bazelbuild/buildifier/buildifier
    # generate step is why this isn't Glide-able
    go generate github.com/bazelbuild/buildifier/build
    go install github.com/bazelbuild/buildifier/buildifier
fi

if ! command -V go-bindata ; then
    go get -u github.com/jteeuwen/go-bindata/...
fi

go get -u github.com/gogo/protobuf/...

# used for local filesystem watching
if ! command -V modd ; then
    go get github.com/cortesi/modd/cmd/modd
fi
"
