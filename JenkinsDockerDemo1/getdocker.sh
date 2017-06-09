docker stop myweb

docker rm myweb

docker build --rm -t dotnetweb .

docker run --name myweb  -d dotnetweb