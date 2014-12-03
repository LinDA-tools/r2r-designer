FROM       ubuntu
MAINTAINER robert.danitz@fokus.fraunhofer.de

RUN useradd -m -s /bin/bash linda
RUN echo linda:linda | chpasswd

RUN apt-get update
RUN apt-get install -qq -y curl git openjdk-7-jre-headless postgresql-client-9.3 
ADD ./sparqlify-cli_0.6.13~20141022194127_all.deb /tmp/sparqlify.deb
RUN dpkg -i /tmp/sparqlify.deb
RUN apt-get -f install -qq -y

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
RUN chmod 0755 /usr/local/bin/lein
RUN export LEIN_ROOT="ok" ; lein upgrade

ENV     HOME /home/linda
USER    linda

RUN git clone https://github.com/LinDA-tools/r2r-designer.git /home/linda/r2r-designer
WORKDIR /home/linda/r2r-designer
