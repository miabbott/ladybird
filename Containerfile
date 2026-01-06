FROM fedora:latest

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

# Verify minimum cmake version (3.25+ required)
RUN cmake --version

# Create a non-root user for building
RUN useradd -m -u 1000 -s /bin/bash builder

# Set working directory and change ownership
WORKDIR /workspace
RUN chown builder:builder /workspace

# Switch to non-root user
USER builder

# Configure git to trust the workspace directory
RUN git config --global --add safe.directory /workspace

# build with python script
CMD ./Meta/ladybird.py run
