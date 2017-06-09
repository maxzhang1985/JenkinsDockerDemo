#!/bin/bash

docker stop myweb

docker rm myweb

docker build --rm -t dotnetweb .

docker run --name myweb -p 5000:80  -d dotnetweb