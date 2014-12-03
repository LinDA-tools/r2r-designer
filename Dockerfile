FROM       ubuntu:14.04
MAINTAINER robert.danitz@fokus.fraunhofer.de

RUN useradd -m -s /bin/bash lein
RUN echo lein:lein | chpasswd

RUN apt-get update
RUN apt-get install -qq -y curl git openjdk-7-jdk
RUN curl http://sparqlify.org/downloads/releases/debian/sparqlify_0.6.1+201306041824_all.deb > /root/sparqlify_0.6.1+201306041824_all.deb
RUN dpkg -i /root/sparqlify_0.6.1+201306041824_all.deb
RUN apt-get -f install -qq -y

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
RUN chmod 0755 /usr/local/bin/lein
RUN export LEIN_ROOT="ok" ; lein upgrade
ENV LEIN_ROOT "ok"
RUN lein version

#ENV     HOME /home/lein
#USER    lein

RUN git clone https://github.com/LinDA-tools/r2r-designer.git /root/r2r-designer
WORKDIR /root/r2r-designer

RUN lein deps

EXPOSE 3000 9000
