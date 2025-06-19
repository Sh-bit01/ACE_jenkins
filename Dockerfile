# Use Alpine Linux as the base image
FROM alpine:latest

# Maintainer info
LABEL maintainer="shreyashgondane.eidiko@gmail.com"

# Install required packages
RUN apk update && apk add --no-cache \
    bash \
    curl \
    shadow \
    libc6-compat \
    tar \
    sudo \
    ca-certificates \
    openjdk11

# Copy ACE installation directory
COPY ace-12.0.2.0/ /opt/ace-12.0.2.0/

# Create ACE user and add to necessary groups
RUN adduser -D ace && \
    echo "ace ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    usermod -aG wheel ace && \
    usermod -aG mqbrkrs ace

# Set working directory
WORKDIR /opt/ace-12.0.2.0

# Accept license and make ACE registry global
RUN ./ace make registry global accept license silently

# Set ACE environment for all future shells
RUN echo ". /opt/ace-12.0.2.0/server/bin/mqsiprofile" >> /home/ace/.bashrc

# Expose all ports (not recommended in production, but per your request)
EXPOSE 7600-7900
EXPOSE 4000-5000

# Switch to ACE user
USER ace

# Default command
CMD ["/bin/sh"]

