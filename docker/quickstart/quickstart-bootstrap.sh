#!/bin/bash
source /etc/environment

cd /opt/zato/env/qs-1 || exit 1
set -x # enable show commands
$ZATO_BIN quickstart create ${ODB_DATA} --kvdb_password '' --servers "${SERVERS_COUNT:-1}" /opt/zato/env/qs-1/ --odb_type "${ODB_TYPE:-postgresql}" --kvdb_host "${REDIS_HOSTNAME:-localhost}" --kvdb_port 6379
$ZATO_BIN set-ide-password --verbose --password "${ZATO_IDE_PUBLISHER_PASSWORD}" /opt/zato/env/qs-1/server1 |tee /opt/zato/zato_ide_password
[[ -d /opt/zato/env/qs-1/web-admin ]] && sed -i -e 's/dashboard/web-admin/' /opt/zato/update_password.config
$ZATO_BIN from-config /opt/zato/update_password.config
sed -i 's/127.0.0.1:11223/0.0.0.0:11223/g' /opt/zato/env/qs-1/load-balancer/config/repo/zato.config
sed -i 's/gunicorn_workers=2/gunicorn_workers=1/g' /opt/zato/env/qs-1/server1/config/repo/server.conf
[[ -f /opt/zato/env/qs-1/server2/config/repo/server.conf ]] && sed -i 's/gunicorn_workers=2/gunicorn_workers=1/g' /opt/zato/env/qs-1/server2/config/repo/server.conf
set +x # disable show commands
