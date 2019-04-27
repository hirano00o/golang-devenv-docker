FROM centos:7
LABEL maintainer "@hirano00o"

ENV GO_INSTALL_DIR /usr/local
ENV HOME /root
ENV GO_VERSION 1.12.4

# set timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# compile and install vim
RUN rpm --rebuilddb && yum update -y && \
    yum -y install git gcc ncurses-devel make && \
    yum -y install httpd which && \
    rm -rf /var/cache/yum/* && \
    yum clean all

WORKDIR /usr/local/src/
RUN git clone https://github.com/vim/vim.git && \
    cd vim && \
    make && make install && make clean && \
    rm -rf vim

# Your .vimrc
# ADD .vimrc ~/

# get golang and set $GOPATH
WORKDIR ${GO_INSTALL_DIR}
RUN curl https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz > go.tar.gz && \
    tar zxf go.tar.gz && \
    rm go.tar.gz

WORKDIR ${HOME}
RUN echo 'export GOROOT=/usr/local/go' >> ${HOME}/.bashrc
RUN echo 'export GOPATH=${HOME}/go' >> ${HOME}/.bashrc
RUN echo 'export PATH=${GOROOT}/bin:${PATH}' >> ${HOME}/.bashrc
RUN mkdir -p ${HOME}/go/src

# make directory to share with host
RUN mkdir -p /share

CMD [ "/sbin/init" ]