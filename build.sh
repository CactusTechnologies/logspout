#!/bin/sh
set -e
apk add --update go build-base git mercurial ca-certificates glide
mkdir -p /go/src/github.com/gliderlabs
cp -r /src /go/src/github.com/gliderlabs/logspout
cd /go/src/github.com/gliderlabs/logspout
echo "Architecture"
uname -a 
export GOPATH=/go

# go get github.com/Masterminds/glide
# echo "Installed glide package, now using to install dependencies..."
#$GOPATH/bin/glide install
glide install
echo "Glide finished installing...let's build something"
go build -ldflags "-X main.Version=$1" -o /bin/logspout
echo "Done building!"
apk del go git mercurial build-base
rm -rf /go /var/cache/apk/* /root/.glide

# backwards compatibility
ln -fs /tmp/docker.sock /var/run/docker.sock
