#!/bin/bash

cp -rf /opt/ts3build/* /opt/ts3server

cd /opt/ts3server

exec /usr/bin/env LD_LIBRARY_PATH="/opt/ts3server" /opt/ts3server/ts3server_linux_amd64 inifile=/opt/ts3server/ts3server.ini logpath=/opt/ts3server/logs disable_db_logging=0
