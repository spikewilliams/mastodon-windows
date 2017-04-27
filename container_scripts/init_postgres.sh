#!/bin/bash

#export PGDATA=/var/pgsql/data
#export XDG_RUNTIME_DIR=/run/root/0


export PGDATA=/var/lib/pgsql/data
sudo -u postgres pg_ctl -D ${PGDATA} init
sudo -u postgres pg_ctl -D ${PGDATA} -l /var/lib/pgsql/postgres.log start
sleep 10s

createdb -U postgres mastodon_development
sudo -u postgres createuser -s root
