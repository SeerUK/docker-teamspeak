#!/bin/bash

if [ ! -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]; then
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] && [ ! -f /data/ts3server.sqlitedb ]; then
    mv /opt/teamspeak/ts3server.sqlitedb /data/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]; then
    rm /opt/teamspeak/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

cd /opt/teamspeak

exec /usr/bin/env LD_LIBRARY_PATH="/opt/teamspeak" /opt/teamspeak/ts3server_linux_amd64 inifile=/data/ts3server.ini logpath=/data/logs disable_db_logging=0
