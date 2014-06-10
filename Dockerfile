FROM stackbrew/ubuntu:precise

MAINTAINER robert.danitz@fokus.fraunhofer.de

RUN echo "Etc/UTC" | tee /etc/timezone ; dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update
RUN apt-get install -y python-software-properties curl git vim locales apt-file ca-certificates less manpages manpages-dev openssh-client sudo
RUN echo "LANG=en_US.UTF-8" | tee /etc/default/locale ; dpkg-reconfigure --frontend noninteractive locales
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y install oracle-java7-installer

RUN git clone https://github.com/LinDA-tools/r2r-designer.git
WORKDIR r2r-designer

RUN curl -o /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod 0755 /usr/bin/lein
#RUN /usr/sbin/useradd -m -r -s /bin/bash leinuser
RUN export LEIN_ROOT="ok" ; /usr/bin/lein upgrade
ENV LEIN_ROOT "ok"
#USER leinuser
CMD ["/usr/bin/lein","run"]
