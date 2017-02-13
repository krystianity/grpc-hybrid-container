# grpc-hybrid-container
- nodejs webservice backed by a c++ dispatcher using grpc
- both servers living in the same container
- node.js app running as supervisor

## installation

### easy way (docker):
- requires Docker
- simply run `./build.sh 1` (will take some time!)
- and run the docker-image via `./run.sh 1`
- check `http://localhost:8080/hello?user=hans`

### hard way (local-dev):
- requires protoc >= 3.0.0 & grpc >= 1.0.0
- you need to install grpc for C++ (check https://github.com/grpc/grpc/blob/master/INSTALL.md if you are NOT using LINUX)
- `[sudo] apt-get install build-essential autoconf libtool`
- `git clone -b v1.0.0 https://github.com/grpc/grpc`
- `cd grpc`
- `git submodule update --init`
- `make`
- `[sudo] make install`
- and you will need protobuf
- `cd third_party/protobuf`
- `make`
- `[sudo] make install`
- with lprotobuf and lgrpc++ in place you can now compile `./cpp`
- just run `npm run compile`
- to run the server call `npm run server`
- to install the client (node server) in `./node`
- just run `npm install`
- followed by `npm start`
- to run the supervisor (starts both c++ server and nodejs app)
simply run `npm run supervisor`
- check `http://localhost:8080/hello`

## benchmarking
- the app exposes 2 endpoints `/hello` and `/plain`
- /hello calls the c++ server and lets it run fib(28)
- /plain does not call the c++ server and runs fib(28) in nodejs
- fib() is used to emulate CPU work
- (make sure your local setup or docker container is running..)
- install wrk via `[sudo] apt install wrk` if you havent already
- run the benchmark via `./wrk.sh`
- (obviously node.js is not made for CPU intense work, which is
not what I want to prove here)

## other stuff
- although this works quite well out of the box, depending on your
infrastructure it is probably a better way to scale the independent gRpc
services on their own
- license is MIT (c) 2017 Christian Fröhlingsdorf
- feel free to contact me with questions @krystianity