# This creates a container image that can be used to build Ladybird using Fedora
#
# It assumes that you will run the container image from a directory where the
# Ladybird source has been checked out.
#
# After building the container image, it is *required* that you run the container
# as a rootless container with the `--userns=keep-id` setting:
#
# podman run --rm --userns=keep-id -v $(pwd):/workspace:z ladybird-builder
#
FROM registry.fedoraproject.org/fedora:latest

# Install build dependencies for Ladybird browser
# Based on Documentation/BuildInstructionsLadybird.md
RUN dnf install -y \
    autoconf-archive \
    automake \
    ccache \
    cmake \
    curl \
    git \
    libdrm-devel \
    liberation-sans-fonts \
    libglvnd-devel \
    libtool \
    nasm \
    ninja-build \
    patchelf \
    perl-FindBin \
    perl-IPC-Cmd \
    perl-lib \
    perl-Time-Piece \
    qt6-qtbase-devel \
    qt6-qttools-devel \
    qt6-qtwayland-devel \
    tar \
    unzip \
    zip \
    zlib-ng-compat-static \
    gcc \
    gcc-c++ \
    python3 \
    && dnf clean all

# Set working directory
WORKDIR /workspace

# Configure git and build with python script
CMD ["bash", "-c", "test -f ./Meta/ladybird.py && git config --global --add safe.directory /workspace && ./Meta/ladybird.py run"]
