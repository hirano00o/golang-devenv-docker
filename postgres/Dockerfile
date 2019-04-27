FROM postgres:latest
LABEL maintainer "@hirano00o"

# set timezone
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.utf8

ADD sql/* /docker-entrypoint-initdb.d/
