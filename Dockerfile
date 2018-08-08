FROM python:2.7-alpine3.7

# You can build this with different users and home directories
ARG SERVICE_USER
ARG SERVICE_HOME

# Default to user 'app' with home '/home/app'
ENV SERVICE_USER ${SERVICE_USER:-app}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN apk -Uuv add \
    openssh-client \
    git \
    python-dev \
    py-pip && \
    pip install --upgrade pip

# Add the One Login SAML script
RUN git clone https://github.com/idralyuk/samlapi_onelogin.git /one-login \
    && cd /one-login \
    && touch settings.ini \
    && pip install -r requirements.txt \
    && apk del git

COPY ./alpine-harden.sh /root

RUN \
  mkdir -p ${SERVICE_HOME} \
  && adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} \
  && chown -R ${SERVICE_USER}:${SERVICE_USER} ${SERVICE_HOME} \
  && /root/alpine-harden.sh

USER ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME ${SERVICE_HOME}

CMD [ "/one-login/samlapi_onelogin.py" ]
ENTRYPOINT [ "python" ]