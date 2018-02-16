FROM armhf/alpine:3.4
MAINTAINER Robert Doering <rdoering.info@gmail.com>

ENV QEMU_EXECVE 1
COPY ./crossbuild-tools /usr/bin

RUN apk --update add nodejs gifsicle optipng avahi-dev
RUN npm install -g bower grunt-cli