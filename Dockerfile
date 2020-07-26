FROM jenkins/jenkins

ARG JENKINSUID=1000
ARG JENKINSGID=1000
ARG DOCKERGID=998

# Docker
RUN apt-get update \
    && apt-get install software-properties-common apt-transport-https ca-certificates gnupg-agent -y \ 
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" \
    && apt-get update \
    && apt-get install docker-ce-cli -y

# Setup users and groups
RUN groupadd -g ${JENKINSGID} jenkins
RUN groupmod -g ${DOCKERGID} docker
RUN useradd -c "Jenkins user" -g ${JENKINSGID} -G ${DOCKERGID} -M -N -u ${JENKINSUID} jenkins