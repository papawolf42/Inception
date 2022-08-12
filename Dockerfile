# docker build . -t inception
# docker cp /Users/gunkim/Inception Inception:/root;

# Step 1 : From image
FROM debian:buster
LABEL maintainer="gunwoo kim <gunkim@student.42seoul.kr>"

RUN apt-get update && apt-get -y install \
	curl \
	git \
	vim \
	zsh \
	sudo \
	postgresql \
	ca-certificates \
    gnupg \
    lsb-release; \
	rm -rf /var/lib/apt/lists/*; \
	zsh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" ||true \
	ln -f /bin/zsh /bin/sh; \
	apt update && apt-get -y install make;

RUN sudo mkdir -p /etc/apt/keyrings; \
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg; \
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null; \
	apt-get update && apt-get -y install \
	docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose;
