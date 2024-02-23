# Use a base Python image
#jb and te were here ;)
FROM python:3.8-slim

 

# Install Ansible and other common dependencies

RUN pip install ansible

 

# Install additional dependencies for cloud providers

RUN pip install boto boto3 openshift ansible[azure]

 

# Install SSH client for remote host connectivity

RUN apt-get update && apt-get install -y ssh

 

# Install curl

RUN apt-get install -y curl

 

# Install kubectl

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \

    && chmod +x kubectl \

    && mv kubectl /usr/local/bin/

 

# Create a working directory

WORKDIR /ansible

 

 

ENV ANSIBLE_GATHERING smart

ENV ANSIBLE_HOST_KEY_CHECKING false

ENV ANSIBLE_RETRY_FILES_ENABLED false

ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles

ENV ANSIBLE_SSH_PIPELINING True

ENV PYTHONPATH /ansible/lib

ENV PATH /ansible/bin:$PATH

ENV ANSIBLE_LIBRARY /ansible/library

 

ENTRYPOINT ["ansible-playbook"]
