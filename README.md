# docker-protoc-gen-grpc-web

```
$ docker run -it -v "$(pwd):/protoc" bash
# protoc -I=. --js_out=import_style=commonjs,binary:out --grpc-web_out=import_style=commonjs,mode=grpcweb:out test.proto
```