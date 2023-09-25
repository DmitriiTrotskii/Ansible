FROM alpine:3.18

LABEL mainteiner="Dmitrii Trotskii"
LABEL email="dmitrii.trotskii@gmail.com"
LABEL function="Ansible with kerberos authentification for psrp"

RUN apk add --no-cache --update \
    ansible
