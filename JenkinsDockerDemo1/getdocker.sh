#!/bin/bash

docker stop myweb

docker rm myweb

docker build --rm -t dotnetweb .

docker run --name myweb -d -p 60000:60000   dotnetweb