import * as grpc from '@grpc/grpc-js';
import {GreeterClient} from './helloworld_grpc_pb.js';
import pb from './helloworld_pb.js';

//const {GreeterClient} = p1
const { HelloRequest, HelloReply } = pb

const client = new GreeterClient(
  'localhost:50051',
  grpc.credentials.createInsecure() 
);

export async function sayHello(name:string):Promise<string> {
  const request = new HelloRequest();
  request.setName(name); 
  const response = await new Promise<HelloReply>((resolve, reject) => {
    client.sayHello(request, (err, response: HelloReply) => {
      if (err) reject(err);
      resolve(response);
    });
  });

  return Promise.resolve(response.getMessage());
}