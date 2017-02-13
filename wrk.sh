#!/usr/bin/env bash
wrk -t3 -c9 -d10s http://localhost:8080/hello
wrk -t3 -c9 -d10s http://localhost:8080/plain