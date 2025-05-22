FROM alpine:3.19 AS builder

RUN apk add -U curl

ARG ROUTEROS_VERSION=7.18.2

RUN curl -o data.img.zip https://download.mikrotik.com/routeros/${ROUTEROS_VERSION}/chr-${ROUTEROS_VERSION}.img.zip \
    && unzip -p data.img.zip > /data.img

FROM qemux/qemu

ENV KVM="N"
ENV BOOT_MODE="legacy"
ENV BOOT_INDEX="0"
ENV ARGUMENTS="-nographic"
ENV DISK_TYPE="blk"

COPY --from=builder /data.img /storage/data.img
