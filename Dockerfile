# Use alpine linux as base image.
FROM alpine:3.21

# Install mumble-server.
RUN apk add --no-cache \
        murmur \
        curl

# Create mumble user and group environment variables.
ARG MUMBLE_UID=1000
ARG MUMBLE_GID=1000

# Create mumble user and group.
RUN addgroup \
        --gid $MUMBLE_GID \
        mumble && \
    adduser \
        --disabled-password \
        --no-create-home \
        --uid $MUMBLE_UID \
        --ingroup mumble \
        mumble

# Set the mumble-server configuration directory owner.
RUN mkdir -p /config && \
    chown -R mumble:mumble /config

# Set the mumble-server configuration directory
# as the working directory with mumbe user.
USER mumble
WORKDIR /config

# Expose mumble-server ports.
EXPOSE 64738/tcp 64738/udp

# Copy entrypoint script.
COPY --chown=mumble:mumble entrypoint.sh /entrypoint.sh

# Start mumble-server.
VOLUME ["/config"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/mumble-server", "-fg"]
