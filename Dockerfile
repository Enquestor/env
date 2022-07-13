FROM ubuntu:latest

RUN apt-get update
RUN apt-get install curl python3 python3-distutils sudo -y
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py

RUN python3 -m pip install ansible
RUN ansible --version

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ARG user=enquestor
RUN useradd -m -s /bin/bash -g sudo ${user}
USER ${user}
WORKDIR /home/${user}/ansible
COPY . .

RUN ansible-playbook -u ${user} -i ansible_hosts env.yml