FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates \
    locales \
    python3-pip \
    python3 \
    python3-setuptools \
    gawk \
		libssl-dev \
    libffi-dev \
    asciinema

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

VOLUME "/tmp/output"

WORKDIR /root/
COPY requirements.txt /root/
#RUN pip3 install -U pip
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . /root/

CMD "/root/run.sh"
