FROM alpine:3.13

RUN set -ex && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash \
    bind-tools \
    busybox-extras \
    curl \
    jq \
    openssl \
    util-linux \
    vim

CMD ["/bin/bash"]
