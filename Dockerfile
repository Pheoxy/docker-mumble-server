FROM alpine:3.20

# Install dependencies
RUN apk add --no-cache \
        bash \
        curl \
        murmur

ARG MUMBLE_UID=1000
ARG MUMBLE_GID=1000

RUN addgroup \
        --gid $MUMBLE_GID \
        mumble && \
    adduser \
        --disabled-password \
        --no-create-home \
        --uid $MUMBLE_UID \
        --ingroup mumble \
        mumble

RUN mkdir -p /config && \
    chown -R mumble:mumble /config

USER mumble
WORKDIR /config
EXPOSE 64738/tcp 64738/udp
COPY entrypoint.sh /entrypoint.sh

# Start mumble-server
VOLUME ["/config"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mumble-server", "-fg"]
