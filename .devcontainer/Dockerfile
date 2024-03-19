#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM squidfunk/mkdocs-material:latest

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# install git iproute2, process tools
RUN apk add --no-cache \
    ca-certificates \
    less \
    ncurses-terminfo-base \
    krb5-libs \
    libgcc \
    libintl \
    libssl1.1 \
    libstdc++ \
    tzdata \
    userspace-rcu \
    zlib \
    icu-libs \
    curl \
    git \
    openssh-client \
    less \
    procps \
    gpg \
    bash \
    shadow \
    sudo && \
    apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache lttng-ust && \
    # Download the powershell '.tar.gz' archive \
    curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/powershell-7.4.1-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz && \
    # Create the target folder where powershell will be placed
    mkdir -p /opt/microsoft/powershell/7 && \
    # Expand powershell to the target folder
    tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 && \
    # Set execute permissions
    chmod +x /opt/microsoft/powershell/7/pwsh && \
    # Create the symbolic link that points to pwsh
    ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh && \
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    addgroup -g $USER_GID $USERNAME && \
    adduser -s /usr/bin/pwsh -u $USER_UID -G $USERNAME -D $USERNAME && \
    # [Optional] Add sudo support for the non-root user
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    # Clean up
    apk cache clean && \
    rm /tmp/powershell.tar.gz
USER $USERNAME
ENTRYPOINT [ "/usr/bin/pwsh" ]
