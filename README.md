//BUILD DOCKER

docker build -t 42 .

//RUN DOCKER

docker run -it --rm -p 80:80 -p 443:443 -e autoindex=on 42
