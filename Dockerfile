# Bismillahirrahmanirraheem
FROM ubuntu:20.04

WORKDIR /root/.local
RUN mkdir bin

ENV MY_INSTALL_DIR=/root/.local
ENV PATH=$PATH:$MY_INSTALL_DIR/bin

ARG DEBIAN_FRONTEND=noninteractive 
ARG TZ=Africa/Lagos
RUN apt update && apt install -y cmake \
    build-essential \
    autoconf \
    libtool \
    pkg-config \
    git

WORKDIR /app
RUN git clone --recurse-submodules -b v1.36.0 https://github.com/grpc/grpc.git && \
    cd grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR ../.. && \
    make -j && \
    make install && \
    cd /app && \
    rm -rf grpc
