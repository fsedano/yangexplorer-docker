FROM alpine

LABEL maintainer="fran@fransedano.net"

WORKDIR /app

RUN apk add --no-cache bash git python py-pip libxml2-dev libxslt-dev libffi-dev py-crypto gcc python-dev musl-dev openssl-dev && \
    git clone https://github.com/CiscoDevNet/yang-explorer.git

WORKDIR /app/yang-explorer
RUN bash setup.sh -y

RUN apk del musl-dev gcc  && sed -i -e 's/HOST=\x27localhost\x27/HOST=\"0.0.0.0\"/g' start.sh
ENTRYPOINT ["bash", "start.sh"]
