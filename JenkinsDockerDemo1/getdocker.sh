sudo docker build --rm -t dotnetweb .
sudo docker run --name myweb -p 80:8090 -d dotnetweb