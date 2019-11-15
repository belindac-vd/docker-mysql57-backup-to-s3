FROM quay.io/ukhomeofficedigital/mysql:v0.5.4

USER root
RUN apt-get update \
      && apt-get -y install python-pip \
      && pip install pip \
      && pip install awscli \
      && pip install awscli --upgrade

RUN mkdir -p /data /scripts \
    && chmod 777 /data

COPY files/backup.sh /scripts/backup.sh

USER 1000

CMD ["/scripts/backup.sh"]
