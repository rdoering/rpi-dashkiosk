FROM armhf/alpine:3.4

ENV QEMU_EXECVE 1
COPY . /usr/bin
