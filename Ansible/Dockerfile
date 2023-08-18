FROM jenkins/jenkins

USER root #user

RUN curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python get-pip.py && \
    pip install ansible --upgrade
    
USER jenkins
