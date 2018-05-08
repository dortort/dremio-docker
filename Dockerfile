FROM centos:latest
MAINTAINER lmangani <lorenzo.mangani@gmail.com>

# PRE-Requirements
RUN yum install -y nano cronie wget sudo initscripts; yum clean all
  && yum clean all

RUN useradd -ms /bin/bash dremio

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-linux-x64.rpm \
  && yum install -y jre-8*.rpm \
  && rm -rf jre*.rpm \
  && yum clean all

RUN wget http://download.dremio.com/community-server/1.3.1-201712020438070881-a7af5c8/dremio-community-1.3.1-201712020438070881_a7af5c8_1.noarch.rpm \
 && yum localinstall -y dremio*.rpm \
 && rm -rf dremio*.rpm

RUN chkconfig --level 3456 dremio on
 
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 9047
ENTRYPOINT ["/run.sh"]
