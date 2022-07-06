FROM debian:bullseye-slim

ARG PROTOC_VERSION=3.20.1
ARG PROTOC_GEN_GRPC_WEB_VERSION=1.3.1
ARG INSTALL_PREFIX=/opt/protoc

RUN apt-get update && \
    apt-get install -y curl unzip

RUN mkdir ${INSTALL_PREFIX} && \
    cd ${INSTALL_PREFIX} && \
    curl -L -o protoc.zip \
        https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-$(arch).zip && \
    unzip protoc.zip && \
    rm -f protoc.zip && \
    curl -L -o ./bin/protoc-gen-grpc-web https://github.com/grpc/grpc-web/releases/download/${PROTOC_GEN_GRPC_WEB_VERSION}/protoc-gen-grpc-web-${PROTOC_GEN_GRPC_WEB_VERSION}-linux-$(arch) && \
    chmod +x ./bin/protoc-gen-grpc-web

ENV PATH="${INSTALL_PREFIX}/bin:$PATH"

WORKDIR /protoc
