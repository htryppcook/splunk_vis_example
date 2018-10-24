#!/usr/bin/sh

/bin/bash /sbin/entrypoint.sh start-and-exit
cp -R /install/sample_vis /opt/splunk/etc/apps/
cd /opt/splunk/etc/apps/sample_vis/appserver/static/visualizations/radial_meter
npm install
npm run build
tail -n 0 -f ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log &
    wait
