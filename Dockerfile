FROM       ubuntu
MAINTAINER robert.danitz@fokus.fraunhofer.de

RUN useradd -m -s /bin/bash lein
RUN echo lein:lein | chpasswd

RUN apt-get update
RUN apt-get install -qq -y curl git openjdk-7-jdk

RUN curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
RUN chmod 0755 /usr/local/bin/lein
RUN export LEIN_ROOT="ok" ; lein upgrade
ENV LEIN_ROOT "ok"
RUN lein version

ENV     HOME /home/lein
USER    lein

RUN git clone https://github.com/LinDA-tools/r2r-designer.git /home/lein/r2r-designer
WORKDIR /home/lein/r2r-designer

RUN lein deps

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/lein"]
