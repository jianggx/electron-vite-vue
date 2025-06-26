BASEDIR=$(dirname "$0")
PROTOC_GEN_TS_PATH="../node_modules/.bin/protoc-gen-ts"

# 生成代码
grpc_tools_node_protoc \
  --js_out=import_style=commonjs,binary:../electron/main/grpc \
  --grpc_out=grpc_js:../electron/main/grpc \
  --plugin=protoc-gen-ts=${PROTOC_GEN_TS_PATH} \
  --ts_out=service=grpc-node,mode=grpc-js:../electron/main/grpc \
  -I ./ ./*.proto   

# the `package` from .proto file
PB_PACKAGENAME="helloworld"
SERVICE_VAR="GreeterService"

# 生成代码

for file in $(find ../electron/main/grpc -maxdepth 1 -name "*_pb.js" ! -name "*_grpc_pb.js"); do
  echo "$file"
  sed -i '' -e "s/var jspb = require('google-protobuf');/import jspb from 'google-protobuf';/g" "$file"
  sed -i '' -e "s/goog\.object\.extend(exports, proto\.$PB_PACKAGENAME);/export default proto.$PB_PACKAGENAME;/g" "$file"

done

# ends with _grpc_pb.js
for file in ../electron/main/grpc/*_grpc_pb.js; do
  echo "$file"
  PREFIX=$(basename "$file" "_grpc_pb.js")
  echo "$PREFIX"
  sed -i '' -e "s/var grpc = require('@grpc\/grpc-js');/import grpc from '@grpc\/grpc-js'/g" "$file"
  sed -i '' -e "s/var ${PREFIX}_pb = require('.\/${PREFIX}_pb.js');/import ${PREFIX}_pb from '.\/${PREFIX}_pb.js'/g" "$file"

  sed -i '' -e "s/var $SERVICE_VAR = exports\.$SERVICE_VAR =/export const $SERVICE_VAR =/g" "$file"

  sed -i '' -e "s/exports\.\(.*\) =/export const \1 =/g" "$file"
done

