FROM swift:5.7.0-jammy-slim

ARG PROTOC_VERSION=3.20.1
ARG PROTOC_GEN_GRPC_SWIFT_VERSION=1.10.0
ARG INSTALL_PREFIX=/opt/protoc

RUN apt-get update && \
    apt-get install -y curl unzip

RUN mkdir ${INSTALL_PREFIX} && \
    cd ${INSTALL_PREFIX} && \
    curl -L -o protoc.zip \
        https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-$(arch).zip && \
    unzip protoc.zip && \
    rm -f protoc.zip && \
    curl -L -o protoc-grpc-swift-plugins.zip \
        https://github.com/grpc/grpc-swift/releases/download/${PROTOC_GEN_GRPC_SWIFT_VERSION}/protoc-grpc-swift-plugins-linux-$(arch)-${PROTOC_GEN_GRPC_SWIFT_VERSION}.zip && \
    unzip protoc-grpc-swift-plugins.zip && \
    rm -f protoc-grpc-swift-plugins.zip && \
    chmod +x protoc-gen-grpc-swift && \
    chmod +x protoc-gen-swift && \
    mv protoc-gen-grpc-swift bin/ && \
    mv protoc-gen-swift bin/ 

RUN bash -c "echo '/usr/lib/swift/linux' > /etc/ld.so.conf.d/swift.conf;\
             echo '/usr/lib/swift/clang/lib/linux' >> /etc/ld.so.conf.d/swift.conf;\
             echo '/usr/lib/swift/pm' >> /etc/ld.so.conf.d/swift.conf;\
             ldconfig"

ENV PATH="${INSTALL_PREFIX}/bin:$PATH"

WORKDIR /protoc
