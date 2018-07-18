from jenkins/jenkins:lts

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh bitbucket

# install Notifications and Publishing plugins
RUN /usr/local/bin/install-plugins.sh email-ext
RUN /usr/local/bin/install-plugins.sh mailer
RUN /usr/local/bin/install-plugins.sh slack

# Artifacts
RUN /usr/local/bin/install-plugins.sh htmlpublisher

# UI
RUN /usr/local/bin/install-plugins.sh greenballs
RUN /usr/local/bin/install-plugins.sh simple-theme-plugin

# Scaling
RUN /usr/local/bin/install-plugins.sh kubernetes
RUN /usr/local/bin/install-plugins.sh bitbucket-scm-filter-jira-validator
RUN /usr/local/bin/install-plugins.sh publish-to-bitbucket
RUN /usr/local/bin/install-plugins.sh cloudbees-bitbucket-branch-source
RUN /usr/local/bin/install-plugins.sh docker-plugin


# install Maven
USER root

RUN set -ex; \
	apt-get update ; \
	apt-get install apt-transport-https \
	curl \
	gnupg2 \
	software-properties-common \
	build-essential -y
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -; \
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - ; \
	add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" 
	# apt-key add --import /tmp/apt-key.gpg; \

COPY kubernetes.list /etc/apt/sources.list.d/
RUN apt-get update ; \
	apt-get install -y kubectl docker-ce; \
	gpasswd -a jenkins docker

COPY helm /usr/local/bin/
USER jenkins
