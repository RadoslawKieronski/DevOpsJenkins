FROM jenkins/jenkins

USER root

RUN apt-get update && \
    apt-get install -y python && \
    curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python get-pip.py

RUN pip install ansible --upgrade

USER jenkins
