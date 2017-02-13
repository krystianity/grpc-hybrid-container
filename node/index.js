"use strict";

const path = require("path");
const grpc = require("grpc");
const express = require("express");

function fib(x) {

    if (x === 0)
        return 0;

    if (x === 1)
        return 1;

    return fib(x-1)+fib(x-2);
}

function main() {

    const PROTO_PATH = path.join(__dirname, "../protos/helloworld.proto");
    const hello_proto = grpc.load(PROTO_PATH).helloworld;
    const client = new hello_proto.Greeter("localhost:50051", grpc.credentials.createInsecure());

    const app = express();

    app.get("/hello", (req, res) => {
        const name = req.query.user || "test";
        client.sayHello({ name }, (err, response) => {

            if(err){
                return res.status(500).end(err);
            }

            res.status(200).json(response);
        });
    });

    app.get("/plain", (req, res) => {
        const name = req.query.user || "test";
        fib(28);
        res.status(200).json({ name });
    });

    app.listen(8080, () => {
        process.stdout.write("App listening on http://0.0.0.0:8080");
    });
}

main();