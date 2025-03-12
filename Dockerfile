FROM alpine:3.21

LABEL mainteiner="Dmitrii Trotskii"
LABEL email="dmitrii.trotskii@gmail.com"
LABEL function="Ansible with kerberos authentification for psrp"

ENV ANSIBLE_HOME=/etc/ansible

RUN apk add --no-cache --update \
    ansible \
    curl \
    gcc \
    git \
    krb5 \
    krb5-dev \
    krb5-libs \
    musl-dev \
    openssh-client \
    python3 \
    python3-dev \
    py3-pip \
    sshpass

RUN pip install pypsrp --break-system-packages --root-user-action ignore && \
    pip install pypsrp[kerberos] --break-system-packages --root-user-action ignore

RUN mkdir -p ${ANSIBLE_HOME} && ansible-config init --disabled > ${ANSIBLE_HOME}/ansible.cfg && \
    sed -i 's/;host_key_checking=True/host_key_checking=False/' /etc/ansible/ansible.cfg && \
    ansible-galaxy collection install microsoft.ad

RUN echo "StrictHostKeyChecking no" >> $(find /etc -iname ssh_config) && \
    echo "UserKnownHostsFile=/dev/null" >> $(find /etc -iname ssh_config)

RUN git config --global http.sslVerify false

CMD ["/sbin/init"]
