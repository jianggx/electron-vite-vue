BASEDIR=$(dirname "$0")
PROTOC_GEN_TS_PATH="../node_modules/.bin/protoc-gen-ts"

# 生成代码
grpc_tools_node_protoc \
  --js_out=import_style=commonjs,binary:../electron/main/grpc \
  --grpc_out=grpc_js:../electron/main/grpc \
  --plugin=protoc-gen-ts=${PROTOC_GEN_TS_PATH} \
  --ts_out=service=grpc-node,mode=grpc-js:../electron/main/grpc \
  -I ./ ./*.proto   

  