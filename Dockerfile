FROM balenalib/raspberrypi3-alpine:latest
ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
# EXPOSE 80

COPY . /src

RUN [ "cross-build-start" ]
RUN cd /src && ./build.sh "$(cat VERSION)"

ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && chmod +x ./build.sh && sleep 1 && sync && ./build.sh "$(cat VERSION)-custom"
RUN [ "cross-build-end" ]
