#!/bin/bash
set -o errexit

# init /srv if empty
DIST_FILE=/srv/installation-tag
if [ ! -f $DIST_FILE ]; then
    echo "File $DIST_FILE doesn't exist. Running init..."
    echo docker > $DIST_FILE
    mkdir -p /srv/{clickhouse,grafana,logs,victoriametrics,alertmanager,postgres14}
    echo "Copy plugins and VERSION file"
    chown postgres:postgres /srv/postgres14
    echo "Init Postgres"
    su postgres -c "/usr/lib/postgresql/14/bin/initdb -D /srv/postgres14"
    echo "Temporary start postgres and enable pg_stat_statements"
    su postgres -c "/usr/lib/postgresql/14/bin/pg_ctl start -D /srv/postgres14"
    su postgres -c "psql postgres postgres -c 'CREATE EXTENSION pg_stat_statements SCHEMA public'"
    su postgres -c "/usr/lib/postgresql/14/bin/pg_ctl stop -D /srv/postgres14"
fi

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
