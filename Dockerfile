# FROM node.js LTS
FROM node:boron

RUN apt-get update && apt-get install -y \
  build-essential autoconf libtool \
  git \
  pkg-config \
  && apt-get clean

ENV GRPC_RELEASE_TAG v1.0.0

RUN git clone --depth=1 -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc /var/local/git/grpc

# install grpc
RUN cd /var/local/git/grpc && \
    git submodule update --init && \
    make && \
    make install && make clean

#install protoc
RUN cd /var/local/git/grpc/third_party/protobuf && \
    make && make install && make clean

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

#compile server
RUN npm run make

EXPOSE 8080
CMD [ "npm", "run", "supervisor" ]