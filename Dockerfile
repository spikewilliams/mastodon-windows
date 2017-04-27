FROM spikewilliams/rails4wd
MAINTAINER Bobby Williams spikewilliams@gmail.com



# intall postgres to container
RUN dnf -y install postgresql-server postgresql-contrib postgresql-devel \
    python redis
#    && dnf -y --setopt=tsflags=nodocs update glibc-common \
#    && dnf -y --setopt=tsflags=nodocs reinstall glibc-common \
#    && dnf -y --setopt=tsflags=nodocs clean all --enablerepo='*'

# we need to run a bastardized version of yarn that does not break when linking to a windows-mounted directory
# see https://github.com/yarnpkg/yarn/pull/3097
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo && dnf -y install yarn-0.23.2-1
COPY container_scripts/package-linker.js /usr/share/yarn/lib

RUN mkdir /scripts
COPY container_scripts/*.sh /scripts/
RUN chmod -R a+x /scripts

RUN sh /scripts/install_ruby.sh
RUN sh /scripts/init_postgres.sh

EXPOSE 3000 4000 5432
