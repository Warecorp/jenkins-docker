FROM jenkins/jenkins:lts-alpine


# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh bitbucket ;\
	/usr/local/bin/install-plugins.sh email-ext ;\
	/usr/local/bin/install-plugins.sh mailer ;\
	/usr/local/bin/install-plugins.sh slack ;\
	/usr/local/bin/install-plugins.sh htmlpublisher ;\
	/usr/local/bin/install-plugins.sh greenballs ;\
	/usr/local/bin/install-plugins.sh simple-theme-plugin ;\
	/usr/local/bin/install-plugins.sh kubernetes ;\
	/usr/local/bin/install-plugins.sh bitbucket-scm-filter-jira-validator ;\
	/usr/local/bin/install-plugins.sh publish-to-bitbucket ;\
	/usr/local/bin/install-plugins.sh cloudbees-bitbucket-branch-source ;\
	/usr/local/bin/install-plugins.sh docker-plugin
USER root
# COPY helm /usr/local/bin/
RUN set -ex; \
	apk add --no-cache docker rsync; \
	wget -qO- "https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl" -O /usr/local/bin/kubectl ;\
	chmod 777 /usr/local/bin/kubectl
# 	apt-get update ; \
# 	apt-get install --no-install-recommends apt-transport-https \
# 	apt-get update ; \
# 	apt-get install --no-install-recommends curl \
# 	gnupg2 \
# 	rsync \
# 	software-properties-common \
# 	build-essential -y
# RUN	curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \
# 	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -	
# RUN	add-apt-repository \
#       "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
#       $(lsb_release -cs) \
#       stable" ;\
# 	apt-get update ; \
# 	apt-get install -y kubectl docker-ce; \
# 	gpasswd -a jenkins docker
USER jenkins
