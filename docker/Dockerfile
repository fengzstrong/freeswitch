FROM centos:7
MAINTAINER Byron Zhang <byronzhang@lexin.com>
# explicitly set user/group IDs
RUN groupadd -r freeswitch --gid=888 && useradd -r -g freeswitch --uid=888 freeswitch
# Install gosu.  https://github.com/tianon/gosu
ENV GOSU_VERSION=1.14
RUN gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu \
    # Verify that the binary works
    && gosu nobody true

RUN yum -y install epel-release
RUN yum -y install git which autoconf automake gcc-c++ sqlite-devel mysql-devel unixODBC-devel \ 
	libtool libjpeg-devel libcurl-devel speex-devel yasm make libedit-devel lua-devel libsndfile-devel
# 拷贝源码包
# COPY freeswitch /usr/src/freeswitch 
RUN git clone https://github.com/fengzstrong/freeswitch.git /usr/src/freeswitch
RUN cd /usr/src/freeswitch && ./bootstrap.sh -j && ./configure && make -j`nproc` && make install

COPY docker-entrypoint.sh /
### 8021 fs_cli, 5060 5061 5080 5081 sip and sips, 64535-65535 rtp
EXPOSE 8021/tcp
EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5061/tcp 5061/udp 5081/tcp 5081/udp
EXPOSE 7443/tcp
EXPOSE 5070/udp 5070/tcp
EXPOSE 64535-65535/udp
EXPOSE 16384-32768/udp
# Limits Configuration
COPY build/freeswitch.limits.conf /etc/security/limits.d/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["freeswitch"]
