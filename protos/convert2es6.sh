#!/bin/bash

# the `package` from .proto file
PB_PACKAGENAME="helloworld"

BASEDIR=$(dirname "$0")
PROTOC_GEN_TS_PATH="../node_modules/.bin/protoc-gen-ts"

# 生成代码
grpc_tools_node_protoc \
  --js_out=import_style=commonjs,binary:. \
  --grpc_out=grpc_js:. \
  --plugin=protoc-gen-ts=${PROTOC_GEN_TS_PATH} \
  --ts_out=service=grpc-node,mode=grpc-js:. \
  -I ./ ./*.proto   
# ends with _pb.js
for file in $(find . -maxdepth 1 -name "*_pb.js" ! -name "*_grpc_pb.js"); do
  echo "$file"
  sed -i "s/var jspb = require('google-protobuf');/import jspb from 'google-protobuf'/g" "$file"

  echo "export default proto.$PB_PACKAGENAME" >> "$file"
done

# ends with _grpc_pb.js
for file in *_grpc_pb.js; do
  PREFIX=$(basename "$file" "_grpc_pb.js")

  sed -i "s|var grpc = require('grpc');|import grpc from '@grpc/grpc-js'|g" "$file"
  sed -i "s|var ${PREFIX}_pb = require('./${PREFIX}_pb.js');|import ${PREFIX}_pb from './${PREFIX}_pb.js'|g" "$file"

  SERVICE_VAR=$(grep -oP "var \K\w+(?= = exports\.)" "$file")
  sed -i "s|var $SERVICE_VAR = exports\.$SERVICE_VAR =|export const $SERVICE_VAR =|g" "$file"

  sed -i "s|exports\.\(\w\+\) =|export const \1 =|g" "$file"
done

